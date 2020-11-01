# FizzBuzzer

fizzbuzzer - 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, ... -
a collection of algorithms for playing the word game for children that teaches division e.g. 7/3=?
(one of the four basic arithmetic operations in mathematics)
or helps you find the world's best coders in programming job interviews -
are you (re)using the fizzbuzzer library? ;-) - don't reinvent the wheel or the feedbuzzer!


* home  :: [github.com/rubylibs/fizzbuzzer](https://github.com/rubylibs/fizzbuzzer)
* bugs  :: [github.com/rubylibs/fizzbuzzer/issues](https://github.com/rubylibs/fizzbuzzer/issues)
* gem   :: [rubygems.org/gems/fizzbuzzer](https://rubygems.org/gems/fizzbuzzer)
* rdoc  :: [rubydoc.info/gems/fizzbuzzer](http://rubydoc.info/gems/fizzbuzzer)



## What's Fizz Buzz?

> Fizz buzz is a group word game for children to teach them about division.
> Players take turns to count incrementally, replacing any number divisible by three with the word
> "fizz", and any number divisible by five with the word "buzz".
>
> **Play**.
> Players generally sit in a circle. The player designated to go first says the number "1",
> and each player counts one number in turn. However, any number divisible by three is replaced by the
> word fizz and any divisible by five by the word buzz. Numbers divisible by both become fizz buzz.
> A player who hesitates or makes a mistake is eliminated from the game.
>
> For example, a typical round of fizz buzz would start as follows:
>
> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz,
> Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, Fizz Buzz, 31, 32, Fizz, 34, Buzz, Fizz, ...
>>
> **Other Uses**.
> Fizz buzz has been used as an interview screening device for computer programmers.
> Creating a list of the first hundred fizz buzz numbers is a trivial problem
> for any computer programmer, so interviewers can easily sort out those with insufficient
> programming ability.
>
> -- [Fizz Buzz @ Wikipedia](https://en.wikipedia.org/wiki/Fizz_buzz)


Can they?
Q: Can you code a program for the fizz buzz word game that prints the first hundred numbers?

A: Why not (re)use the (open source, free) fizzbuzzer library? ;-) -
Don't reinvent the wheel or the feedbuzzer!


```
$ fizzbuzz

1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17,
Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32,
Fizz, 34, Buzz, Fizz, 37, 38, Fizz, Buzz, 41, Fizz, 43, 44, FizzBuzz, 46, 47,
Fizz, 49, Buzz, Fizz, 52, 53, Fizz, Buzz, 56, Fizz, 58, 59, FizzBuzz, 61, 62,
Fizz, 64, Buzz, Fizz, 67, 68, Fizz, Buzz, 71, Fizz, 73, 74, FizzBuzz, 76, 77,
Fizz, 79, Buzz, Fizz, 82, 83, Fizz, Buzz, 86, Fizz, 88, 89, FizzBuzz, 91, 92,
Fizz, 94, Buzz, Fizz, 97, 98, Fizz, Buzz
```



## Algorithms

> Task
>
> Write a program that prints the integers from **1** to **100** (inclusive).
>
> But:
>
> - for multiples of three, print **Fizz** (instead of the number)
> - for multiples of five, print **Buzz** (instead of the number)
> - for multiples of both three and five, print **FizzBuzz** (instead of the number)
>
> -- [Fizz Buzz @ Rosseta Code](https://rosettacode.org/wiki/FizzBuzz)



### Gold Standard

Lookup pre-calculated ("hard coded") constants.  Fast. Faster. Fastest.

``` ruby
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
```

### Classic

``` ruby
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
```

Or use `zero?` and `n % 15` (3x5) for `n % 5 && n % 3`:

``` ruby
def fizzbuzz
  (1..100).map do |n|
      if    (n % 15).zero? then "FizzBuzz"
      elsif (n % 3).zero?  then "Fizz"
      elsif (n % 5).zero?  then "Buzz"
      else   n
      end
  end
end
```

Or use `case/when/else`:

``` ruby
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
```

Or use `next` with `if`-clause:

``` ruby
def fizzbuzz
  (1..100).map do |n|
      next "FizzBuzz"   if n % 3 == 0 && n % 5 == 0
      next "Fizz"       if n % 3 == 0
      next "Buzz"       if n % 5 == 0
      n
  end
end
```


### Monkey Patch (Extend) Fixnum Class

``` ruby
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
  end
end

def fizzbuzz
  (1..100).map { |n| n.to_fizzbuzz }
end
```

### Object-Oriented with New Fizznum Class

``` ruby
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
```


### Don't Repeat Yourself (DRY)


``` ruby
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
```


### Enumarator

```ruby
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
```

Or fetch every value one at a time with `next`:

``` ruby
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
```


### Lazy Enumerator to Infinity

```ruby
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
```


### Poor Man's (Do-It-Yourself) Pattern Matching

``` ruby
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
```


### Pattern Matching with Noaidi

``` ruby
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
```


### Pattern Matching with dry-matcher

``` ruby
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
```


### Test Driven Development (TDD)

``` ruby
describe FizzBuzz do

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
    before do
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
```

And here's another fizzbuzz algorithm with a classic `for` loop
and using `divisible_by?` and `case/when/else` clauses:

``` ruby
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
```


Or use asserts for testing:

``` ruby
class TestFizzBuzz < Minitest::Test

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
```

And here's yet another fizzbuzz algorithm with a classic `for` loop
and classic `if/elsif/else`-clauses:

``` ruby
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
```


Or use an all-in-one assert as used
for testing all the fizzbuzz algorithms :-) in this repo:

``` ruby
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

class TestFizzBuzz < Minitest::Test

  def test_fizzbuzz
    assert_equal FIZZBUZZES_1_TO_100, fizzbuzz
  end

end
```


### With Parameterization

``` ruby
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
```

Or with default configuration settings:

``` ruby
FIZZBUZZ_DEFAULT_RANGE    = 1..100
FIZZBUZZ_DEFAULT_FACTORS  = [["Fizz", -> n { n % 3 == 0 }],
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
```


### Use Cycle from Enumerable

``` ruby
def fizzbuzz
  fizzy = [nil, nil, :Fizz].cycle
  buzzy = [nil, nil, nil, nil, :Buzz].cycle

  (1..100).map do |n|
     "#{fizzy.next}#{buzzy.next}"[/.+/] || n
  end
end
```



### Code Golfing - One-Liners - The Shorter The Better!

Tip:  Use `<1` for a shorter form of `==0`.


**66 Bytes**

``` ruby
def fizzbuzz
  (1..100).map{|n|s="";n%3<1&&s+="Fizz";n%5<1&&s+="Buzz";s[/.+/]||n}
end
```

**65 Bytes**

``` ruby
def fizzbuzz
  (1..100).map{|n|n%3<1?(n%5<1?"FizzBuzz":"Fizz"):(n%5<1?"Buzz":n)}
end
```

**64 Bytes**

``` ruby
def fizzbuzz
  (1..100).map{|n|n%3*n%5<1?(n%3<1?"Fizz":"")+(n%5<1?"Buzz":""):n}
end
```

**62 Bytes**

``` ruby
def fizzbuzz
  (1..100).map{|n|n%15<1?"FizzBuzz":n%5<1?"Buzz":n%3<1?"Fizz":n}
end
```

**58 Bytes**

``` ruby
def fizzbuzz
  (1..100).map{|n|"#{[:Fizz][n%3]}#{[:Buzz][n%5]}"[/.+/]||n}
end
```

And the winner is...

**54 Bytes**

``` ruby
def fizzbuzz
  (1..100).map{|n|n%3<1&&x="Fizz";n%5<1?"#{x}Buzz":x||n}
end
```

or

``` ruby
def fizzbuzz
  (1..100).map{|n|["%sBuzz"%x=["Fizz"][n%3]][n%5]||x||n}
end
```


## Install

Just install the gem:

    $ gem install fizzbuzzer


## License

The `fizzbuzzer` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.



## Questions? Comments?

Send them along to the ruby-talk mailing list. Thanks!
