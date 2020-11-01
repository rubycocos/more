# encoding: utf-8

module Record

class Base

  def self.fields   ## note: use class instance variable (@fields and NOT @@fields)!!!! (derived classes get its own copy!!!)
    @fields ||= []
  end

  def self.field_names   ## rename to header - why? why not?
    ## return header row, that is, all field names in an array
    ##   todo: rename to field_names or just names - why? why not?
    ##  note: names are (always) symbols!!!
    fields.map {|field| field.name }
  end

  def self.field_types
    ##  note: types are (always) classes!!!
    fields.map {|field| field.type }
  end



  def self.field( name, type=:string )
    num = fields.size  ## auto-calc num(ber) / position index - always gets added at the end
    field = Field.new( name, num, type )
    fields << field

    define_field( field )  ## auto-add getter,setter,parse/typecast
  end

  def self.define_field( field )
    name = field.name   ## note: always assumes a "cleaned-up" (symbol) name
    num  = field.num

    define_method( name ) do
      instance_variable_get( "@values" )[num]
    end

    define_method( "#{name}=" ) do |value|
      instance_variable_get( "@values" )[num] = value
    end

    define_method( "parse_#{name}") do |value|
      instance_variable_get( "@values" )[num] = field.typecast( value )
    end
  end

  ## column/columns aliases for field/fields
  ##   use self <<  with alias_method  - possible? works? why? why not?
  def self.column( name, type=:string ) field( name, type ); end
  def self.columns() fields; end
  def self.column_names() field_names; end
  def self.column_types() field_types; end




  def self.build_hash( values )   ## find a better name - build_attrib? or something?
    ## convert to key-value (attribute) pairs
    ## puts "== build_hash:"
    ## pp values

    ## e.g. [[],[]]  return zipped pairs in array as (attribute - name/value pair) hash
    Hash[ field_names.zip(values) ]
  end



  def self.typecast( new_values )
    values = []

    ##
    ## todo: check that new_values.size <= fields.size
    ##
    ##   fields without values will get auto-filled with nils (or default field values?)

    ##
    ##  use fields.zip( new_values ).map |field,value| ... instead - why? why not?
    fields.each_with_index do |field,i|
       value = new_values[i]   ## note: returns nil if new_values.size < fields.size
       values << field.typecast( value )
    end
    values
  end


  def parse( new_values )   ## use read (from array) or read_values or read_row - why? why not?

    ## todo: check if values overshadowing values attrib is ok (without warning?) - use just new_values (not values)
    @values = self.class.typecast( new_values )
    self  ## return self for chaining
  end


  def values
    ## return array of all record values (typed e.g. float, integer, date, ..., that is,
    ##   as-is and  NOT auto-converted to string
    @values
  end



  def [](key)
    if key.is_a? Integer
      @values[ key ]
    elsif key.is_a? Symbol
      ## try attribute access
      send( key )
    else  ## assume string
      ## downcase and symbol-ize
      ##   remove spaces too -why? why not?
      ##  todo/fix: add a lookup mapping for (string) titles (Team 1, etc.)
      send( key.downcase.to_sym )
    end
  end



  def to_h    ## use to_hash - why? why not?  - add attributes alias - why? why not?
    self.class.build_hash( @values )
  end

  def initialize( **kwargs )
    @values = []
    update( kwargs )
  end

  def update( **kwargs )
    pp kwargs
    kwargs.each do |name,value|
      ## note: only convert/typecast string values
      if value.is_a?( String )
        send( "parse_#{name}", value )  ## note: use parse_<name> setter (for typecasting)
      else  ## use "regular" plain/classic attribute setter
        send( "#{name}=", value )
      end
    end

    ## todo: check if args.first is an array  (init/update from array)
    self   ## return self for chaining
  end
end ## class Base



#########
# alternative class (record) builder

def self.define( super_class=Base, &block )   ## check: rename super_class to base - why? why not?
  builder = Builder.new( super_class )
  if block.arity == 1
    block.call( builder )
    ## e.g. allows "yield" dsl style e.g.
    ##  Record.define do |rec|
    ##     rec.string :team1
    ##     rec.string :team2
    ##  end
    ##
  else
    builder.instance_eval( &block )
    ## e.g. shorter "instance eval" dsl style e.g.
    ##  Record.define do
    ##     string :team1
    ##     string :team2
    ##  end
  end
  builder.to_record
end

end # module Record
