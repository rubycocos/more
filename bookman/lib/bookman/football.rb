# encoding: utf-8

module Bookman

  class FootballConfig < Config

    def initialize( hash ) super; end

    def collection() 'football'; end

    ############
    # Bookfile
    # -- remote
    def bookfile_url()
      ## note: for now always return football.rb
      ##   use setup/layout-specific bookfiles??   allow selection of package,how?? why,why not??
      "http://github.com/book-templates/bookfile/raw/master/football.rb"
    end

    ########
    # Datafile
    # -- remote
    def datafile_url() "http://github.com/openfootball/datafile/raw/master/#{setup}.rb"; end

    #######
    # Database
    def db_path() "#{build_dir}/#{collection}/#{setup}/#{collection}.db"; end

    def create_db!()
      SportDb.create_all
      SportDb.read_builtin   ## note: load built-in datasets (e.g. seasons etc.)
    end

    ####
    # Book Templates
    ## rename to book_dir ?? why, why not? - split zip into book_dir and book_templates_dir why? why not?
    def book_templates_unzip_dir()  "#{build_dir}/#{collection}/#{setup}/book";  end

  end # class FootballConfig


  class Bookman
    def self.create_football_book_for( setup, opts={} )
      config = FootballConfig.new( setup: setup )
      Bookman.new( config )
    end
  end  # class Bookman

end # module Bookman
