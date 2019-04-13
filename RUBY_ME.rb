require 'ruby-graphviz'

load_path = []
$LOAD_PATH.each { |path| load_path << path }

# lib = File.expand_path "~/.rbenv/versions/2.5.5/lib/ruby/gems/2.5.0/gems/ruby-graphviz-1.2.4/lib"
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

puts "Loading app..."
# path = '~/carrot/customers/instacart'
path = '~/c/ghost'
# path = '~/c/tux'

old_path = Dir.pwd
path = File.expand_path path
Dir.chdir path
env_path = File.join path, "config/environment.rb"
require env_path
Rails.application.eager_load!
Rails.application.config.eager_load_namespaces.each(&:eager_load!) if Rails.application.config.respond_to?(:eager_load_namespaces)


puts "Generating Entity-Relationship Diagram for #{ActiveRecord::Base.descendants.length} models..."
Dir.chdir old_path

load_path.each { |path| $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path) }
lib = File.expand_path("../lib", __FILE__) # doesn't matter if run via `ruby` or `irb`
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


require "rails_erd/diagram/graphviz"
RailsERD::Diagram::Graphviz.create

puts "Done generating diagram!"
