## $:.unshift(File.dirname(__FILE__))

## minitest setup

require 'minitest/autorun'


## our own code
require 'record'



## turn on "global" logging
Record::Field.logger.level   = :debug
Record::Builder.logger.level = :debug
