require 'forwardable'
require 'cgi'
require 'date'
require 'logger'

module Ostructer

  VERSION = '0.2'

# Note: for booleans use query access (e.g. address? == true, address? == false)
#   There's no <=> defined for booleans; because <,>,<=,=>, between?,etc. is not possible

# 
# todo: check query access (e.g. address?)

# todo: how to check for nil/null in string value (convert to nil? leave it as literal nil/null?)
#

## todo: use blank slate/basic object (no id? no type?)
#
# undef id and type (possible?)
# class OpenStruct
#    undef id # deprecated in Ruby 1.8; removed in 1.9
#    undef type # same thing
#  end 

#
#
# folded elements (e.g. element with no attributes just content) get returned as string, thus,
#
# to_bool
# to_date
# to_xml    will not be available!!!!! (unless added to String class)
#
# check if to_date exists? in ruby standard

#
#  NB: key.first -> different with Rails or without (without results in more than one letter!!)

class OsBase    # base for OsArray/OsOpenStruct/OsOpenStructNil

  def self.logger
    @@logger ||= Logger.new(STDOUT)
  end
    
  def self.logger=(new_logger)
    @@logger = new_logger
  end

  # todo/fix: needed to avoid method_missing (check why can't derived classes access class method logger?)
  # todo: check - can we have a class and instance method with the same name?
  def logger    
    OsBase.logger
  end


  attr_accessor :parent   # read,write
  attr_accessor :field    # read,write

  def full_dot_path
    path = "#{@field}"
    node = @parent

    ## NOTE: assume if node.parent == nil openstruct is root node    
    while node && node.parent
      if node.is_a?( OsArray )
        path = "#{node.field}" + path      
      else
        path = "#{node.field}." + path
      end
      node = node.parent      
    end
    path
  end

end  # class OsBase


class OsValue < OsBase

  # holds/wraps a string

  def inspect
    "'#{@value.to_s}'"
  end


  def initialize( value, options )
    @value   = value
    @options = options
    
    @parent  = nil
    @field   ="[!unknown_value]"
  end

  def to_openstruct_pass2
    # do nothing (has no children)
  end

  include Comparable
    
  def <=>(other)
    ## todo: check for Float??
    if other.is_a? Numeric
      logger.debug "OsValue <=> Numeric:  #{self.to_i} <=> #{other}"
      self.to_i <=> other      
    elsif other.is_a? String
      logger.debug "OsValue <=> String:  #{self.to_s} <=> #{other}"
      self.to_s <=> other
    else
      logger.debug "OsValue - no <=> defined for type #{other.class}" 
      nil           
    end
    
    ## todo: add bool
  end

  def to_s
    @value
  end
  
  def to_i
    @value.to_i
  end
  
  def to_f
    # NB: assume . as separator; if , is separator (e.g. 12,34) digits after , get lost/truncated
    @value.to_f    
  end
  
  def to_date
    logger.debug "OsValue.to_date >#{@value}< >#{@value.class}<"
    
    new_value = @value     

    # allow entry with delimiters (.-/ ) e.g. 1972/8/25 oder 1972 8 25
    
    if new_value =~ /(\d{4})[\.\-\/ ](\d{1,2})[\.\-\/ ](\d{1,2})/   
      new_value = "#{$1}-#{$2}-#{$3}"
    end 
        
    Date.strptime( new_value, '%Y-%m-%d' )
  end

  def to_bool
    ['true', 't', '1', 'on'].include?( @value.downcase )
  end

end # class OsValue


class OsArray < OsBase
  extend Forwardable

  include Enumerable
      
  def_delegators :@ary, :each, :[], :size   


  def inspect
    buf = "["
    @ary.each_with_index do |value, i|
      buf << ", " if i > 0
      buf << value.inspect
    end
    buf << "]"
    buf
  end

  def pretty_print( q )
    q.group( 1, '[', ']' ) do
      @ary.each_with_index do |value, i|
        q.comma_breakable if i > 0   # comma_breakable => text ','; breakable
        q.pp value      
      end
    end
  end
  
                    
  def initialize( ary, options )
    @ary     = ary
    @options = options
    
    @parent = nil
    @field  = "[!unknown_array]"
  end
  
  def to_openstruct_pass2
    self.each_with_index do | el, index |
      if el.is_a?( OsOpenStruct ) || el.is_a?( OsArray ) || el.is_a?( OsValue )
        el.field  = "[#{index}]"
        el.parent = self
      end
      el.to_openstruct_pass2
    end
  end
  
