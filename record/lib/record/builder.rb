# encoding: utf-8

## (record) builder mini language / domain-specific language (dsl)

module Record

class Builder  # check: rename to RecordDefinition or RecordDsl or similar - why? why not?

  ###################################
  ## add simple logger with debug flag/switch
  #
  #  use Parser.debug = true   # to turn on
  #
  #  todo/fix: use logutils instead of std logger - why? why not?

  def self.build_logger()
    l = Logger.new( STDOUT )
    l.level = :info    ## set to :info on start; note: is 0 (debug) by default
    l
  end
  def self.logger() @@logger ||= build_logger; end
  def logger()  self.class.logger; end



  def initialize( super_class=Base )
    @clazz = Class.new( super_class )
  end

  def field( name, type=:string )   ## note: type defaults to string
    logger.debug "  adding field >#{name}< with type >#{type}<"
    @clazz.field( name, type )  ## auto-add getter and setter
  end

  def string( name )
    logger.debug "  adding string field >#{name}<"
    field( name, :string )
  end

  def integer( name )  ## use number for alias for integer - why? why not???
    logger.debug "  adding integer number field >#{name}<"
    field( name, :integer )
  end

  def float( name )
    logger.debug "  adding float number field >#{name}<"
    field( name, :float )
  end


  def to_record   ## check: rename to just record or obj or finish or end something?
    @clazz
  end
end # class Builder
end # module Record
