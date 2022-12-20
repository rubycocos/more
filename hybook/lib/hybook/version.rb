# encoding: utf-8


module Hybook
  VERSION = '0.2.1'

  def self.banner
    "hybook/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

  def self.templates_path
    "#{root}/templates"
  end

end

## add module alias

HyBook = Hybook

