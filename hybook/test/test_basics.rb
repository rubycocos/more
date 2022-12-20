# encoding: utf-8


require 'helper'

class TestBasics < MiniTest::Test

  def test_banner

    banner = "hybook/#{Hybook::VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"

    assert_equal banner, Hybook.banner
    assert_equal banner, HyBook.banner   ## check module alias

  end

end # class Basics
