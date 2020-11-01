# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_fizzbuzz.rb


require 'helper'


FIZZBUZZES_1_TO_100 =
  [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
  "FizzBuzz", 16, 17, "Fizz", 19, "Buzz", "Fizz", 22, 23, "Fizz", "Buzz", 26,
  "Fizz", 28, 29, "FizzBuzz", 31, 32, "Fizz", 34, "Buzz", "Fizz", 37, 38,
  "Fizz", "Buzz", 41, "Fizz", 43, 44, "FizzBuzz", 46, 47, "Fizz", 49, "Buzz",
  "Fizz", 52, 53, "Fizz", "Buzz", 56, "Fizz", 58, 59, "FizzBuzz", 61, 62,
  "Fizz", 64, "Buzz", "Fizz", 67, 68, "Fizz", "Buzz", 71, "Fizz", 73, 74,
  "FizzBuzz", 76, 77, "Fizz", 79, "Buzz", "Fizz", 82, 83, "Fizz", "Buzz", 86,
  "Fizz", 88, 89, "FizzBuzz", 91, 92, "Fizz", 94, "Buzz", "Fizz", 97, 98,
  "Fizz", "Buzz"]



class TestV1 < MiniTest::Test

  include FizzBuzzer::V1   ##  add (include) fizzbuzz method using algorithm V1

def test_fizzbuzz
   assert_equal FIZZBUZZES_1_TO_100, fizzbuzz
end
end # class TestV1



module FizzBuzz

  ## auto-generate test classes (see model/sample above)
  def self.test_class_for( m )
    Class.new( MiniTest::Test ) do
       include m
       define_method :test_fizzbuzz do
          puts "testing #{m.name}..."
          assert_equal FIZZBUZZES_1_TO_100, fizzbuzz
       end
    end
  end

  ALGOS = [ V1, V2a, V2b, V2c, V2d, V3, V4, V5,
            V6a, V6b, V7, V8, V9, V10, V11a, V11b, V12a, V12b, V13,
            Golf::V1, Golf::V2, Golf::V3, Golf::V4, Golf::V5, Golf::V6, Golf::V7 ]

  def self.build_tests
    puts " auto-adding (building) test classes..."
    ALGOS.each do |algo|
      puts "  adding #{algo.name}..."
      test_class_for( algo )
    end
  end
end


FizzBuzz.build_tests
