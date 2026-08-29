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

test_that("template pkgdown dark syntax meets WCAG AA contrast", {
  palette <- read_pkgdown_brand()$color$palette
  dark_pre_bg <- blend_hex(palette[["white"]], palette[["dark"]], 0.03)
  syntax_colors <- c(
    normal = palette[["white"]],
    comment = palette[["dk-gray"]],
    link = palette[["dk-blue"]],
    keyword = palette[["dk-purple"]],
    string = palette[["dk-green"]],
    warning = palette[["dk-orange"]],
    error = palette[["dk-red"]],
    code = palette[["dk-code"]]
  )

  ratios <- vapply(syntax_colors, contrast_ratio, numeric(1), bg = dark_pre_bg)

  expect_gt(min(ratios), 4.5)
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
