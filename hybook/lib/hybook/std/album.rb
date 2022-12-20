# encoding: utf-8

module Hybook
  module AlbumHelper

    def render_pictures( pics, opts )
      buf = ''

      ### sort by title for now
      pics.sort { |l,r| l.title <=> r.title }.each_with_index do |pic,i|
        buf << ' • ' if i > 0
        buf << render_picture( pic, opts )
      end
      
      buf
    end


    def render_picture( pic, opts )

      size        = opts[:size]
      assets_path = opts[:assets_path] || 'vendor/assets/images/logos'

      ## puts "[picture] size=#{size}"    # NOTE: opts[:size] required for now!!!
      ## puts "[picture] assets_path=#{assets_path}"
      ##
      ## puts "opts:"
      ## pp opts

      extname      = File.extname( pic.path )
      basename_in  = File.basename( pic.path, extname )   # NB: remove extname (that is, suffix e.g. .png,.jpg,.gif etc.)

      # strip leading 1-west-  (optional for organizing logos)
      #  e.g. 3-west-austrias  becomes austrias
      basename_out = basename_in.gsub( /[0-9a-z]+-/, '' )

      ## puts "path: #{path}, basename_in: #{basename_in}, basename_out: #{basename_out}, extname: #{extname}"

      path  = "#{assets_path}/#{size}x#{size}/#{basename_out}.png"

      buf = ''
      buf << "_#{pic.title}_{: .key} "
      buf << "![#{pic.title}](#{path})"
      buf
    end

    def render_album( album, opts )
      ###
      ## TODO/FIX:
      ##  use TextUtils::PageTemplate.read( path ).render( binding ) - one line

      tmpl = File.read_utf8( "#{Hybook.templates_path}/album.md" )
      TextUtils::PageTemplate.new( tmpl ).render( binding )
    end

  end # module AblumHelper


  # make helpers available as class methods for now e.g. Hybook.render_album etc.
  extend AlbumHelper
end # module Hybook
