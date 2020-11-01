# encoding: utf-8

####################################
#  The Proof of the Pudding  - hello.rb
#
#   Use
#     $ ruby -I ./lib ./samples/hello.rb


require 'almost-sinatra'


include $n    # include "anonymous" Almost Sinatra DSL module


get '/hello' do
  erb "Hello <%= name %>!", locals: { name: params['name'] }
end


get '/' do
  markdown <<EOS
## Welcome to Almost Sinatra

A six line ruby hack by Konstantin Haase.

Try:
- [Say hello!](/hello?name=Nancy)

Powered by Almost Sinatra (#{Time.now})
EOS
end



run!
