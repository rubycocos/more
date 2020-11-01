# record -  named tuples / records with typed structs / schemas

* home  :: [github.com/rubycoco/record](https://github.com/rubycoco/record)
* bugs  :: [github.com/rubycoco/record/issues](https://github.com/rubycoco/record/issues)
* gem   :: [rubygems.org/gems/record](https://rubygems.org/gems/record)
* rdoc  :: [rubydoc.info/gems/record](http://rubydoc.info/gems/record)
* forum :: [wwwmake](http://groups.google.com/group/wwwmake)



## Usage


Step 1: Define a (typed) struct for your records / named tuples. Example:

```ruby
require 'record'

Beer = Record.define do
  field :brewery        ## note: default type is :string
  field :city
  field :name
  field :abv, Float     ## allows type specified as class (or use :float)
end
```

or in "classic" style:

```ruby
class Beer < Record::Base
  field :brewery
  field :city
  field :name
  field :abv, Float
end
```



Step 2:  Use the new class to create new (typed) records. Example:


``` ruby
beer = Beer.new( 'Andechser Klosterbrauerei',
                 'Andechs',
                 'Doppelbock Dunkel',
                 '7%' )

# -or-

values = ['Andechser Klosterbrauerei', 'Andechs', 'Doppelbock Dunkel', '7%']
beer = Beer.new( values )

# -or-

beer = Beer.new( brewery: 'Andechser Klosterbrauerei',
                 city:    'Andechs',
                 name:    'Doppelbock Dunkel',
                 abv:     '7%' )

# -or-

hash = { brewery: 'Andechser Klosterbrauerei',
         city:    'Andechs',
         name:    'Doppelbock Dunkel',
         abv:     '7%' }
beer = Beer.new( hash )


# -or-

beer = Beer.new
beer.update( brewery: 'Andechser Klosterbrauerei',
             city:    'Andechs',
             name:    'Doppelbock Dunkel' )
beer.update( abv: 7.0 )

# -or-

beer = Beer.new
beer.parse( ['Andechser Klosterbrauerei', 'Andechs', 'Doppelbock Dunkel', '7%'] )

# -or-

beer = Beer.new
beer.parse( 'Andechser Klosterbrauerei,Andechs,Doppelbock Dunkel,7%' )

# -or-

beer = Beer.new
beer.brewery = 'Andechser Klosterbrauerei'
beer.name    = 'Doppelbock Dunkel'
beer.abv     = 7.0
```


And so on. That's it.




## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `record` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
