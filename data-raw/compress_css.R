# Compress with sass
library(sass)

lns <- readLines("inst/pkgdown/assets/BS5/gitdevr.css")

# writeLines(lns, "inst/pkgdown/assets/BS5/gitdevr.min.css")

sass(
  lns,
  "inst/pkgdown/assets/BS5/gitdevr.min.css",
  cache = NULL,
  options = sass_options(output_style = "compressed")
)

message("OK, compressed")
