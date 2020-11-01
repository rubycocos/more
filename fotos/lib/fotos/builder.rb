# encoding: utf-8

module Fotos

##
##  check:   .picasaoriginals ???
##   walking >/franzzz/bilder/RolleFamilie< level 2...
##  walking >/franzzz/bilder/RolleFamilie/.picasaoriginals< level 3...


class Folder
  
  attr_reader   :name, :level, :parent
  attr_accessor :folders
  attr_accessor :fotos
  
  def initialize( name, parent: nil, level: 1 )
     @name    = name
     @level   = level
     @parent  = parent
     @folders = []
     @fotos   = []
  end
end

class Foto
  
  attr_reader :name, :folder

  def initialize( name, folder: nil )
     @name   = name
     @folder = folder 
  end
end


class LibraryBuilder

  def initialize( root_dir )
    @root_dir = root_dir
  end

  def build
    walk( @root_dir, nil, 1 )
  end

private
  def walk( dir, parent, level )
    puts "walking >#{dir}< level #{level}..."

    basename = File.basename( dir )    ## todo: add extension - why? why not?
    folder = Folder.new( basename, parent: parent, level: level )

    if parent
      parent.folders << folder
    end
    
    
    files = Dir.entries( dir )
    ## pp files
    files.each do |file|
       next if ['..', '.'].include?( file )   ## skip .. n .
       
       path = "#{dir}/#{file}"
       if File.directory?( path )
         walk( path, folder, level+1 )
       else
         ## assume it's a foto for now
         foto = Foto.new( file, folder: folder )
         folder.fotos << foto
       end
    end
    
    folder ## return folder
  end  # method build

end  # class LibraryBuilder
  
end # module Fotos
