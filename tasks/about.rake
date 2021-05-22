task "site:about" => ["build/about/index.html"]

file "build/about/index.html" => [
  "data/resume.yaml",
  "templates/about.html.slim",
  :build
] do |task|
  resume = read_yaml(task.source)

  mkdir_p task.name.pathmap("%d")
  write task.name, render("about.html", resume: resume) 
end
