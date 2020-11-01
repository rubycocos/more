# encoding: utf-8

require 'pp'
require 'logger'



###
# our own code
require 'record/version' # let version always go first
require 'record/field'
require 'record/base'
require 'record/builder'


# say hello
puts Record.banner     if $DEBUG || (defined?($RUBYCOCO_DEBUG) && $RUBYCOCO_DEBUG)
