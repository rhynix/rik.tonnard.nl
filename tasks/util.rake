require "webrick"

task "build:all" => ["build:articles", "build:static"]

task "clean" do
  rm_rf "build"
end

task :serve => ["build/index.html"] do
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
