# encoding: utf-8

module Hybook


class Album
  attr_accessor :title
  attr_accessor :sections

  def initialize( title )
    @title      = title
    @sections  = []      # sections (for pictures)
  end


  ###
  ## fix: move to album builder
  

  def self.create_from_folder( root, opts={} )
    dirs = Dir[ "#{root}/**/" ]  ## get all folders n subfolder
    ## pp dirs

    title = opts[:title ] || 'Untitled'

    album = Album.new( title )

    dirs.each do |dir|
      section_title =  dir[ root.length+1..-2 ]  # cut off ROOT_DIR plus leading and trailing /
      files = Dir[ "#{dir}/*.{png,gif,jpg}" ]

      ## fix: use logger
      puts "dir: #{dir}, title: #{section_title}, files: #{files.size}"
      next if files.size == 0   # skip if no image files in folder
    
      section = Section.new( section_title )
      album.sections << section

      ## puts "files:"
      ## pp files

      files.each do |filename|
        extname      = File.extname( filename )
        basename     = File.basename( filename, extname )   # NB: remove extname (that is, suffix e.g. .png,.jpg,.gif etc.)

        picture_title = basename   # use basename
        picture_path  = filename   # TODO/FIX: strip off leading root path ?? why? why not???
        ### rename path to source or src or file or filename - why? why not??


        picture = Picture.new( picture_title, picture_path )
        section.pictures << picture
      end
    end
    album   # return album struct
  end


end  # class Album


end # module Hybook
