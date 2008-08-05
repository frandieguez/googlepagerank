# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/googlepagerank.rb'
include FileUtils
require File.join(File.dirname(__FILE__), 'lib', 'version')
AUTHOR = 'frandieguez'  # can also be an array of Authors
EMAIL = "fran.dieguez@mabishu.com"
DESCRIPTION = "Ruby gem for fetching Google PageRank®"
GEM_NAME = 'googlepagerank' # what ppl will type to install your gem
RUBYFORGE_PROJECT = 'googlepagerank' # The unix name for your project
HOMEPATH = "http://#{RUBYFORGE_PROJECT}.rubyforge.org"
DOWNLOAD_PATH = "http://rubyforge.org/projects/#{RUBYFORGE_PROJECT}"

NAME = "googlepagerank"
REV = nil # UNCOMMENT IF REQUIRED: File.read(".svn/entries")[/committed-rev="(d+)"/, 1] rescue nil
VERS = GooglePageRank::VERSION::STRING + (REV ? ".#{REV}" : "")

hoe = Hoe.new(GEM_NAME, VERS) do |p|
  p.author = AUTHOR 
  p.description = DESCRIPTION
  p.email = EMAIL
  p.summary = DESCRIPTION
  p.url = HOMEPATH
  p.rubyforge_name = RUBYFORGE_PROJECT if RUBYFORGE_PROJECT
  p.test_globs = ["test/**/test_*.rb"]
  
  # == Optional
  p.changes = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.extra_deps = [['hpricot', '>=0.4.86'], ['activesupport', '>=1.4.2']]     # An array of rubygem dependencies [name, version], e.g. [ ['active_support', '>= 1.3.1'] ]
  #p.spec_extras = {}    # A hash of extra values to set in the gemspec.
end


desc 'Upload website files to rubyforge'
task :website do
  config = YAML.load(File.read(File.expand_path("~/.rubyforge/user-config.yml")))
  host = "#{config["username"]}@rubyforge.org"
  remote_dir = "/var/www/gforge-projects/#{RUBYFORGE_PROJECT}/"
  # remote_dir = "/var/www/gforge-projects/#{RUBYFORGE_PROJECT}/#{GEM_NAME}"
  local_dir = 'website'
  sh %{rsync -av #{local_dir}/ #{host}:#{remote_dir}}
end

desc 'Release the website and new gem version'
task :deploy => [:check_version, :website, :release]

task :check_version do
  unless ENV['VERSION']
    puts 'Must pass a VERSION=x.y.z release version'
    exit
  end
  unless ENV['VERSION'] == VERS
    puts "Please update your version.rb to match the release version, currently #{VERS}"
    exit
  end
end
# vim: syntax=Ruby
