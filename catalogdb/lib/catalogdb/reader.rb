# encoding: utf-8


module CatalogDb


class CardReader

  include LogUtils::Logging


  Card = Struct.new( :links, :categories )  ## use cats for categories - why? why not?


  def self.from_url( src )   # note: src assumed a string
    worker = Fetcher::Worker.new
    self.from_string( worker.read_utf8!( src ) )
  end

  def self.from_file( path )
    self.from_string( File.read_utf8( path ) )
  end

  def self.from_string( text )
    self.new( text )
  end


  def initialize( text )
    @text = text
  end



## example:
## - [Sinatra HQ](http://sinatrarb.com)

  LINK_ENTRY_REGEX =  /\[
                         (?<title>[^\]]+)    # 1st capture group (title)
                       \]
                       \(
                         (?<url>[^\)]+)      # 2nd capture group (url)
                       \)
                     /x


  def read

    cards = []
    stack  = []   ## header/heading stack;  note: last_stack is stack.size; starts w/ 0


    # note: cut out; remove all html comments e.g. <!-- -->
    #   supports multi-line comments too (e.g. uses /m - make dot match newlines)
    text = @text.gsub( /<!--.+?-->/m, '' )  ## todo/fix: track/log cut out comments!!!

    text.each_line do |line|

      logger.debug "line: >#{line}<"
      line = line.rstrip  ## remove (possible) trailing newline

      ## todo/fix: add to event reader too!!!  - Thanks/Meta
      break if line =~ /^## (More|Thanks|Meta)/   #  stop when hitting >## More< or Thanks or Meta section
      next  if line =~ /^\s*$/      #  skip blank lines

      m = nil
      if line =~ /^[ ]*(#+)[ ]+/    ## heading/headers - note: must escpape #
          s = StringScanner.new( line )
          s.skip( /[ ]*/ )  ## skip whitespaces
          markers = s.scan( /#+/)
          level   = markers.size
          s.skip( /[ ]*/ )  ## skip whitespaces
          title   = s.rest.rstrip
          
          logger.debug " heading level: #{level}, title: >#{title}<"

          level_diff = level - stack.size

          if level_diff > 0
            logger.debug "[CardReader]    up  +#{level_diff}"
            if level_diff > 1
              logger.error "fatal: level step must be one (+1) is +#{level_diff}"
              fail "[CardReader] level step must be one (+1) is +#{level_diff}"
            end
          elsif level_diff < 0
            logger.debug "[CardReader]    down #{level_diff}"
            level_diff.abs.times { stack.pop }
            stack.pop
          else
            ## same level
            stack.pop
          end
          stack.push( [level,title] )
          logger.debug "  stack: #{stack.inspect}"

      elsif line =~ /^([ ]*)-[ ]+/     ## list item

        ## check indent level
        ##  note: skip sub list items for now (assume 2 or more spaces)
        indent = $1.to_s
        if indent.length >= 2
          logger.debug "  *** skip link entry w/ indent #{indent.length}: >#{line}<"
        elsif( m=LINK_ENTRY_REGEX.match( line ) )
          logger.debug " link entry: #{line}"

          s = StringScanner.new( line )
          s.skip( /[ ]*-[ ]*/ )  ## skip leading list


          ## collect links e.g.
          ## [["Lotus HQ", "http://lotusrb.org"],
          ##  [":octocat:", "https://github.com/lotus"],
          ##  [":gem:", "https://rubygems.org/gems/lotusrb"],
          ##  [":book:", "http://rubydoc.info/gems/lotusrb"]]

          links = s.rest.scan( LINK_ENTRY_REGEX )
          pp links

          categories = stack.map {|it| it[1] }.join(' › ')
          logger.debug "  categories: #{categories}"

          card = Card.new( links, categories )
          ## pp card
          cards << card
        else
          logger.debug "  *** skip list item line: #{line}"
        end
      else
        logger.debug "  *** skip line: #{line}"
      end
    end
    
    cards
  end

end # class CardReader

end # module CatalogDb
