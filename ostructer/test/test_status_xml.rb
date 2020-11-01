require 'test/unit'
require 'logger'
require 'pp'

require 'rubygems'
require 'xmlsimple'

# LIB_PATH = File.expand_path( File.dirname( 'lib' ) )
# $LOAD_PATH.unshift(LIB_PATH)

require 'lib/ostructer.rb'


class TestStatusXml < Test::Unit::TestCase
  
  def setup
    fn   = 'test/status.xml'
    opts = { 'ContentKey' => 'text',
             'ForceArray' => [ 'status'] } 
      
    @doc = XmlSimple.xml_in( fn, opts )
    
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
  
    Ostructer::OsBase.logger = logger
  
    @doc = @doc.to_openstruct
    
    puts "=== ostructer:"    
    pp @doc
  end
  
  def test_readers    
    assert_equal( 'Sat Aug 09 05:38:12 +0000 2008', @doc.status[0].created_at.to_s )  
    assert_equal( false,                            @doc.status[0].truncated.to_bool )
    assert_equal( 'John Nunemaker',                 @doc.status[0].user.name.to_s )
    assert_equal( 486,                              @doc.status[0].user.followers_count.to_i ) 
  end  
  
  def test_full_dot_path
    assert_equal( 'status[0].created_at',           @doc.status[0].created_at.full_dot_path )  
    assert_equal( 'status[0].truncated',            @doc.status[0].truncated.full_dot_path )
    assert_equal( 'status[0].user.name',            @doc.status[0].user.name.full_dot_path )
    assert_equal( 'status[0].user.followers_count', @doc.status[0].user.followers_count.full_dot_path ) 
  end
  
  def test_missing
    assert_equal( '!one.!two.!three',  @doc.one.two.three.full_dot_path )
  end
      
end # class TestStatusXml