end  # class OsArray



class OsOpenStructNil < OsBase
    
  def initialize( parent, field, options )
    @parent = parent
    @field  = "!#{field}"  # mark missing field with starting ! (exclamation mark)
    @options = options
  end 
  
  def nil?
    logger.debug "calling OsNil#nil?"
    true
  end
  
  def to_s
    logger.debug "calling OsNil#to_s"
    nil
  end
  
  def to_i
    logger.debug "calling OsNil#to_i"
    nil
  end

  def to_f
    logger.debug "calling OsNil#to_f"
    nil
  end

  def to_date
    logger.debug "calling OsNil#to_date"
    nil
  end

  def to_bool
    logger.debug "calling OsNil#to_bool"
    nil
  end


  def method_missing( mn, *args, &blk ) 
         
    ## only allow read-only access (no arguments)
    if args.length > 0    # || mn[-1].chr == "=" 
      logger.warn "OsOpenStructNil - undefined method '#{mn}' with #{args.length} arg(s)"
      return super      # super( mn,*args,&blk )
    end              
    
    mn = mn.to_s
    
    logger.warn "OsOpenStructNil - feld '#{mn}' nicht gefunden using path '#{full_dot_path}'; returning OsOpenStructNil"
    OsOpenStructNil.new( self, mn, @options )
  end

end   # end class OsOpenStructNil



class OsOpenStruct < OsBase

  def inspect
    ## todo: add options (e.g. lets you output default dump not simpliefied;
    ##    or configure simplified output e.g. add type/class, sort keys, etc.)
    
    ## buf = "#<#{self.class.to_s}"
    buf = "{"
    @hash.each_with_index do |(key,value),i|  
      buf << ", " if i > 0
      buf << "#{key}: #{value.inspect}"
    end
    ## buf << ">"
    buf << "}"
    buf
  end

  def pretty_print( q )
    ## todo: check code for seplist
    #    docu says: seplist(list, sep=nil, iter_method=:each) {|element| ...}
    #              adds a separated list. The list is separated by comma with breakable space, by default.
    # tdo: check code and docu for group 
    # 
    
    ##  used pp_hash from pp.rb
    q.group( 1, '{', '}') do
      @hash.each_with_index do |(key,value),i|
