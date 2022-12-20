# encoding: utf-8

module Bookman

  class Config

    def initialize( hash )
      @hash = hash

### add source_url  e.g. https://github.com ?? - why, why not???

      @build_dir  = hash[:build_dir] || './build'  ## note: defaults to ./build
      @setup      = hash[:setup]
    end

    def build_dir()  @build_dir;   end
    def setup()      @setup;       end   ## e.g. at, franken, worldcup, etc.

    ######
    # Datafile
    # -- local
    def datafile_dir()  "#{build_dir}/#{collection}/#{setup}";  end
    def datafile_path() "#{datafile_dir}/Datafile";  end

    ######
    # Bookfile    -- allow multiple (more than one) bookfiles - how? why, why not???
    # -- local
    #
    # todo: move bookfile_dir to unzip dir (e.g. move Bookfile into /book) - why, why not???
    def bookfile_dir()  "#{build_dir}/#{collection}/#{setup}";  end
    def bookfile_path() "#{bookfile_dir}/Bookfile";  end
  end

end # module Bookman

