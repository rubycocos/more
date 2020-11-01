# encoding: utf-8

#####
# orginal source in six lines;
#
# 1: %w.rack tilt backports date INT TERM..map{|l|trap(l){$r.stop}rescue require l};$u=Date;$z=($u.new.year + 145).abs;puts "== Almost Sinatra/No Version has taken the stage on #$z for development with backup from Webrick"
# 2: $n=Sinatra=Module.new{a,D,S,q=Rack::Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m
# 3: %w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}
# 4: Tilt.default_mapping.lazy_map.map{|k,v|D.(k){|n,*o|$t||=(h=$u._jisx0301("hash, please");File.read(caller[0][/^[^:]+/]).scan(S){|a,b|h[a]=b};h);Kernel.const_get(v[0][0]).new(*o){n=="#{n}"?n:$t[n.to_s]}.render(a,o[0].try(:[],:locals)||{})}}
# 5: %w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try :[]}};END{Rack::Handler.get("webrick").run(a,Port:$z){|s|$r=s}}
# 6: %w[params session].map{|m|D.(m){q.send m}};a.use Rack::Session::Cookie;a.use Rack::Lock;D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Rack::Request.new e;q.params.dup.map{|k,v|params[k.to_sym]=v}}}
#
#  see:  https://github.com/rkh/almost-sinatra/blob/master/almost_sinatra.rb



#############
#  unbundled ("obfuscated") version
#
#  replaced
#  1)  D = Object.method(:define_method)  with
#        define_method


# line 1
%w[rack tilt backports date INT TERM].map do |l|
    trap(l) { $r.stop }
  rescue
    require l
end

$u = Date
$z = ($u.new.year + 145).abs
puts "== Almost Sinatra/No Version has taken the stage on #$z for development with backup from Webrick"

# line 2
$n = Sinatra = Module.new do
  a = Rack::Builder.new
  S = /@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m
  q = nil

# line 3
  %w[get post put delete].map do |m|
    define_method( m ) do |u, &b|
      a.map(u) do
        run ->(e) { [200, {"Content-Type"=>"text/html"}, [a.instance_eval(&b)]] }
      end
    end
  end

# line 4
  Tilt.default_mapping.lazy_map.map do |k,v|
    define_method( k ) do |n, *o|
      $t ||= do
        h = $u._jisx0301("hash, please")
        File.read( caller[0][/^[^:]+/] ).scan(S) { |a,b| h[a]=b }
        h
      end
      Kernel.const_get( v[0][0] ).new( *o ) do
        n == "#{n}" ? n : $t[n.to_s]
      end.render( a, o[0].try( :[], :locals) || {} )
    end
  end

# line 5
  %w[set enable disable configure helpers use register].map do |m|
    define_method( m ) do |*_, &b|
      b.try :[]
    end
  end

  END do
    Rack::Handler.get( "webrick" ).run( a, Port:$z ) { |s| $r=s }
  end


# line 6
  %w[params session].map do |m|
    define_method( m ) do
      q.send m
    end
  end
  a.use Rack::Session::Cookie
  a.use Rack::Lock
  define_method( :before ) do |&b|
    a.use Rack::Config, &b
  end
  before do |e|
    q = Rack::Request.new e
    q.params.dup.map { |k,v| params[k.to_sym] = v}
  end
end
