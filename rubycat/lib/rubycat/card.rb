# encoding: utf-8

module RubyCat


class Card

  ## read only
  attr_reader :name           # e.g. sinatra
  attr_reader :gem_url        # e.g. https://rubygems.org/gems/sinatra
  attr_reader :github_url     # e.g. https://github.com/sinatra/sinatra
  attr_reader :categories     # e.g. 

  attr_reader :desc   # info/blurb/description/summary  (use summary ??)
  attr_reader :latest_version    ## as string
  attr_reader :latest_version_downloads 
  attr_reader :downloads    ## total downloads
  attr_reader :deps   # runtime dependencies as a string for now (activerecord, activesupport etc.)


  def to_hash
    { name:           @name,
      gem_url:        @gem_url,
      github_url:     @github_url,
      categories:     @categories,
      desc:           @desc,
      latest_version: @latest_version,
      latest_version_downloads: @latest_version_downloads,
      downloads:      @downloads,
      deps:           @deps }
  end



  def initialize( card )
    @categories = card.categories
    @name = nil


    github_link = card.links.find {|it| it[0].include?( ':octocat:') }
    
    if github_link
      @github_url = github_link[1]
      
      ## check if org (shortcut)
      uri = URI.parse( @github_url )
        puts "  uri.path: #{uri.path}"
        ##
        names = uri.path[1..-1].split('/')  ## cut off leading / and split
        pp names

        ## if single name (duplicate - downcased! e.g. Ramaze => Ramaze/ramaze)
        if names.size == 1
          @github_url += "/#{names[0].downcase}"
          @name = names[0].downcase
        else
          @name = names[1]
        end
        puts "github_url: #{@github_url}"
    else
        puts "*** no github_url found"
        pp card
    end

    gem_link  = card.links.find {|it| it[0] == ':gem:' }
    if gem_link
      @gem_url = gem_link[1]
      puts "gem_url: #{@gem_url}"

      uri = URI.parse( @gem_url )
      names = uri.path[1..-1].split('/')  ## cut off leading / and split
      pp names
      ## assume last name entry is name of gem
      @name = names[-1]
    else
      puts "*** no gem_url found"
      pp card
    end
  end


  def sync_gems_info( json )
    @desc                      = json['info']
    @latest_version            = json['version']
    @latest_version_downloads  = json['version_downloads']
    @downloads                 = json['downloads']

    deps_runtime = json['dependencies']['runtime']
    if deps_runtime && deps_runtime.size > 0
      deps = []
      deps_runtime.each do |dep|
        deps << dep['name']
      end
      @deps = deps.join(', ')
    else
      @deps = nil
    end
  end # method sync_gems_info

end  ##  class Card



end   # module RubyCat
