# encoding: utf-8

require 'pp'

## our own code
require 'fizzbuzzer/version'    # note: let version always go first




module FizzBuzzer

module V1
  def fizzbuzz
    [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
    "FizzBuzz", 16, 17, "Fizz", 19, "Buzz", "Fizz", 22, 23, "Fizz", "Buzz", 26,
    "Fizz", 28, 29, "FizzBuzz", 31, 32, "Fizz", 34, "Buzz", "Fizz", 37, 38,
    "Fizz", "Buzz", 41, "Fizz", 43, 44, "FizzBuzz", 46, 47, "Fizz", 49, "Buzz",
    "Fizz", 52, 53, "Fizz", "Buzz", 56, "Fizz", 58, 59, "FizzBuzz", 61, 62,
    "Fizz", 64, "Buzz", "Fizz", 67, 68, "Fizz", "Buzz", 71, "Fizz", 73, 74,
    "FizzBuzz", 76, 77, "Fizz", 79, "Buzz", "Fizz", 82, 83, "Fizz", "Buzz", 86,
    "Fizz", 88, 89, "FizzBuzz", 91, 92, "Fizz", 94, "Buzz", "Fizz", 97, 98,
    "Fizz", "Buzz"]
  end
end ## module V1

module V2a
  def fizzbuzz
    (1..100).map do |n|
      if n % 3 == 0 && n % 5 == 0
        "FizzBuzz"
      elsif n % 3 == 0
        "Fizz"
      elsif n % 5 == 0
        "Buzz"
      else
        n
      end
    end
  end
end

module V2b
  def fizzbuzz
    (1..100).map do |n|
      if    (n % 15).zero? then "FizzBuzz"
      elsif (n % 3).zero?  then "Fizz"
      elsif (n % 5).zero?  then "Buzz"
      else   n
      end
    end
  end
end

module V2c
  def fizzbuzz
    (1..100).map do |n|
      case
      when n % 3 == 0 && n % 5 == 0 then "FizzBuzz"
      when n % 3 == 0 then "Fizz"
      when n % 5 == 0 then "Buzz"
      else n
      end
    end
  end
end

module V2d
  def fizzbuzz
    (1..100).map do |n|
      next "FizzBuzz"   if n % 3 == 0 && n % 5 == 0
      next "Fizz"       if n % 3 == 0
      next "Buzz"       if n % 5 == 0
      n
    end
  end
end
end # module FizzBuzzer


## monkey patch for Fixnum - note: use refinements (in the future) - why? why not?
class Fixnum
  def to_fizzbuzz
    if self % 3 == 0 && self % 5 == 0
      "FizzBuzz"
    elsif self % 3 == 0
      "Fizz"
    elsif self % 5 == 0
      "Buzz"
    else
      self
    end
  end  # method to_fizzbuzz
end


module FizzBuzzer
module V3
  def fizzbuzz
    (1..100).map { |n| n.to_fizzbuzz }
  end
end


module V4
class Fizznum
  def initialize(n)
    @n = n
  end

  def fizzbuzz?() @n % 3 == 0 && @n % 5 == 0;  end
  def fizz?()     @n % 3 == 0;  end
  def buzz?()     @n % 5 == 0;  end

  def val
    if    fizzbuzz? then "FizzBuzz"
    elsif fizz?     then "Fizz"
    elsif buzz?     then "Buzz"
    else  @n
    end
  end
end

def fizzbuzz
  (1..100).map{ |n| Fizznum.new(n).val }
end
end


module V5
FIZZ = 'Fizz'
BUZZ = 'Buzz'

def divisible_by?(numerator, denominator)
  numerator % denominator == 0
end

def divisible_by_3?( numerator )
  divisible_by?( numerator, 3 )
end

def divisible_by_5?( numerator )
  divisible_by?( numerator, 5 )
end

def fizzbuzz
  (1..100).map do |n|
     fizz = divisible_by_3? n
     buzz = divisible_by_5? n
     case
     when fizz && buzz then FIZZ + BUZZ
     when fizz then FIZZ
     when buzz then BUZZ
     else n
     end
  end
end
end


