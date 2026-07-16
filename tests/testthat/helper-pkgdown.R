pkgdown_file <- function(...) {
  system.file("pkgdown", ..., package = "gitdevr", mustWork = TRUE)
}

read_pkgdown_css <- function() {
  readLines(pkgdown_file("assets", "BS5", "gitdevr.css"), warn = FALSE)
}

read_pkgdown_brand <- function() {
  yaml::read_yaml(pkgdown_file("_pkgdown.yml"))$template$bslib$brand
}

extract_css_vars <- function(css, pattern) {
  matches <- regmatches(css, gregexpr(pattern, css, perl = TRUE))
  unique(unlist(matches, use.names = FALSE))
}
