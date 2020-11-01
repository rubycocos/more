# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_builder.rb


require 'helper'


class TestBuilder < MiniTest::Test


  def test_library
 
    builder = Fotos::LibraryBuilder.new( "/franzzz/bilder" )
    folder = builder.build
    
    report = Fotos::StatsReport.new( folder )
    txt = report.render
    puts txt
    
    assert true
    ## assume everything ok if get here
  end

end # class TestBuilder
