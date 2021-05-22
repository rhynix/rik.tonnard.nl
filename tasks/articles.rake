articles = Rake::FileList["articles/*.md"]

task "site:articles" => [
  "build/index.html",
  *articles.pathmap("build/%n/index.html")
]

file "templates/_layout.html.slim" => ["static/style.css"]

file "templates/article.html.slim" => [
  "templates/_layout.html.slim",
  "templates/_article.html.slim"
]

file "templates/index.html.slim" => [
  "templates/_layout.html.slim",
  "templates/_article.html.slim"
]

file "build/index.html" => [
  *articles,
  "build",
  "templates/index.html.slim"
] do |task|
  articles = articles.sort.reverse.map do |file|
    source = read(file)
    to_article(source).merge(permalink: file.pathmap("/%n"))
  end

  write task.name, render("index.html", articles: articles)
end

articles.each do |article|
  file article.pathmap("build/%n/index.html") => [
    article,
    "build",
    "templates/article.html.slim"
  ] do |task|
    source = read(task.source)
    article = to_article(source).merge(permalink: task.name.pathmap("/%-1d"))

    write task.name, render("article.html", article: article)
  end
end
