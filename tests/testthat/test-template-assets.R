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

  expect_gt(min(unname(file.info(paths)$size)), 0)
})

test_that("template configuration has the expected pkgdown structure", {
  config <- yaml::read_yaml(pkgdown_file("_pkgdown.yml"))

  expect_equal(config$navbar[c("bg", "type")], list(bg = "dark", type = "dark"))
  expect_identical(config$template$bootstrap, 5L)
  expect_true(config$template$`light-switch`)
  expect_named(
    config$template$bslib$brand,
    c("color", "typography", "defaults")
  )
})

test_that("brand logo references resolve inside the installed template", {
  for (path in c(brand_file(), brand_file(dark = TRUE))) {
    brand <- yaml::read_yaml(path)
    logo_paths <- file.path(dirname(path), sub("^\\./", "", brand$logo$images))

    expect_gt(min(unname(file.info(logo_paths)$size)), 0)
  }
})

test_that("brand files are readable by brand.yml", {
  light <- brand.yml::read_brand_yml(brand_file())
  dark <- brand.yml::read_brand_yml(brand_file(dark = TRUE))

  expect_s3_class(light, "brand_yml")
  expect_s3_class(dark, "brand_yml")
  expect_equal(light$color$background, "#ffffff")
  expect_equal(dark$color$background, "#373e47")
})
