directory "build"

fonts = Rake::FileList[
  "build/Fraunces-Italic.ttf",
  "build/Fraunces.ttf",
  "build/MerriweatherSans-Italic.ttf",
  "build/MerriweatherSans.ttf",
]

task "site:static" => [
  "build/style.css",
  *fonts
]

fonts.each do |font|
  file font => [font.pathmap("static/%f"), :build] do |task|
    cp task.source, task.name
  end
end

file "build/style.css" => ["static/style.css", :build] do |task|
  cp task.source, task.name
end
