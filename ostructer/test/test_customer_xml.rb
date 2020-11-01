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

class TestCustomerXml < Test::Unit::TestCase
  
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
  
    @customer = @customer.to_openstruct
    
    puts "=== ostructer:"    
    pp @customer
  end
  
  def test_readers
    assert_equal( 'home', @customer.address[0].typ.to_s )    # attribute
    assert_equal( 'Joe', @customer.first_name.text.to_s )
    assert_equal( 'Joe', @customer.first_name.to_s )          # short-cut (.text)
  end
  
  
end # class TestCustomer


## from the XmlSimple docs
#
#  Elements which only contain text content will simply be represented as a scalar.
#  Where an element has both attributes and text content, the element will be represented
#    as a hash with the text content in the 'content' key:
#
#    <opt>
#      <one>first</one>
#      <two attr="value">second</two>
#    </opt>
#
#    {
#      'one' => 'first',
#      'two' => { 'attr' => 'value', 'content' => 'second' }
#    }
#