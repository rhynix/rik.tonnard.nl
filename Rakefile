require "pathname"
require "yaml"
require "tilt"
require "redcarpet"

require_relative "./util"

Dir.glob("tasks/*.rake") { |file| load file }

task :site => %w[site:about site:articles site:static]
task :default => %w[site]
