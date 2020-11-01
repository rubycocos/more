# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb


require 'helper'


class TestVersion < MiniTest::Test

def test_version
   pp FizzBuzzer.version
   pp FizzBuzzer.banner
   pp FizzBuzzer.root

   assert true  ## (for now) everything ok if we get here
end

end  # class TestVersion