module V6a
  module FizzBuzz
    def self.enumerator
      Enumerator.new do |yielder|
        (1..100).each do |n|
          yielder << case
                     when n % 3 == 0 && n % 5 == 0 then "FizzBuzz"
                     when n % 3 == 0               then "Fizz"
                     when n % 5 == 0               then "Buzz"
                     else  n
                     end
        end
      end
    end
  end

  def fizzbuzz
    FizzBuzz.enumerator.first( 100 )
  end
end


module V6b
  module FizzBuzz
    def self.enumerator
      Enumerator.new do |yielder|
        (1..100).each do |n|
          yielder << if    n % 3 == 0 && n % 5 == 0 then "FizzBuzz"
                     elsif n % 3 == 0               then "Fizz"
                     elsif n % 5 == 0               then "Buzz"
                     else  n
                     end
        end
      end
    end
  end

  def fizzbuzz
    e = FizzBuzz.enumerator
    [e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next,
     e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next, e.next]
  end
end


module V7
require "bigdecimal"

module FizzBuzz
  def self.enumerator
    Enumerator::Lazy.new(1..BigDecimal::INFINITY) do |yielder, n|
       yielder << case
                  when n % 3 == 0 && n % 5 == 0 then "FizzBuzz"
                  when n % 3 == 0               then "Fizz"
                  when n % 5 == 0               then "Buzz"
                  else n
                  end
    end
  end
end

def fizzbuzz
  FizzBuzz.enumerator.take( 100 ).force      # or first( 100 ) is always eager by default
end
end


module V8
  def fizzbuzz
    (1..100).map do |n|
      case [n % 3 == 0, n % 5 == 0]
      when [true, true]    then "FizzBuzz"
      when [true, false]   then "Fizz"
      when [false, true]   then "Buzz"
      else n
      end
    end
  end
end


module V9
require "noaidi"

def fizzbuzz
  (1..100).map do |n|
    Noaidi.match [n % 3, n % 5] do |m|
      m.(0, 0)           { "FizzBuzz" }
      m.(0, Fixnum)      { "Fizz" }
      m.(Fixnum, 0)      { "Buzz" }
      m.(Fixnum, Fixnum) { n }
    end
  end
end
end


module V10
require "dry-matcher"

FizzBuzz = Dry::Matcher.new(
  fizzbuzz: Dry::Matcher::Case.new(
              match: -> value { value[0] == 0 && value[1] == 0 },
              resolve: -> value { "FizzBuzz" } ),
  fizz:     Dry::Matcher::Case.new(
              match: -> value { value[0] == 0 },
              resolve: -> value { "Fizz" } ),
  buzz:     Dry::Matcher::Case.new(
              match: -> value { value[1] == 0 },
              resolve: -> value { "Buzz" } ),
  other:    Dry::Matcher::Case.new(
              match: -> value { true },
              resolve: -> value { value[2] } ))

def fizzbuzz
  (1..100).map do |n|
    FizzBuzz.([n % 3, n % 5, n]) do |m|
      m.fizzbuzz { |v| v }
      m.fizz     { |v| v }
      m.buzz     { |v| v }
      m.other    { |v| v }
    end
  end
end
end


module V11a
  def fizzbuzz
    result = []
    for n in 1..100 do
      result << if     n % 3 == 0 && n % 5 == 0 then "FizzBuzz"
                elsif  n % 3 == 0               then "Fizz"
                elsif  n % 5 == 0               then "Buzz"
                else   n
                end
    end
    result
  end
end


module V11b
  def divisible_by?(numerator, denominator)
    numerator % denominator == 0
  end

  def divisible_by_3?( numerator )
    divisible_by?( numerator, 3 )
  end

  def divisible_by_5?( numerator )
    divisible_by?( numerator, 5 )
  end

  def fizzbuzz
    result = []
    for n in 1..100 do
      result << case
                when divisible_by_3?(n) && divisible_by_5?(n) then "FizzBuzz"
                when divisible_by_3?(n)                       then "Fizz"
                when divisible_by_5?(n)                       then "Buzz"
                else n
                end
    end
    result
  end
end


