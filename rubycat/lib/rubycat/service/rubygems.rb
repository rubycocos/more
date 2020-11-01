# encoding: utf-8


### add to RubyCat module/namespace - why?? why not??


class RubyGemsService

  def initialize
    @worker   = Fetcher::Worker.new
    @api_base = 'http://rubygems.org/api/v1'
  end

  def info( name )
    api_url = "#{@api_base}/gems/#{name}.json"

    ### fix/todo: add read_json! -- !!!! to fetcher
    txt = @worker.read_utf8!( api_url )
    pp txt

    json = JSON.parse( txt )
    ## pp json
    json   ## return parsed json hash (or raise HTTP excep)
  end
end  ## class RubyGemsService

