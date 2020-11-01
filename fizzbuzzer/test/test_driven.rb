# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_driven.rb


require 'helper'


describe FizzBuzz do

  include FizzBuzzer::V11b   ##  add (include) fizzbuzz method using algorithm V11

  describe "number is divisible" do
    it "divisible by" do
       divisible_by?(15,3).must_equal true
    end
    it "divisible by 3" do
       divisible_by_3?(15).must_equal true
    end
    it "divisible by 5" do
       divisible_by_5?(15).must_equal true
    end
  end

  describe "number is fizzbuzz" do
    before do     ## optimize? use before(:all) - why? why not?
      @result = fizzbuzz
    end

    it "returns 'Fizz' for multiples of 3" do
      @result[3-1].must_equal "Fizz"
    end

    it "returns 'Buzz' for multiples of 5" do
      @result[5-1].must_equal "Buzz"
    end

    it "returns 'FizzBuzz' for multiples of 3 and 5" do
      @result[15-1].must_equal "FizzBuzz"
    end

    it "returns the passed number if not a multiple of 3 or 5" do
      @result[1-1].must_equal 1
    end
  end
end



class TestFizzBuzz < Minitest::Test

  include FizzBuzzer::V11a   ##  add (include) fizzbuzz method using algorithm V11

  def setup
    @result = fizzbuzz
  end

  def test_fizz_multiples_of_3
    assert_equal "Fizz", @result[3-1]
  end

  def test_buzz_for_multiples_of_5
    assert_equal "Buzz", @result[5-1]
  end

  def test_fizzbuzz_for_multiples_of_3_and_5
    assert_equal "FizzBuzz", @result[15-1]
  end

  def test_number_if_not_multiple_of_3_or_5
    assert_equal 1, @result[1-1]
  end
end
