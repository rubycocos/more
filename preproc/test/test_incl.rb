# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_incl.rb
#  or better
#     rake test


require 'helper'


class TestIncl < MiniTest::Test

  def test_ruby
    src = 'https://raw.github.com/feedreader/planet-ruby/master/ruby.ini'
    txt = InclPreproc.from_url( src ).read
    pp txt

    assert true    ## if we get here it should work
  end

end # class TestIncl

