# encoding: utf-8

# stdlibs
require 'pp'
require 'date'
require 'strscan'  ## StringScanner lib
require 'erb'
require 'uri'
require 'json'


# 3rd party libs (gems)
require 'props'
require 'logutils'
require 'textutils'

require 'props/activerecord'
require 'logutils/activerecord'


# our own code

require 'catalogdb/version'      ## let version always go first

require 'catalogdb/reader'



# say hello
puts CatalogDb.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
