require "webrick"

task "build:all" => ["build:about", "build:articles", "build:static"]

task "clean" do
  rm_rf "build"
end

task :serve do
  root = File.expand_path('build')
  server = WEBrick::HTTPServer.new(
    :Port => 8000,
    :DocumentRoot => root
  )

  trap 'INT' do
    server.stop
  end

  server.start
end
