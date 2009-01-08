# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/mailtrap.rb'

Hoe.new('mailtrap', Mailtrap::Base::VERSION ) do |p|
  p.rubyforge_name = 'simplyruby'
  p.author = 'Matt Mower'
  p.email = 'self@mattmower.com'
  p.summary = 'Mailtrap is a mock SMTP server for use in Rails development'
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = 'mailtrap'
  p.extra_deps << ['daemons','>= 1.0.8'] 
  p.extra_deps << ['trollop','>= 1.7']
end

# vim: syntax=Ruby
