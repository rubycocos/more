# encoding: utf-8


# 3rd party gems

require 'fetcher'

# our own code

require 'preproc/version'   # let version always go first



module Preproc

  #############
  ### todo/fix: use/find better name? - e.g. Fetcher.read_utf8!()  move out of global ns etc.
  ##    move to Fetcher gem; (re)use!!! remove here
  ###   e.g. use Fetch.read_utf8!()  e.g. throws exception on error
  ##                   read_blob!()
  def self.fetcher_read_utf8!( src )
    worker = Fetcher::Worker.new
    res = worker.get_response( src )
    if res.code != '200'
      puts "sorry; failed to fetch >#{src} - HTTP #{res.code} - #{res.message}"
      exit 1
    end

    ###
    # Note: Net::HTTP will NOT set encoding UTF-8 etc.
    #  will be set to ASCII-8BIT == BINARY == Encoding Unknown; Raw Bytes Here
    #  thus, set/force encoding to utf-8
    txt = res.body.to_s
    txt = txt.force_encoding( Encoding::UTF_8 )
    txt
  end


class IncludeReader

  ###
  ## concat files w/ @include directive
  include LogUtils::Logging

  def self.from_url( src )
    uri = URI.parse( src )
    text = Preproc.fetcher_read_utf8!( src )

    base_path = uri.path[0..uri.path.rindex('/')]  # get everything upto incl. last slash (/)
    self.new( text, base: "#{uri.scheme}://#{uri.host}:#{uri.port}#{base_path}" )
  end


  def initialize( text, opts={} )
    @text = text
    @base = opts[:base]

    logger.debug("  base: #{@base}")
  end

  def read
    preproc( @text )
  end


private
  def preproc( text )
    buf = ''
    text.each_line do |line|
      ### e.g. allows 
      ##  @include 'test'  or
      ##  @INCLUDE "test"
      ##  note: for now we strip (allow) leading and trailing spaces (e.g. [ ]*)
      ##
      ##  todo/allow
      ##  @include( test ) - alternative syntax - why? why not?
      if line =~ /^[ ]*@include[ ]+("|')(.+?)\1[ ]*$/i
        logger.info( "  try to include '#{$2}'")
        ## buf << preproc( 'include here' )
        buf << preproc( read_include( $2 ) )
        buf << "\n"
      else
        buf << line
        buf << "\n"
      end
    end
    buf
  end

  def read_include( name )
    ## for now assume fetch via url
    ## note: assume partial e.g. add leading underscore (_)
    ##   e.g. test => _test.ini

    src = "#{@base}_#{name}.ini"
    logger.info( "  try to fetch include #{src}")

    Preproc.fetcher_read_utf8!( src )
  end

end # class IncludeReader


end  # module Preproc


## add top level (convenience) alias
InclPreproc = Preproc::IncludeReader
IncludePreproc = Preproc::IncludeReader



## say hello
puts Preproc.banner   if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)

