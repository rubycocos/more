require 'hoe'
require './lib/hybook/version.rb'

Hoe.spec 'hybook' do

  self.version = Hybook::VERSION

  self.summary = 'hybook - hypertext book generator'
  self.description = summary

  self.urls    = ['https://github.com/hybook/hybook']

  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.licenses = ['Public Domain']

  self.extra_deps = [
    ['props'],         # settings / prop(ertie)s / env / INI
    ['logutils'],     # logging
    ['textutils'],    # e.g.  >= 0.6 && <= 1.0  ## will include logutils, props
    ['markdown'],  # markdown helper (e.g. link_to etc.)

    ## 3rd party
    ['gli'],
    ['activesupport']
  ]

  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end
