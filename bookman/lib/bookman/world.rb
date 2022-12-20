# encoding: utf-8

module Bookman

  class WorldConfig < Config

    def initialize( hash ) super; end

    def collection() 'world'; end

    ############
    # Bookfile
    # -- remote
    def bookfile_url()
      ## note: for now always return world.rb
      ##   use country specific bookfiles ??   allow selection of package,how?? why,why not??
      "https://github.com/book-templates/bookfile/raw/master/world.rb"
    end

    ########
    # Datafile
    # -- remote
    def datafile_url() "https://github.com/openmundi/datafile/raw/master/#{setup}.rb"; end

    #######
    # Database
    def db_path() "#{build_dir}/#{collection}/#{setup}/#{collection}.db"; end
    def create_db!()  WorldDb.create_all;  end


    ######################
    ## rename to book_dir ?? why, why not? - split zip into book_dir and book_templates_dir why? why not?
    def book_templates_unzip_dir()  "#{build_dir}/#{collection}/#{setup}/book";  end

  end # class WorldConfig


  class Bookman
    def self.create_world_book_for( setup, opts={} )
      config = WorldConfig.new( setup: setup )
      Bookman.new( config )
    end
  end  # class Bookman

end # module Bookman
