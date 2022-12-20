# encoding: utf-8

module Hybook


class Picture
  attr_accessor :title
  attr_accessor :path

  def initialize( title, path )
    @title      = title
    @path       = path
  end
end


end # module Hybook
