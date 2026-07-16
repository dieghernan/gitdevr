pkgdown_file <- function(...) {
  system.file("pkgdown", ..., package = "gitdevr", mustWork = TRUE)
}

read_pkgdown_css <- function() {
  readLines(pkgdown_file("assets", "BS5", "gitdevr.css"), warn = FALSE)
}

read_pkgdown_brand <- function() {
  yaml::read_yaml(pkgdown_file("_pkgdown.yml"))$template$bslib$brand
}

read_template_brand_yml <- function() {
  yaml::read_yaml(system.file(
    "brand_yml",
    "_brand.yml",
    package = "gitdevr",
    mustWork = TRUE
  ))
}

read_template_brand_dark_yml <- function() {
  yaml::read_yaml(system.file(
    "brand_yml",
    "_brand-dark.yaml",
    package = "gitdevr",
    mustWork = TRUE
  ))
}

extract_css_vars <- function(css, pattern) {
  matches <- regmatches(css, gregexpr(pattern, css, perl = TRUE))
  unique(unlist(matches, use.names = FALSE))
}

hex_to_rgb <- function(x) {
  x <- gsub("#", "", x)
  c(
    strtoi(substr(x, 1, 2), 16L),
    strtoi(substr(x, 3, 4), 16L),
    strtoi(substr(x, 5, 6), 16L)
  )
}

rgb_to_hex <- function(rgb) {
  sprintf("#%02x%02x%02x", round(rgb[1]), round(rgb[2]), round(rgb[3]))
}

blend_hex <- function(fg, bg, alpha) {
  rgb_to_hex(hex_to_rgb(fg) * alpha + hex_to_rgb(bg) * (1 - alpha))
}

contrast_ratio <- function(fg, bg) {
  luminance <- function(x) {
    rgb <- hex_to_rgb(x) / 255
    rgb <- ifelse(
      rgb <= 0.03928,
      rgb / 12.92,
      ((rgb + 0.055) / 1.055)^2.4
    )
    sum(rgb * c(0.2126, 0.7152, 0.0722))
  }

  fg_luminance <- luminance(fg)
  bg_luminance <- luminance(bg)
  (max(fg_luminance, bg_luminance) + 0.05) /
    (min(fg_luminance, bg_luminance) + 0.05)
}
