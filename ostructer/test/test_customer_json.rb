require 'test/unit'
require 'logger'
require 'pp'

require 'rubygems'
require 'active_support'

# LIB_PATH = File.expand_path( File.dirname( 'lib' ) )
# $LOAD_PATH.unshift(LIB_PATH)

require 'lib/ostructer.rb'

## NB: XmlSimple -> ForceArray is true by default (turn it off!!)
##

class TestCustomerJson < Test::Unit::TestCase
  
  def setup
    fn   = 'test/customer.json'
     
    @doc = ActiveSupport::JSON.decode( File.read( fn ) )
    
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    
    Ostructer::OsBase.logger = logger
  
    @doc = @doc.to_openstruct
    
    puts "=== ostructer:"    
    pp @doc
  end
  
  def test_readers
    assert_equal( 'home', @doc.customer.address[0].typ.to_s )    # attribute
    assert_equal( 'Joe', @doc.customer.first_name.to_s )          
  end
  
  
end # class TestCustomerJson