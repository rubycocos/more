######
# NB: use rackup to startup Sinatra service (see config.ru)
#
# e.g. config.ru:
# require './boot'
# run About::Server


# 3rd party libs/gems

require 'sinatra/base'


module About

class Server < Sinatra::Base

  def self.banner
    "about #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}] on Sinatra/#{Sinatra::VERSION} (#{ENV['RACK_ENV']})"
  end

  PUBLIC_FOLDER = "#{About.root}/lib/about/public"
  VIEWS_FOLDER = "#{About.root}/lib/about/views"

  puts "[boot] about - setting public folder to: #{PUBLIC_FOLDER}"
  puts "[boot] about - setting views folder to: #{VIEWS_FOLDER}"

  set :public_folder, PUBLIC_FOLDER # set up the static dir (with images/js/css inside)
  set :views, VIEWS_FOLDER # set up the views dir

  set :static, true # set up static file routing


  #######################
  # Models

  # -- to be done

  #################
  # Helpers

  include TextUtils::HypertextHelper  # e.g. lets us use link_to, sanitize, etc.

  def path_prefix
    request.script_name   # request.env['SCRIPT_NAME']
  end
  
  def ruby_path
    "#{path_prefix}/ruby"
  end
  
  def rack_path
    "#{path_prefix}/rack"
  end
  
  def env_path
    "#{path_prefix}/env"
  end
  
  def sinatra_path
    "#{path_prefix}/sinatra"
  end
  
  def rails_path
    "#{path_prefix}/rails"
  end

  def root_path
    "#{path_prefix}/"
  end


  ##############################################
  # Controllers / Routing / Request Handlers

###
## todo: add page for gems/gem ?? why? why not?

## todo: add page for threads/thread list ?? why? why not?

  get '/' do
    redirect( ruby_path )
  end

  get '/ruby' do
    erb :ruby
  end

  get '/env' do
    erb :env
  end
  
  get '/rack' do
    erb :rack
  end
  
  get '/sinatra' do
    erb :sinatra
  end

  get '/rails' do
    erb :rails
  end


  get '/d*' do
    erb :debug
  end


end # class Server
end # module About


# say hello
puts About::Server.banner
