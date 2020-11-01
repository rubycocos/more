require 'logger'
require 'pp'

require 'rubygems'
require 'xmlsimple'

# LIB_PATH = File.expand_path( File.dirname( 'lib' ) )
# $LOAD_PATH.unshift(LIB_PATH)

require 'lib/ostructer.rb'

  
def test_keep_root
  fn   = 'test/config.xml'
  opts = { 'ContentKey' => 'text',
             'ForceArray' => false,
             'ForceContent' => true,
             'KeepRoot' => true } 
      
  doc = XmlSimple.xml_in( fn, opts )
    
  puts "=== xmlsimple:"    
  pp doc
end

def test_parse_status
  fn   = 'test/status.xml'
  opts = { 'ContentKey' => 'text',
             'ForceArray' => false } 
      
  statuses = XmlSimple.xml_in( fn, opts )
    
  puts "=== xmlsimple:"    
  pp statuses
  
  statuses = statuses.to_openstruct
  puts "=== ostructer:"    
  pp statuses
end

if __FILE__ == $0  
  # test_keep_root()
  test_parse_status()
end
