# encoding: utf-8

module Fotos

class StatsReport
  
  def initialize( folder )
    @folder = folder
  end

  def render
    @buf = ''
    walk( @folder )
    @buf.dup   # return a duplicate
  end # method render

private
  def walk( folder )
    puts "walking >#{folder.name}< (#{folder.folders.size}) level #{folder.level}..."

    @buf << "#{'#'*folder.level} #{folder.name}"
    @buf << " (#{folder.folders.size})" if folder.folders.size > 0
    @buf << "\n"
    @buf << "\n"

    if folder.folders.size > 0
      subfolder_names = folder.folders.map { |item| item.name }
      @buf << subfolder_names.join( ' . ' )
      @buf << "\n"          
      @buf << "\n"          
    end

    ## group fotos by file extension
    fotos_by_ext = folder.fotos.group_by { |foto| File.extname( foto.name.downcase ) }
    fotos_by_ext_stats = ''
    fotos_by_ext.each do |k,v|
      fotos_by_ext_stats << "#{k} (#{v.size}) "
    end
    
    @buf << "#{folder.fotos.size} Fotos - #{fotos_by_ext_stats}"
    @buf << "\n"          
    @buf << "\n"          

    folder.folders.each do |subfolder|
      walk( subfolder )
    end        
  end  # method walk

end  # class StatsReport


end # module Fotos

