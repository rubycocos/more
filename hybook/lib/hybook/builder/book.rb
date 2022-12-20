# encoding: utf-8

###
# book builder
#
#  - fix: build book structure in memory only  (and use JekyllWriter to write/render to disk!!!)
#  -- independent of jekyll (e.g. static site compiler)

#
#
# -- fix: use our own Page model or better Part / Section / etc. !!!!
#  -- do NOT use TextUtils::Page --> use in writer/render when content gets mapped!!!

#
#
#  fix: remove jekyll specific stuff
#   -- move to jekyll writer

class BookBuilder

  def inline?()   @inline;    end
  def title()     @title;     end
  def layout()    @layout;    end
  def pages_dir() @pages_dir; end


  def initialize( user_pages_dir, opts={} )
    
    #
    #
    #  fix: move user_pages_dir to opts ?? or remove
    #    only use for writer/renderer later
    
    @pages_dir = user_pages_dir   # add user_ to avoid conflict w/ attrib

    @inline    = opts[:inline ] == true ? true : false   # all-in-one page version or multi-page?

    @title     = opts[:title]  || 'Book Title Here'
    @layout    = opts[:layout] || 'default'


    ## if @inline create all-in-one book(.html) page
    if inline?
      path = "#{pages_dir}/book.md"
      puts "[book] create all-in-one book page (#{path})"

      ## add frontmatter

      page_opts = { frontmatter: {
                       layout: layout,
                       title:  title,
                       permalink: '/book.html' } }

      TextUtils::Page.create( path, page_opts ) do |page|
        ## do nothing for now
      end
    end
  end


  ### fix: change to part/chapter/section/etc. ??

  def page( name, opts={} )

    # add fallbacks/defaults
    opts[:title] ||= 'Page Title Here'
    opts[:id]    ||= TextUtils.slugify( @title )   ## add page/section counter to generated fallback id/anchor

    if inline?
      path = "#{pages_dir}/book.md"
      puts "[book] update all-in-one book page -- #{name} (#{path})"

      page_opts = {}.merge( opts )  ## for now pass along all opts; no built-in/auto-added opts -- in the future add page/section counter or similar, for example?
      TextUtils::Page.update( path, page_opts ) do |page|
        yield( page )
      end
    else
      path = "#{pages_dir}/#{name}.md"
      puts "[book] create page #{name} (#{path})"

      page_opts = { frontmatter: {
                       layout:    layout,                 # e.g. 'book'
                       title:     opts[:title],            # e.g. 'The Free Beer Book'
                       permalink: "/#{opts[:id]}.html"      # e.g. '/index.html'
                  }}
      page_opts = page_opts.merge( opts )   ## pass along all opts

      TextUtils::Page.create( path, page_opts ) do |page|
        yield( page )
      end
    end
  end

end  # class BookBuilder

