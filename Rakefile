require "pathname"
require "yaml"
require "tilt"
require "redcarpet"

def static_path(path)
  "/#{path}?#{File.mtime(File.join("static", path)).to_i}"
end

def markdown(text)
  Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
end

def render(template, *args, &block)
  template = Tilt.new(Pathname.new("templates").join("#{template}.slim"))
  template.render(nil, *args, &block)
end

def read(filename)
  File.read(filename)
end

def write(filename, content)
  $stderr.puts("write #{filename}")
  File.write(filename, content)
end

Dir.glob("tasks/*.rake") { |file| load file }

task :default => ["build:all"]
