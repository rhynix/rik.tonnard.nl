require "fileutils"

module Util
  STATIC = Pathname.new(__dir__) / "static"

  def write(name, string)
    rake_output_message "write #{name}"
    mkdir_p name.pathmap("%d")

    when_writing do
      File.write(name, string)
    end
  end

  def static_path(path)
    "/#{path}?#{(STATIC / path).mtime.to_i}"
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
  end

  def render(template, *args, &block)
    scope = Object.new
    scope.extend(Util)

    template = Tilt.new(Pathname.new("templates").join("#{template}.slim"))
    template.render(scope, *args, &block)
  end

  def read(filename)
    File.read(filename)
  end

  def read_yaml(filename)
    YAML.load(read(filename))
  end

  def to_article(source)
    metadata, content = source.split("\n\n", 2)
    YAML.load(metadata).merge(content: content)
  end
end

self.extend(Util)
