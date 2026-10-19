# Compress CSS with `sass`.
library(sass)

source_path <- "inst/pkgdown/assets/BS5/gitdevr.css"
lns <- paste(readLines(source_path), collapse = "\n")
palette <- yaml::read_yaml("inst/brand_yml/_brand.yml")$color$palette
names(palette) <- gsub("-", "_", names(palette), fixed = TRUE)

# Keep Bootstrap's RGB utilities in sync with the same brand colors.
pattern <- "--bs-[a-z0-9-]+: var\\(--brand-[a-z0-9_]+\\);"
declarations <- regmatches(lns, gregexpr(pattern, lns))[[1]]
for (declaration in declarations) {
  property <- sub(":.*", "", declaration)
  color <- sub(".*--brand-([a-z0-9_]+)\\);", "\\1", declaration)
  channels <- paste(grDevices::col2rgb(palette[[color]])[, 1], collapse = ", ")
  lns <- gsub(
    paste0(property, "-rgb: [^;]+;"),
    paste0(property, "-rgb: ", channels, ";"),
    lns
  )
}
writeLines(lns, source_path)

sass(
  lns,
  "inst/pkgdown/assets/BS5/gitdevr.min.css",
  cache = NULL,
  options = sass_options(output_style = "compressed")
)

message("Compression complete.")
