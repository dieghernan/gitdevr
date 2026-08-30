template_file <- function(...) {
  system.file(..., package = "gitdevr", mustWork = TRUE)
}

pkgdown_file <- function(...) {
  template_file("pkgdown", ...)
}

brand_file <- function(dark = FALSE) {
  filename <- if (dark) "_brand-dark.yml" else "_brand.yml"
  template_file("brand_yml", filename)
}

read_pkgdown_css <- function() {
  readLines(pkgdown_file("assets", "BS5", "gitdevr.css"), warn = FALSE)
}

read_pkgdown_brand <- function() {
  yaml::read_yaml(pkgdown_file("_pkgdown.yml"))$template$bslib$brand
}

read_template_brand_yml <- function(dark = FALSE) {
  yaml::read_yaml(brand_file(dark))
}

extract_css_vars <- function(css, pattern) {
  matches <- regmatches(css, gregexpr(pattern, css, perl = TRUE))
  unique(unlist(matches, use.names = FALSE))
}

brand_css_variables <- function(palette) {
  stats::setNames(
    unlist(palette, use.names = FALSE),
    paste0("--brand-", gsub("-", "_", names(palette), fixed = TRUE))
  )
}

css_variables <- function(css, selector) {
  block <- css_block(css, selector)
  matches <- gregexpr(
    "--[[:alnum:]_-]+\\s*:\\s*[^;{}]+",
    block,
    perl = TRUE
  )
  declarations <- regmatches(block, matches)[[1]]
  values <- sub("^--[[:alnum:]_-]+\\s*:\\s*", "", declarations)
  names(values) <- sub("\\s*:.*$", "", declarations)
  trimws(values)
}

css_block <- function(css, selector) {
  selector_start <- regexpr(selector, css, fixed = TRUE)[[1]]

  if (selector_start < 0) {
    stop("CSS selector not found: ", selector, call. = FALSE)
  }

  open_brace <- regexpr(
    "{",
    substring(css, selector_start),
    fixed = TRUE
  )[[1]] +
    selector_start -
    1

  if (open_brace < selector_start) {
    stop("CSS selector block not found: ", selector, call. = FALSE)
  }

  css_after_open <- substring(css, open_brace + 1)
  chars <- strsplit(css_after_open, "", fixed = TRUE)[[1]]
  depth <- 1

  for (index in seq_along(chars)) {
    if (identical(chars[[index]], "{")) {
      depth <- depth + 1
    } else if (identical(chars[[index]], "}")) {
      depth <- depth - 1
    }

    if (identical(depth, 0)) {
      return(substring(css_after_open, 1, index - 1))
    }
  }

  stop("CSS selector block not closed: ", selector, call. = FALSE)
}

css_resolve_var <- function(value, variables) {
  pattern <- "var\\((--[[:alnum:]_-]+)(?:,\\s*([^()]+))?\\)"

  while (grepl(pattern, value, perl = TRUE)) {
    variable <- sub(paste0(".*", pattern, ".*"), "\\1", value, perl = TRUE)
    fallback <- sub(paste0(".*", pattern, ".*"), "\\2", value, perl = TRUE)
    replacement <- variables[variable][[1]]

    if (is.null(replacement) || is.na(replacement)) {
      replacement <- fallback
    }

    value <- sub(pattern, replacement, value, perl = TRUE)
  }

  trimws(value)
}

hex_to_rgb <- function(x) {
  x <- gsub("#", "", x, fixed = TRUE)

  if (nchar(x) == 3) {
    channels <- strsplit(x, "", fixed = TRUE)[[1]]
    x <- paste0(channels, channels, collapse = "")
  }

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
  luminance <- function(rgb) {
    rgb <- rgb / 255
    rgb <- ifelse(rgb <= 0.03928, rgb / 12.92, ((rgb + 0.055) / 1.055)^2.4)
    sum(rgb * c(0.2126, 0.7152, 0.0722))
  }

  fg_luminance <- luminance(hex_to_rgb(fg))
  bg_luminance <- luminance(hex_to_rgb(bg))
  (max(fg_luminance, bg_luminance) + 0.05) /
    (min(fg_luminance, bg_luminance) + 0.05)
}
