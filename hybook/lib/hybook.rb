# encoding: utf-8


############
# stdlibs

require 'pp'


###################
# 3rd party libs

require 'textutils'


#####################
# our own code

require 'hybook/version'  # let it always go first

require 'hybook/type/album'
require 'hybook/type/picture'
require 'hybook/type/section'

##############################################
# builtin std helpers, renderers n builders

require 'hybook/std/album'
require 'hybook/helpers/markdown'
require 'hybook/helpers/misc'

## builders

require 'hybook/builder/book'
require 'hybook/builder/album'

## writers

require 'hybook/writer/jekyll'




# say hello
if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
  puts Hybook.banner
  puts "[hybook] root: #{Hybook.root}"
  puts "[hybook] templates_path: #{Hybook.templates_path}"
end