#        q.group do   # check: add extra grouping??
          q.comma_breakable if i > 0   # comma_breakable => text ','; breakable
          # q.pp key  # don't quote string
          q.text "#{key}: "
          q.group(1) do
            q.breakable ''
            q.pp value
          end
 #       end
      end
    end
  end


  def initialize( hash_in, options )
    @parent = nil
    @field  = "[!unknown_hash]"

    @options = options
    @mapper  = options[ :mapper ]   # allows you to map/convert tags/attributes (e.g. shorten com.java.lang to java etc.)
    @hash = {}
 
    ## fix: can we change the hash-in-place?? don't create a new one
    
    # todo: add hook for normalize keys  (downcase first letter, strip packages, etc.)    
    hash_in.each do |key,value|
      
      key = @mapper.call( key ) if @mapper
      
      key = key[0...1].downcase + key[1..-1]   # downcase first letter (e.g. Address to address)

      @hash[ key ] = value  
    end
  end

  def to_openstruct_pass2   # link up: set parent and field    
    @hash.each do |key,value|
      if value.is_a?( OsOpenStruct ) || value.is_a?( OsArray ) || value.is_a?( OsValue )
        value.field  = key.to_s
        value.parent = self
      end
      value.to_openstruct_pass2
    end    
    # logger.debug "after MyOpenStruct#to_openstruct_pass2  parent=#{parent.nil? ? 'nil' : parent.object_id}, field=#{field}" 
  end
  
  def has_key?( key )
    # NOTE: use has_key? instead of nil? to avoid warnings in log that are expected if fields are missing
    @hash.has_key?( key.to_s )
  end
  
  def fetch( key, default = nil )
    @hash.fetch( key, default)
  end
  
  include Comparable
    
  def <=>(other)
    
    ## fix: check if struct has short-cut value (e.g. text); short-cut value might not exist
    ## fix/todo: add bool
    
    if other.is_a? Numeric
      logger.debug "OsOpenStruct <=> Numeric:  #{self.to_i} <=> #{other}"
      self.to_i <=> other      
    elsif other.is_a? String
      logger.debug "OsOpenStruct <=> String:  #{self.to_s} <=> #{other}"
      self.to_s <=> other
    else
      logger.debug "OsOpenStruct - no <=> defined for type #{other.class}" 
      nil           
    end    
  end

  def method_missing( mn, *args, &blk )
      
    ## only allow read-only access (no args)
    if args.length > 0   # || mn[-1].chr == "="
      logger.warn "OsOpenStruct - undefined method '#{mn}' with #{args.length} arg(s)"
      return super   # super( mn,*args, &blk )      
    end
 
    mn = mn.to_s
    
    ## convenience property for boolean check
    if mn[-1].chr == "?" 
      mn = mn[0..-2]  # cut of trailing ?      
      if @hash.has_key?(mn)               
        value = @hash.fetch( mn ).fetch( 'text' )
        
        ## todo: check for value w/o text (possible? if forceContent == false??)
        
        logger.debug "OsOpenStruct - boolean feld '#{mn}' with value '#{value}' returns #{value=='1'}"
                
        return value == "1"  # return - add more boolean values (use to_bool)
      else
        logger.warn "OsOpenStruct - boolean feld '#{mn}' nicht gefunden in Hash using path '#{full_dot_path}'; returning OsOpenStructNil"
        OsOpenStructNil.new( self, mn+"?", @options )  # return
      end        
    else       
      if @hash.has_key?(mn)
        @hash[mn]
      else
        logger.warn "OsOpenStruct - feld '#{mn}' nicht gefunden in Hash using path '#{full_dot_path}'; returning OsOpenStructNil"
        ## pp self
        OsOpenStructNil.new( self, mn, @options )
      end
    end  
  end
    
  
##  def to_xml
##    logger.debug "calling OsOpenStruct#to_xml"
##    ## todo: check if CGI module is included
##    ## todo: use another unescape method for xml entities??
##    CGI.unescapeHTML( internal_value )    
##  end
    
  def to_s
    internal_value.to_s
  end
  
  def to_i
    internal_value.to_i
  end

  def to_f
    internal_value.to_f
  end

  def to_date
    internal_value.to_date
  end

  def to_bool
    internal_value.to_bool
  end
  
private
   def internal_value
    if @hash.has_key?('text')
      @hash.fetch( 'text' )      
    else
      logger.warn "feld 'text' nicht gefunden (called internal_value())"
      OsOpenStructNil.new( self, 'text', @options )
    end          
  end
  
end # class OsOpenStruct


end  # module Ostructer


################################
##
## extensions to core/built-in classes (Object, Array, Hash)
##

class Object
  def to_openstruct( options={} )
    
    # pass 1: construct data structure using new classes (OsArray, OsOpenStruct, OsValue) 
    # convert Array  to OsArray
    # convert Hash   to OsOpenStruct
    # convert String to OsValue
        
    newself = self.to_openstruct_pass1( options )    
    newself.to_openstruct_pass2         # pass 2: link up parents (reverse link)
    newself
  end
end

class String
  def to_openstruct_pass1( options )
    Ostructer::OsValue.new( self, options )
  end  
end

class Array
  def to_openstruct_pass1( options )
    mapped = map{ |el| el.to_openstruct_pass1( options ) }
    Ostructer::OsArray.new( mapped, options )
  end
end

class Hash
  def to_openstruct_pass1( options )
    mapped = {}
    each{ |key,value | mapped[key.to_s] = value.to_openstruct_pass1( options ) }
    Ostructer::OsOpenStruct.new( mapped, options )
  end
end