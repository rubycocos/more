# encoding: utf-8

module RubyCat


class Catalog

  attr_reader :cards

  def initialize
    @cards = []
  end

  def add( cards )
    @cards +=  cards.map { |card| Card.new(card) }   ## convert to RubyCat card
  end

  def sync( opts={} )   ## change name to populate/autofill, etc. ??
    ## get (extra) data from rubygems via api

    gems = RubyGemsService.new

    @cards.each_with_index do |card,i|

      if card.gem_url
        json = gems.info( card.name )
        pp json

        card.sync_gems_info( json )
      end

      pp card

      ### for debugging/testing; stop after processing x (e.g. 2) recs
      break    if opts[:limit] && i >= opts[:limit].to_i   ## e.g. i > 2 etc. 
    end
  end  # method sync


  def render
    ## render to json
    puts "--snip--"

    ary = []

    @cards.each do |card|
      h = card.to_hash
      ## pp h
      ary << h
    end

    puts "--snip--"
    puts JSON.pretty_generate( ary )
  end

end  ## class Catalog


end   # module RubyCat
