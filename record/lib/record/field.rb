# encoding: utf-8


module Record

  ## note on naming:
  ##   use naming convention from awk and tabular data package/json schema for now
  ##    use - records  (use rows for "raw" untyped (string) data rows )
  ##        - fields  (NOT columns or attributes) -- might add an alias later - why? why not?

  class Field  ## ruby record class field


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


    attr_reader :name, :type

    ## zero-based position index (0,1,2,3,...)
    ## todo: use/rename to index/idx/pos - add an alias name - why?
    attr_reader :num

    def initialize( name, num, type )
      ## note: always symbol-ify (to_sym) name and type

      ## todo: add title or titles for header field/column title as is e.g. 'Team 1' etc.
      ##   incl. numbers only or even an empty header title
      @name = name.to_sym
      @num  = num

      if type.is_a?( Class )
        @type = type    ## assign class to its own property - why? why not?
      else
        @type = Type.registry[type.to_sym]
        if @type.nil?
          logger.warn "!!!! warn unknown type >#{type}< - no class mapping found; add missing type to Record::Type.registry[]"
          ## todo/fix:  raise exception!!!!
        end
      end
    end


    def typecast( value )  ## cast (convert) from string value to type (e.g. float, integer, etc.)
      ## todo: add typecast to class itself (monkey patch String/Float etc. - why? why not)
      ##  use __typecast or something?
      ##  or use a new "wrapper" class  Type::String or StringType - why? why not?

      ## convert string value to (field) type
      if @type == String
        value   ## pass through as is
      elsif @type == Float
        ## note: allow/check for nil values - why? why not?
        float = (value.nil? || value.empty?) ? nil : value.to_f
        logger.debug "typecast >#{value}< to float number >#{float}<"
        float
      elsif @type == Integer
        number = (value.nil? || value.empty?) ? nil : value.to_i(10)   ## always use base10 for now (e.g. 010 => 10 etc.)
        logger.debug "typecast >#{value}< to integer number >#{number}<"
        number
      else
        ## todo/fix: raise exception about unknow type
        logger.warn "!!!! unknown type >#{@type}< - don't know how to convert/typecast string value >#{value}<"
        logger.warn @type.inspect
        value
      end
    end
  end  # class Field



  class Type   ## todo: use a module - it's just a namespace/module now - why? why not?

    ##  e.g. use Type.registry[:string] = String etc.
    ##   note use @@ - there is only one registry
    def self.registry() @@registry ||={} end

    ## add built-in types:
    registry[:string]  = String
    registry[:integer] = Integer   ## todo/check: add :number alias for integer? why? why not?
    registry[:float]   = Float
    ## todo: add some more
  end  # class Type


end # module Record
