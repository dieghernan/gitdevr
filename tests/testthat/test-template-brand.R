test_that("template pkgdown brand defines its required palette", {
  palette <- read_pkgdown_brand()$color$palette

  expect_named(
    palette[c(
      "dk-black",
      "muted",
      "footer-bg",
      "footer-text",
      "footer-link",
      "dk-gray",
      "dk-border",
      "dk-blue",
      "dk-green",
      "dk-orange",
      "dk-red",
      "dk-purple",
      "dk-code"
    )],
    c(
      "dk-black",
      "muted",
      "footer-bg",
      "footer-text",
      "footer-link",
      "dk-gray",
      "dk-border",
      "dk-blue",
      "dk-green",
      "dk-orange",
      "dk-red",
      "dk-purple",
      "dk-code"
    )
  )

  expect_equal(palette[["muted"]], "#6a788a")
  expect_equal(palette[["gray"]], "#68727b")
  expect_equal(palette[["green"]], "#277f46")
  expect_equal(palette[["orange"]], "#b45306")
  expect_equal(palette[["code"]], "#cf2f7d")
  expect_equal(palette[["footer-bg"]], "#22272e")
  expect_equal(palette[["footer-text"]], "#8b949e")
  expect_equal(palette[["footer-link"]], "#58a6ff")
  expect_equal(palette[["dk-border"]], "#6a788a")
  expect_equal(palette[["dk-gray"]], "#a8b3c1")
  expect_equal(palette[["dk-blue"]], "#79b8ff")
  expect_equal(palette[["dk-code"]], "#ff8cc8")
})

test_that("template dark CSS meets WCAG AA contrast", {
  css <- paste(read_pkgdown_css(), collapse = "\n")
  palette <- read_pkgdown_brand()$color$palette
  variables <- c(
    brand_css_variables(palette),
    css_variables(css, '[data-bs-theme="dark"]')
  )
  variables <- variables[!duplicated(names(variables), fromLast = TRUE)]
  contrast_pairs <- list(
    "body text" = c("--bs-body-color", "--bs-body-bg"),
    "links" = c("--bs-link-color", "--bs-body-bg"),
    "inline code" = c("--bs-code-color", "--bs-body-bg"),
    "syntax comments" = c("--bs-gray-500", "--bs-body-bg"),
    "syntax keywords" = c("--bs-info", "--bs-body-bg"),
    "syntax strings" = c("--bs-success", "--bs-body-bg"),
    "syntax warnings" = c("--bs-warning", "--bs-body-bg"),
    "syntax errors" = c("--bs-danger", "--bs-body-bg")
  )

  ratios <- vapply(
    contrast_pairs,
    \(vars) {
      foreground <- css_resolve_var(variables[[vars[[1]]]], variables)
      background <- css_resolve_var(variables[[vars[[2]]]], variables)
      contrast_ratio(foreground, background)
    },
    numeric(1)
  )

  expect_named(ratios, names(contrast_pairs))
  expect_gte(min(ratios), 4.5)
})

test_that("template standalone dark brand meets WCAG AA contrast", {
  brand <- read_template_brand_yml(dark = TRUE)
  palette <- brand$color$palette

  expect_equal(brand$color$background, "dark")
  expect_equal(brand$color$foreground, "white")
  expect_equal(palette[["gray"]], "#a8b3c1")
  expect_equal(palette[["blue"]], "#79b8ff")
  expect_equal(palette[["code"]], "#ff8cc8")

  dark_pre_bg <- blend_hex(palette[["white"]], palette[["dark"]], 0.03)
  syntax_colors <- c(
    normal = palette[["white"]],
    comment = palette[["gray"]],
    link = palette[["blue"]],
    keyword = palette[["purple"]],
    string = palette[["green"]],
    warning = palette[["orange"]],
    error = palette[["red"]],
    code = palette[["code"]]
  )

  ratios <- vapply(syntax_colors, contrast_ratio, numeric(1), bg = dark_pre_bg)

  expect_gt(min(ratios), 4.5)
})

test_that("template brand sources stay synchronized", {
  brand <- read_template_brand_yml()
  pkgdown_brand <- read_pkgdown_brand()

  expect_equal(brand$color, pkgdown_brand$color)
  expect_equal(brand$typography, pkgdown_brand$typography)
  expect_equal(brand$defaults, pkgdown_brand$defaults)
})

test_that("template brand files are readable by brand.yml", {
  light <- brand.yml::read_brand_yml(brand_file())
  dark <- brand.yml::read_brand_yml(brand_file(dark = TRUE))

  expect_named(
    light,
    c("meta", "logo", "color", "typography", "defaults", "path")
  )
  expect_named(
    dark,
    c("meta", "logo", "color", "typography", "defaults", "path")
  )
  expect_equal(light$color$background, "#ffffff")
  expect_equal(dark$color$background, "#373e47")
})
