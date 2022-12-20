# encoding: utf-8

###
## todo: change to Hybook::NumberHelper  - why? why not??

module HybookHelper

### todo:
##  add to textutils ?? why? why not??
def number_with_delimiter( num )
  delimiter = '.'
  num.to_s.reverse.gsub( /(\d{3})(?=\d)/, "\\1#{delimiter}").reverse
end


end # module HybookHelper
