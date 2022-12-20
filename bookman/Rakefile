require 'hoe'
require './lib/bookman/version.rb'

Hoe.spec 'bookman' do

  self.version = Bookman::VERSION

  self.summary = 'bookman - yet another builder for books'
  self.description = summary

  self.urls    = ['https://github.com/hybook/bookman']

  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.licenses = ['Public Domain']

  self.extra_deps = [
    ['hybook'],         # settings / prop(ertie)s / env / INI
    ['bookfile'],       # logging
    ['fetcher'],   ## todo: check if included in ??
    ['rubyzip'],   ## todo: check if included in ??
    ### todo: add datafile ???
  ]

  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end

