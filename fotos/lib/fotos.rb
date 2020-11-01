# encoding: utf-8


# 3rd party gems/libs
require 'logutils'

# our own code
require 'fotos/version'   # note: let version always go first
require 'fotos/builder'

require 'fotos/reports/stats'


# say hello
puts Fotos.banner    if defined?( $RUBYLIBS_DEBUG )
