# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_basics.rb

require 'helper'

class TestBasics < MiniTest::Test

  def test_banner

    banner = "bookman/#{Bookman::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"

    assert_equal banner, Bookman.banner
    assert_equal banner, BookMan.banner   ## check module alias
  end

  def test_football_config
    cfg = Bookman::FootballConfig.new( setup: 'at' )
    pp cfg
    assert true
  end

  def test_football_builder
    b = Bookman::Bookman.create_football_book_for( 'at' )
    assert true
  end

  def test_world_builder
    b = Bookman::Bookman.create_world_book_for( 'at' )
    assert true
  end

  def test_beer_builder
    b = Bookman::Bookman.create_beer_book_for( 'at' )
    assert true
  end

end # class Basics
