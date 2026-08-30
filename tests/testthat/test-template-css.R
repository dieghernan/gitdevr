test_that("template CSS consumes brand variables without redefining them", {
  css <- paste(read_pkgdown_css(), collapse = "\n")
  brand_definitions <- extract_css_vars(
    css,
    "--brand-[A-Za-z0-9_-]+[[:space:]]*:"
  )
  brand_uses <- extract_css_vars(css, "var\\(--brand-[A-Za-z0-9_-]+\\)")

  expect_length(brand_definitions, 0)
  expect_gt(length(brand_uses), 0)
})

test_that("template CSS only consumes generated brand variables", {
  css <- paste(read_pkgdown_css(), collapse = "\n")
  palette_names <- names(read_pkgdown_brand()$color$palette)
  generated_vars <- paste0(
    "--brand-",
    gsub("-", "_", palette_names, fixed = TRUE)
  )
  used_vars <- extract_css_vars(css, "var\\((--brand-[A-Za-z0-9_-]+)\\)")
  used_vars <- sub("^var\\(", "", sub("\\)$", "", used_vars))

  expect_setequal(setdiff(used_vars, generated_vars), character())
})

test_that("template minified CSS matches its source", {
  skip_if_not_installed("sass")

  source_path <- pkgdown_file("assets", "BS5", "gitdevr.css")
  minified_path <- pkgdown_file("assets", "BS5", "gitdevr.min.css")
  expected <- sass::sass(
    readLines(source_path, warn = FALSE),
    cache = NULL,
    options = sass::sass_options(output_style = "compressed")
  )
  expected <- sub("\n$", "", as.character(expected))
  actual <- paste(readLines(minified_path, warn = FALSE), collapse = "\n")

  expect_equal(actual, expected)
})

test_that("template stylesheets cover light and dark components", {
  paths <- pkgdown_file(
    "assets",
    "BS5",
    c("gitdevr.css", "gitdevr.min.css")
  )
  stylesheets <- lapply(
    paths,
    \(path) paste(readLines(path, warn = FALSE), collapse = "\n")
  )
  selectors <- c(
    '[data-bs-theme="dark"]',
    ".navbar",
    "footer",
    "pre",
    ".callout"
  )
  contains_selectors <- vapply(
    stylesheets,
    \(css) all(vapply(selectors, grepl, logical(1), x = css, fixed = TRUE)),
    logical(1)
  )

  expect_equal(contains_selectors, c(TRUE, TRUE))
  expect_lt(file.size(paths[[2]]), file.size(paths[[1]]))
})
