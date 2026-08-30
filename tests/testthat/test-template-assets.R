test_that("installed template contains every required resource", {
  paths <- c(
    pkgdown_file("_pkgdown.yml"),
    pkgdown_file("assets", "BS5", "gitdevr.css"),
    pkgdown_file("assets", "BS5", "gitdevr.min.css"),
    pkgdown_file("templates", "in-header.html"),
    pkgdown_file("templates", "navbar.html"),
    brand_file(),
    brand_file(dark = TRUE),
    template_file("brand_yml", "assets", "favicon.ico"),
    template_file("brand_yml", "assets", "favicon.png"),
    template_file("brand_yml", "assets", "logo.png"),
    template_file("schemaorg.json")
  )

  expect_equal(file.exists(paths), rep(TRUE, length(paths)))
  expect_gt(min(unname(file.info(paths)$size)), 0)
})

test_that("brand logo references resolve inside the installed template", {
  brand_paths <- c(brand_file(), brand_file(dark = TRUE))
  logo_paths <- unlist(
    lapply(brand_paths, \(path) {
      brand <- yaml::read_yaml(path)
      file.path(dirname(path), sub("^\\./", "", brand$logo$images))
    }),
    use.names = FALSE
  )

  expect_equal(file.exists(logo_paths), rep(TRUE, length(logo_paths)))
  expect_gt(min(unname(file.info(logo_paths)$size)), 0)
})

test_that("schemaorg.json describes the package as software source code", {
  schema <- jsonlite::read_json(template_file("schemaorg.json"))

  expect_equal(schema[["@context"]], "https://schema.org")
  expect_equal(schema[["type"]], "SoftwareSourceCode")
  expect_equal(schema[["name"]], "gitdevr: My 'pkgdown' template")
  expect_equal(
    schema[["codeRepository"]],
    "https://github.com/dieghernan/gitdevr"
  )
  expect_equal(schema[["programmingLanguage"]][["name"]], "R")
})
