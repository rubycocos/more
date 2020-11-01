# encoding: utf-8


###
# almost_sinatra.rb
#  -- Sinatra refactored, only six lines now. A hack by Konstantin Haase.
#     see https://github.com/rkh/almost-sinatra/blob/master/almost_sinatra.rb
#
# e.g.
#
# %w.rack tilt date INT TERM..map{|l|trap(l){$r.stop}rescue require l};$u=Date;$z=($u.new.year + 145).abs;puts "== Almost Sinatra/No Version has taken the stage on #$z for development with backup from Webrick"
# $n=Module.new{extend Rack;a,D,S,q=Rack::Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m
# %w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}
# Tilt.mappings.map{|k,v|D.(k){|n,*o|$t||=(h=$u._jisx0301("hash, please");File.read(caller[0][/^[^:]+/]).scan(S){|a,b|h[a]=b};h);v[0].new(*o){n=="#{n}"?n:$t[n.to_s]}.render(a,o[0].try(:[],:locals)||{})}}
# %w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try :[]}};END{Rack::Handler.get("webrick").run(a,Port:$z){|s|$r=s}}
# %w[params session].map{|m|D.(m){q.send m}};a.use Rack::Session::Cookie;a.use Rack::Lock;D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Rack::Request.new e;q.params.dup.map{|k,v|params[k.to_sym]=v}}}
#
#
# Why? Why? Why?
#
# > Until programmers stop acting like obfuscation is morally hazardous,
# > they're not artists, just kids who don’t want their food to touch.
# >  -- \_why




# Almost Sinatra - A Breakdown - Line 1/6
#
# Line 1:
# %w.rack tilt date INT TERM..map{|l|trap(l){$r.stop}rescue require l};$u=Date;$z=($u.new.year + 145).abs;puts "== Almost Sinatra/No Version has taken the stage on #$z for development with backup from Webrick"

require 'rack'
require 'tilt'

trap( 'INT' )  { $server.stop }  # rename $r to $server
trap( 'TERM' ) { $server.stop }

$port = 4567              # rename $z to $port

puts "== Almost Sinatra has taken the stage on #{$port} for development with backup from Webrick"


# Almost Sinatra - A Breakdown - Line 2/6
#
# Line 2:
# $n=Module.new{extend Rack;a,D,S,q=Rack::Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m

$n = Module.new do
  app = Rack::Builder.new      # rename a to app
  req = nil                    # rename q to req


# Almost Sinatra - A Breakdown - Line 3/6
#
# Line 3:
#  %w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}

  ['get','post','put','delete'].each do |method|
    define_method method do |path, &block|
      app.map( path ) do
        run ->(env){ [200, {'Content-Type'=>'text/html'}, [app.instance_eval( &block )]]}
      end
    end
  end


# Almost Sinatra - A Breakdown - Line 4/6
#
# Line 4:
#  Tilt.mappings.map{|k,v|D.(k){|n,*o|$t||=(h=$u._jisx0301("hash, please");File.read(caller[0][/^[^:]+/]).scan(S){|a,b|h[a]=b};h);v[0].new(*o){n=="#{n}"?n:$t[n.to_s]}.render(a,o[0].try(:[],:locals)||{})}}

  Tilt.default_mapping.lazy_map.each do |ext, engines|          # rename k to ext and v to engines
    define_method ext do |text, *args|
      # rename n to text and o to args
      template = Kernel.const_get(engines[0][0]).new(*args) do
        text
      end
      locals = (args[0].respond_to?(:[]) ? args[0][:locals] : nil) || {}    # was o[0].try(:[],:locals)||{}
      template.render( app, locals )
    end
  end




# Almost Sinatra - A Breakdown - Line 5/6
#
# Line 5:
#   %w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try :[]}};END{Rack::Handler.get("webrick").run(a,Port:$z){|s|$r=s}}

  # was END { ... }; change to run! method
  define_method 'run!' do
    Rack::Handler.get('webrick').run( app, Port:$port ) {|server| $server=server }
  end


# Almost Sinatra - A Breakdown - Line 6/6
#
# Line 6:
#   %w[params session].map{|m|D.(m){q.send m}};a.use Rack::Session::Cookie;a.use Rack::Lock;D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Rack::Request.new e;q.params.dup.map{|k,v|params[k.to_sym]=v}}}

  ['params','session'].each do |method|
    define_method method do
      req.send method
    end
  end

  app.use Rack::Session::Cookie
  app.use Rack::Lock
  app.use Rack::Config do |env|
    req = Rack::Request.new( env )
  end
end # Module.new
