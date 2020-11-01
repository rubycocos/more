# Notes


## FizzBuzz Articles and Samples

### Ruby

FizzBuzz in Too Much Detail by Tom Dalling
@ https://www.tomdalling.com/blog/software-design/fizzbuzz-in-too-much-detail/ and
@ https://www.rubypigeon.com/posts/fizzbuzz-in-too-much-detail/

FizzBuzz with pattern matching (in Ruby) by Paweł Świątkowski
@ http://katafrakt.me/2016/11/05/fizzbuzz-with-pattern-matching/


FizzBuzz RubyQuiz #126
@ http://rubyquiz.com/quiz126.html


Search RubyGems.org
@ https://rubygems.org/search?query=fizzbuzz

Search BestGems.org
@ http://bestgems.org/search?q=fizzbuzz




### Java

FizzBuzz Enterprise Edition is a no-nonsense implementation of FizzBuzz made by serious businessmen for serious business purposes. 
@  https://github.com/EnterpriseQualityCoding/FizzBuzzEnterpriseEdition


### Python

Fizz buzz in tensorflow (machine learning)
@ https://github.com/joelgrus/fizz-buzz-tensorflow and
@ https://github.com/joelgrus/fizz-buzz-tensorflow/blob/master/Fizz%20Buzz%20in%20Tensorflow.ipynb
@ http://joelgrus.com/2016/05/23/fizz-buzz-in-tensorflow/

### More

FizzBuzz @ Rosseta Code
@ http://rosettacode.org/wiki/FizzBuzz

FizzBuzz Topic / Tag @ GitHub
@ https://github.com/topics/fizzbuzz     

FizzBuzz Repo by Tobias Pfeiffer aka Prag Tob
@ https://github.com/PragTob/fizzbuzz



## More FizzBuzz Algorithms

Rotate / No Conditionals

``` ruby
def fizzbuzz
  fizzy = [1,0,0]
  buzzy = [1,0,0,0,0]

  (1..100).map do |n|
     fizzy.rotate!
     buzzy.rotate!
     result = n.to_s * (1 - (fizzy[0] | buzzy[0]))
     result << "Fizz" * fizzy[0]
     result << "Buzz" * buzzy[0]
     result
  end
end
```

Contributed by [John Schank](https://github.com/jschank).




## Monkey Patch Version with Refinements


``` ruby
module V3
## monkey patch for Fixnum - note: use refinements fo now  - why? why not?
  module FizzBuzz
    refine Fixnum do
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
  end

  using FizzBuzz

  def fizzbuzz
    (1..100).map { |n| n.to_fizzbuzz }
  end
end
```



## Old Test Builder with eval

``` ruby
%w[V2a V2b V2c V2d V3 V4 V5 V6a V6b V7 V8 V9 V10 V11 V12a V12b].each do |name|
  eval %Q(
    class Test#{name} < MiniTest::Test
      include FizzBuzzer::#{name}

      def test_fizzbuzz
        puts "running fizzbuzz #{name}..."
        assert_equal FIZZBUZZES_1_TO_100, fizzbuzz
      end
    end)
end
```

Add name to anonymous test class - why? why not?

``` ruby
module FizzBuzz

  ## auto-generate test classes (see model/sample above)
  def self.test_class_for( m )
    test_class = Class.new( MiniTest::Test ) do
       include m
       define_method :test_fizzbuzz do
          puts "testing #{m.name}..."
          assert_equal FIZZBUZZES_1_TO_100, fizzbuzz
       end
    end
    ##  change name from FizzBuzzer::V1 to FizzBuzzer_V1 etc.
    ## Object.const_set( "Test_" + m.name.gsub(/:+/, '_'), test_class )
  end

end
```

