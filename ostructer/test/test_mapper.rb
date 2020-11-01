require 'test/unit'
require 'logger'
require 'pp'

require 'rubygems'
require 'xmlsimple'

# LIB_PATH = File.expand_path( File.dirname( 'lib' ) )
# $LOAD_PATH.unshift(LIB_PATH)

require 'lib/ostructer.rb'

## NB: XmlSimple -> ForceArray is true by default (turn it off!!)
##

class TestMapper < Test::Unit::TestCase
    
  def setup
    fn   = 'test/customer.xml'
    opts = { 'ContentKey' => 'text',
             'ForceArray' => false,
             'ForceContent' => true } 
     
    @customer = XmlSimple.xml_in( fn, opts )
    
    puts "=== xmlsimple:"    
    pp @customer
    
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    
    Ostructer::OsBase.logger = logger
  
    mapper = Proc.new do |key|
      ## puts "calling mapper('#{key}')"
      key = 'fn'  if key == 'first_name'
      key = 'zip' if key == 'zip_code'
      key     
    end
  
    @customer = @customer.to_openstruct( :mapper => mapper )
    
    # puts "=== ostructer:"    
    # pp @customer
  end
  
  def test_readers
    assert_equal( 'home', @customer.address[0].typ.to_s )    # attribute
    assert_equal( 'Joe', @customer.fn.text.to_s )
    assert_equal( 'Joe', @customer.fn.to_s )          # short-cut (.text)
    assert_equal( 11234, @customer.address[0].zip.to_i ) 
  end
  
end # class TestCustomer

