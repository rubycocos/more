# encoding: utf-8

# 3rd party libs (gems)
require 'catalogdb'
require 'fetcher'


# our own code

require 'rubycat/version'      ## let version always go first

require 'rubycat/card'
require 'rubycat/catalog'

## services / apis

require 'rubycat/service/rubygems'



# say hello
puts RubyCat.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
