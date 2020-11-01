# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_rubygems.rb


require 'helper'



class TestRubyGems < MiniTest::Test

  def test_ruby
    
    r = CatalogDb::CardReader.from_file( "#{RubyCat.root}/test/data/RUBY.md" )
    cards = r.read

    pp cards
    
    c = cards[0]
    
    assert_equal [["Rack HQ", "http://rack.github.io"],
                  [":octocat:", "https://github.com/rack"],
                  [":gem:", "https://rubygems.org/gems/rack"],
                  [":book:", "http://rubydoc.info/gems/rack"]], c.links

    assert_equal 'Webframeworks › Rack',  c.categories

    cat = RubyCat::Catalog.new
    cat.add( cards )
    cat.render

    ## try sync w/ RubyGemsService/API
    cat.sync( limit: 2 )    ## only sync first three recs
    ## cat.sync

    cat.render ## dump w/ new (updated) values
    
    assert true  # if we get here - test success
  end

end # class TestRubyGems
