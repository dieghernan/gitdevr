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
