schema_json <- jsonlite::read_json(
  "https://posit-dev.github.io/brand-yml/schema/brand.schema.json"
) |>
  jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)

tmp_json_file <- tempfile(fileext = ".json")
jsonlite::write_json(schema_json, tmp_json_file)

validate_brand <- function(path, schema) {
  json_brand <- yaml::read_yaml(path) |>
    jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)

  valid <- jsonvalidate::json_validate(
    json_brand,
    schema = schema,
    verbose = TRUE
  )

  if (valid) {
    message("`", path, "` is valid.")
  }

  valid
}

brand_files <- c(
  "inst/brand_yml/_brand.yml",
  "inst/brand_yml/_brand-dark.yml"
)

valid <- vapply(
  brand_files,
  validate_brand,
  logical(1),
  schema = tmp_json_file
)

if (!all(valid)) {
  stop("Invalid brand YAML file.", call. = FALSE)
}
