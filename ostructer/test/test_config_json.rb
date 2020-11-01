require 'test/unit'
require 'logger'
require 'pp'

require 'rubygems'
require 'active_support'




# LIB_PATH = File.expand_path( File.dirname( 'lib' ) )
# $LOAD_PATH.unshift(LIB_PATH)

require 'lib/ostructer.rb'


class TestConfigJson < Test::Unit::TestCase
  
  def setup
    fn   = 'test/config.json'
      
    @doc = ActiveSupport::JSON.decode( File.read( fn ) )
        
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
  
    Ostructer::OsBase.logger = logger
  
    @doc = @doc.to_openstruct
    
    puts "=== ostructer:"    
    pp @doc
  end
  
  def test_readers    
    assert_equal( 'sahara', @doc.config.server[0].name.to_s )    # attribute
    assert_equal( '10.0.0.101', @doc.config.server[0].address[0].to_s ) 
    assert( '.text shortcut String <=>', @doc.config.server[0].address[0] == '10.0.0.101' )
  end
  
  def test_full_dot_path
    assert_equal( 'config.logdir', @doc.config.logdir.full_dot_path )
    assert_equal( 'config.server', @doc.config.server.full_dot_path )
    assert_equal( 'config.server[0]', @doc.config.server[0].full_dot_path )
    assert_equal( 'config.server[0].name', @doc.config.server[0].name.full_dot_path )
    assert_equal( 'config.server[0].address', @doc.config.server[0].address.full_dot_path )
    assert_equal( 'config.server[0].address[0]', @doc.config.server[0].address[0].full_dot_path )
  end
  
  def test_missing
    assert_equal( '!one.!two.!three',  @doc.one.two.three.full_dot_path )
  end
  
  def test_read_only
    assert_raises( NoMethodError ) {  @doc.config.server[0].name = 'gobi'  }     # write access existing field
    assert_raises( NoMethodError ) {  @doc.config.one.two.three = 'missing' }    # write access missing field
  end
    
end # class TestConfig
