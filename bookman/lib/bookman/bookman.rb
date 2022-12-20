# encoding: utf-8

module Bookman

class Bookman

  ## todo: add logutils/logger here

  def initialize( config )
    @config = config

    ## for debugging dump main config settings
    puts "dataset:"
    puts "  - collection: #{@config.collection}"
    puts "  - setup:      #{@config.setup}"
    ## todo: add db_path - why, why not???

    puts "datafile:"
    puts "  - datafile_url  (remote):  #{@config.datafile_url}"
    puts "  - datafile_dir  (local):   #{@config.datafile_dir}"
    puts "  - datafile_path (local):   #{@config.datafile_path}"

    puts "bookfile:"
    puts "  - bookfile_url  (remote):  #{@config.bookfile_url}"
    puts "  - bookfile_dir  (local):   #{@config.bookfile_dir}"
    puts "  - bookfile_path (local):   #{@config.bookfile_path}"
    ## todo: add bookfile_unzip_path - why, why not???
  end


  def dl_datasets
    ## fetch Datafile
    datafile_dir  = @config.datafile_dir
    datafile_path = @config.datafile_path

    ## check if folders exists? if not create folder in path
    FileUtils.mkdir_p( datafile_dir )  unless Dir.exists?( datafile_dir )

    ## note: lets use http:// instead of https:// for now - lets us use person proxy (NOT working w/ https for now)
    src = @config.datafile_url
    ## dest will be something like './Datafile'

    fetch_datafile( src, datafile_path )

    datafile = Datafile::Datafile.load_file( datafile_path )
    datafile.dump        ## for debugging
    datafile.download    ## datafile step 1 - download all datasets/zips 
  end


  def dl_book_templates
    ## fetch Bookfile
    bookfile_dir  = @config.bookfile_dir
    bookfile_path = @config.bookfile_path

    ## check if folders exists? if not create folder in path
    FileUtils.mkdir_p( bookfile_dir )  unless Dir.exists?( bookfile_dir )

    ## note: lets use http:// instead of https:// for now - lets us use person proxy (NOT working w/ https for now)
    src = @config.bookfile_url
    ## dest will be something like './Bookfile'

    fetch_bookfile( src, bookfile_path )


    bookfile = Bookfile::Bookfile.load_file( bookfile_path )

    bookfile.dump        ## for debugging
    bookfile.download    ## bookfile step 1 - download all packages/zips (defaults to ./tmp) 
    
    ## todo/check: already checked in unzip if folder exists???
    dest_unzip = @config.book_templates_unzip_dir
    FileUtils.mkdir_p( dest_unzip )  unless Dir.exists?( dest_unzip )

    bookfile.unzip( dest_unzip )   ## bookfile step 2 - unzip book templates 
  end


  def connect
    db_path = @config.db_path

    db_config = {
     adapter:  'sqlite3',
     database: db_path
    }

    pp db_config
    ActiveRecord::Base.establish_connection( db_config )

    c = ActiveRecord::Base.connection

    ## try to speed up sqlite
    ## see http://www.sqlite.org/pragma.html
    c.execute( 'PRAGMA synchronous=OFF;' )
    c.execute( 'PRAGMA journal_mode=OFF;' )
    ## c.execute( 'PRAGMA journal_mode=MEMORY;' )
    c.execute( 'PRAGMA temp_store=MEMORY;' )
  end


  def build_db
    ## clean; remove db if exits

    db_path = @config.db_path
    FileUtils.rm( db_path )  if File.exists?( db_path )

    connect()
    @config.create_db!

    datafile_path = @config.datafile_path
    pp datafile_path


    ### hack/quick fix for at,de - "standalone quick test": todo
    ##   - find something better
    if datafile_path.end_with?( 'at.rb' ) ||
       datafile_path.end_with?( '/at/Datafile' )
      ## standalone austria for debugging add country
      WorldDb::Model::Country.create!( key: 'at',
                                name: 'Austria',
                                code: 'AUT',
                                pop: 0,
                                area: 0 )
    elsif datafile_path.end_with?( 'de.rb' ) ||
          datafile_path.end_with?( '/de/Datafile' )
      WorldDb::Model::Country.create!( key: 'de',
                                name: 'Germany',
                                code: 'GER',
                                pop: 0,
                                area: 0 )
    else
      # no special case; continue
      puts "[debug] - no special world archive case w/ start script; continue"
    end


    datafile = Datafile::Datafile.load_file( datafile_path )
    datafile.dump    ## for debugging

    ## set "global" logger to debug
    LogUtils::Logger.root.level = :debug

    datafile.read    ## datafile step 2 - read all datasets 
  end


  def build_book
    connect()

    bookfile_path = @config.bookfile_path

    bookfile = Bookfile::Bookfile.load_file( bookfile_path )
    bookfile.dump        ## for debugging

    ### fix:
    ###     assume WorldDb::Models already included ??
    ## - for now always include on prepare
    bookfile.prepare( @config.book_templates_unzip_dir )

    puts "  contintents: #{WorldDb::Model::Continent.count}"   ## for debugging

    bookfile.build( @config.book_templates_unzip_dir )

    puts 'Done.'
  end


  def run_jekyll
    # change cwd folder
    cwd = FileUtils.pwd
    puts "cwd (before): #{FileUtils.pwd}"
    FileUtils.cd( @config.book_templates_unzip_dir )
    puts "cwd (after): #{FileUtils.pwd}"

    ## use `cd #{book_dir}; jekyll build`  -- why, why not???
    puts `jekyll build`

    # restore cwd folder
    FileUtils.cd( cwd )
  end


  def build
    ## all-in-one; do everything; complete all steps
    dl_datasets
    dl_book_templates

    build_db
    build_book
    run_jekyll
  end


private

  def fetch_datafile( src, dest )
    worker = Fetcher::Worker.new
    worker.copy( src, dest )
  end

  def fetch_bookfile( src, dest )
    worker = Fetcher::Worker.new
    worker.copy( src, dest )
  end

end  # class Bookman

end # module Bookman
