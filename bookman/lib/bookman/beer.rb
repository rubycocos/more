# encoding: utf-8

module Bookman

  class BeerConfig < Config

    def initialize( hash ) super; end

    def collection() 'beer'; end

    ############
    # Bookfile
    # -- remote
    def bookfile_url()
      ## note: for now always return beer.rb
      ##   use setup/layout-specific bookfiles??   allow selection of package,how?? why,why not??
      "http://github.com/book-templates/bookfile/raw/master/beer.rb"
    end

    ########
    # Datafile
    # -- remote
    def datafile_url() "http://github.com/openbeer/datafile/raw/master/#{setup}.rb"; end

    #######
    # Database
    def db_path() "#{build_dir}/#{collection}/#{setup}/#{collection}.db"; end
    def create_db!()  BeerDb.create_all;  end

    ####
    # Book Templates
    ## rename to book_dir ?? why, why not? - split zip into book_dir and book_templates_dir why? why not?
    def book_templates_unzip_dir()  "#{build_dir}/#{collection}/#{setup}/book";  end

  end # class BeerConfig


  class Bookman
    def self.create_beer_book_for( setup, opts={} )
      config = BeerConfig.new( setup: setup )
      Bookman.new( config )
    end
  end  # class Bookman

end # module Bookman
