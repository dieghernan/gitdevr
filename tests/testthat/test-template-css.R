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

test_that("code palettes preserve accessible GitHub and One Dark colors", {
  css <- paste(read_pkgdown_css(), collapse = "\n")
  highlight <- substring(
    css,
    regexpr("/* --- Syntax highlighting:", css, fixed = TRUE)
  )
  light <- css_variables(highlight, "pre")
  dark <- css_variables(highlight, '[data-bs-theme="dark"] pre')
  roles <- paste0(
    "--gitdevr-hl-",
    c(
      "bg",
      "fg",
      "comment",
      "keyword",
      "number",
      "string",
      "function",
      "operator"
    )
  )

  expect_equal(
    unname(light[roles]),
    c(
      "#f6f8fa",
      "#24292f",
      "#6a737d",
      "#cf222e",
      "#0550ae",
      "#0a3069",
      "#8250df",
      "#0550ae"
    )
  )
  expect_equal(
    unname(dark[roles]),
    c(
      "#282c34",
      "#abb2bf",
      "#8e939d",
      "#c678dd",
      "#d19a66",
      "#98c379",
      "#61afef",
      "#56b6c2"
    )
  )
})

test_that("highlighted text meets AA contrast on its code background", {
  css <- paste(read_pkgdown_css(), collapse = "\n")
  highlight <- substring(
    css,
    regexpr("/* --- Syntax highlighting:", css, fixed = TRUE)
  )
  for (selector in c("pre", '[data-bs-theme="dark"] pre')) {
    colors <- css_variables(highlight, selector)
    roles <- setdiff(
      names(colors),
      c("--gitdevr-hl-bg", "--gitdevr-hl-error-bg")
    )
    ratios <- vapply(
      roles,
      \(role) {
        background <- colors[["--gitdevr-hl-bg"]]
        if (
          role == "--gitdevr-hl-error" &&
            colors[["--gitdevr-hl-error-bg"]] != "transparent"
        ) {
          background <- colors[["--gitdevr-hl-error-bg"]]
        }
        contrast_ratio(colors[[role]], background)
      },
      numeric(1)
    )
    expect_gte(min(ratios), 4.5)
  }
})

test_that("Bootstrap RGB companions match their brand colors", {
  css <- paste(read_pkgdown_css(), collapse = "\n")
  variables <- css_variables(css, '[data-bs-theme="dark"]')
  palette <- read_pkgdown_brand()$color$palette
  names(palette) <- gsub("-", "_", names(palette), fixed = TRUE)
  rgb_names <- grep("-rgb$", names(variables), value = TRUE)

  expect_gt(length(rgb_names), 0)
  for (name in rgb_names) {
    color <- variables[[sub("-rgb$", "", name)]]
    brand_name <- sub("^var\\(--brand-([a-z0-9_]+)\\)$", "\\1", color)
    channels <- paste(hex_to_rgb(palette[[brand_name]]), collapse = ", ")
    expect_equal(variables[[name]], channels, info = name)
  }
})

test_that("callout masks retain six color-independent shapes after minifying", {
  paths <- pkgdown_file(
    "assets",
    "BS5",
    c("gitdevr.css", "gitdevr.min.css")
  )
  for (path in paths) {
    css <- paste(readLines(path, warn = FALSE), collapse = "\n")
    masks <- regmatches(
      css,
      gregexpr("--gitdevr-callout-mask:\\s*url\\('[^']+'\\)", css)
    )[[1]]

    expect_length(masks, 6)
    expect_no_match(paste(masks, collapse = "\n"), "style=|\\bfill=")
    expect_match(css, "background-color:\\s*currentColor")
    expect_match(css, "-webkit-mask-image:\\s*var\\(--gitdevr-callout-mask\\)")
    expect_match(
      css,
      "[;[:space:]]mask-image:\\s*var\\(--gitdevr-callout-mask\\)"
    )
    for (shape in c(
      "info-circle",
      "lightbulb",
      "exclamation-triangle",
      "cone-striped",
      "exclamation-circle",
      "chevron-down"
    )) {
      expect_match(paste(masks, collapse = "\n"), paste0("bi-", shape))
    }
  }
})

test_that("narrow navbars retain compact title and version sizing", {
  skip_if_not_installed("sass")

  css <- as.character(sass::sass(
    readLines(pkgdown_file("assets", "BS5", "gitdevr.css"), warn = FALSE),
    cache = NULL,
    options = sass::sass_options(output_style = "expanded")
  ))
  narrow <- regmatches(
    css,
    regexpr(
      "@media \\(max-width: 375px\\) \\{[\\s\\S]*?\n\\}",
      css,
      perl = TRUE
    )
  )

  expect_match(narrow, "\\.navbar-brand\\s*\\{\\s*font-size: 1\\.125rem;")
  expect_match(narrow, "\\.navbar \\.nav-text\\s*\\{\\s*font-size: 0?\\.65rem;")
})
