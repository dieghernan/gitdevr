test_that("template configures pkgdown and Bootstrap 5", {
  config <- yaml::read_yaml(pkgdown_file("_pkgdown.yml"))

  expect_equal(config$template$bootstrap, 5)
  expect_equal(config$template$`math-rendering`, "katex")
  expect_true(config$template$`light-switch`)
  expect_equal(config$navbar, list(bg = "dark", type = "dark"))
  expect_named(
    config$template$bslib$brand,
    c("color", "typography", "defaults")
  )
})

test_that("template HTML preserves the pkgdown hooks it overrides", {
  header <- paste(
    readLines(pkgdown_file("templates", "in-header.html"), warn = FALSE),
    collapse = "\n"
  )
  navbar <- paste(
    readLines(pkgdown_file("templates", "navbar.html"), warn = FALSE),
    collapse = "\n"
  )
  navbar_hooks <- c(
    "{{#navbar}}",
    "{{#site}}",
    "{{#package}}",
    "{{#left}}",
    "{{#right}}",
    "{{#includes}}"
  )

  expect_match(header, "{{#site}}{{root}}{{/site}}", fixed = TRUE)
  expect_match(header, "BS5/gitdevr.min.css", fixed = TRUE)
  expect_equal(
    unname(vapply(navbar_hooks, grepl, logical(1), x = navbar, fixed = TRUE)),
    rep(TRUE, length(navbar_hooks))
  )
})

test_that("template HTML references the installed minified stylesheet", {
  header <- paste(
    readLines(pkgdown_file("templates", "in-header.html"), warn = FALSE),
    collapse = "\n"
  )
  stylesheet <- pkgdown_file("assets", "BS5", "gitdevr.min.css")

  expect_match(header, "BS5/gitdevr.min.css", fixed = TRUE)
  expect_gt(file.size(stylesheet), 0)
})
