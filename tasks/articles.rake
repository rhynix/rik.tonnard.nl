def to_article(source)
  metadata, content = source.split("\n\n", 2)
  YAML.load(metadata).merge(content: content)
end

articles = Rake::FileList["articles/*.md"]

task "build:articles" => [
  "build/index.html",
  articles.pathmap("build/%n/index.html")
]

file "templates/_layout.html.slim" => ["build/style.css"]
file "templates/_article.html.slim"

file "templates/article.html.slim" => [
  "templates/_layout.html.slim",
  "templates/_article.html.slim"
]

file "templates/index.html.slim" => [
  "templates/_layout.html.slim",
  "templates/_article.html.slim"
]

file "build/index.html" => [articles, "templates/index.html.slim"] do |task|
  articles = articles.sort.reverse.map do |file|
    source = read(file)
    to_article(source).merge(permalink: file.pathmap("/%n"))
  end

  write task.name, render("index.html", title: "Index", articles: articles)
end

articles.each do |article|
  file article.pathmap("build/%n/index.html") => [
    article,
    "templates/article.html.slim"
  ] do |task|
    mkdir_p task.name.pathmap("%d")

    source = read(task.source)
    article = to_article(source).merge(permalink: task.name.pathmap("/%-1d"))

    write task.name, render("article.html", article: article)
  end
end