module V12a
def fizzbuzz_engine(range, factors)
  range.map do |n|
    result = ""
    factors.each do |(name, predicate)|
      result << name if predicate.call(n)
    end
    result == "" ? n : result
  end
end

def fizzbuzz
  fizzbuzz_engine( 1..100, [["Fizz", -> n { n % 3 == 0 }],
                            ["Buzz", -> n { n % 5 == 0 }]])
end
end

module V12b
FIZZBUZZ_DEFAULT_RANGE     = 1..100
FIZZBUZZ_DEFAULT_FACTORS   = [["Fizz", -> n { n % 3 == 0 }],
                              ['Buzz', -> n { n % 5 == 0 }]]

def fizzbuzz_engine(range=FIZZBUZZ_DEFAULT_RANGE, factors=FIZZBUZZ_DEFAULT_FACTORS)
  range.map do |n|
    result = ""
    factors.each do |(name, predicate)|
      result << name if predicate.call(n)
    end
    result == "" ? n : result
  end
end

def fizzbuzz
  fizzbuzz_engine
end
end


module V13
  def fizzbuzz
    fizzy = [nil, nil, :Fizz].cycle
    buzzy = [nil, nil, nil, nil, :Buzz].cycle
 
    (1..100).map do |n|
      "#{fizzy.next}#{buzzy.next}"[/.+/] || n
    end
  end
end
      

module Golf
  ## Notes:
  ##   use <1 shorter form of ==0
  ##
  ##  "Fizz"[/.+/]  #=> "Fizz"
  ##  "Buzz"[/.+/]  #=> "Buzz"
  ##  ""[/.+/]      #=> nil
  ##
  ##  ["Fizz"][0]  #=> "Fizz"
  ##  ["Fizz"][1]  #=> nil
  ##  ["Fizz"][2]  #=> nil
  ##
  ##  ["Buzz"][0]  #=> "Buzz"
  ##  ["Buzz"][1]  #=> "nil
  ##
  ##  ["%sBuzz" % "Fizz"] #=> "FizzBuzz"
  ##  ["%sBuzz" % nil]    #=> "Buzz"

  module V1     ## 66 bytes
    def fizzbuzz
      (1..100).map{|n|s="";n%3<1&&s+="Fizz";n%5<1&&s+="Buzz";s[/.+/]||n}
    end
  end

  module V2      ## 65 bytes
    def fizzbuzz
      (1..100).map{|n|n%3<1?(n%5<1?"FizzBuzz":"Fizz"):(n%5<1?"Buzz":n)}
    end
  end
  
  module V3      ## 64 bytes
    def fizzbuzz
      (1..100).map{|n|n%3*n%5<1?(n%3<1?"Fizz":"")+(n%5<1?"Buzz":""):n}
    end
  end

  module V4      ## 62 bytes
    #  n%15==0 ? "FizzBuzz" : n%5==0 ? "Buzz" : n%3==0 ? "Fizz" : n
    def fizzbuzz
      (1..100).map{|n|n%15<1?"FizzBuzz":n%5<1?"Buzz":n%3<1?"Fizz":n}
    end
  end

  module V5      ## 58 bytes
    def fizzbuzz
      (1..100).map{|n|"#{[:Fizz][n%3]}#{[:Buzz][n%5]}"[/.+/]||n}
    end
  end

  module V6      ## 54 bytes
    #  n%3 < 1 && x="Fizz"
    #  n%5 < 1 ? "#{x}Buzz" : x || n
    def fizzbuzz
      (1..100).map{|n|n%3<1&&x="Fizz";n%5<1?"#{x}Buzz":x||n}
    end
  end

  module V7      ## 54 bytes
    def fizzbuzz
      (1..100).map{|n|["%sBuzz"%x=["Fizz"][n%3]][n%5]||x||n}
    end
  end
end # module Golf



module Main     ## todo/check: use a class Runner instead (w/ include V1 etc.) - why? why not?
  extend V1
end


def self.main
  puts Main.fizzbuzz.join( ', ' )

  ## print source add the end  e.g. source:
  ##   possible why? why not?
end # method self.main

end # module FizzBuzzer

## add alias for convenience
FizzBuzz = FizzBuzzer
