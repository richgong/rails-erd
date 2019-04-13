lib = File.expand_path("../lib", __FILE__) # doesn't matter if run via `ruby` or `irb`
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
lib = File.expand_path "~/.rbenv/versions/2.5.5/lib/ruby/gems/2.5.0/gems/ruby-graphviz-1.2.4/lib"
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "~/c/ghost/config/environment.rb"

Rails.application.eager_load!
Rails.application.config.eager_load_namespaces.each(&:eager_load!) if Rails.application.config.respond_to?(:eager_load_namespaces)
puts "Generating Entity-Relationship Diagram for #{ActiveRecord::Base.descendants.length} models..."

require 'ruby-graphviz'
require "rails_erd/diagram/graphviz"
RailsERD::Diagram::Graphviz.create
