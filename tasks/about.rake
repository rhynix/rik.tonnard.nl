task "build:about" => ["build/about/index.html"]

resume_path = "data/resume.yaml"

file "build/about/index.html" => [resume_path, "templates/about.html.slim"] do |task|
  mkdir_p task.name.pathmap("%d")
  resume = read_yaml(resume_path)

  write task.name, render("about.html", resume: resume) 
end
