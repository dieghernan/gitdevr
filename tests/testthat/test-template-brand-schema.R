test_that("template brand files validate against the published schema", {
  testthat::skip_if_offline("posit-dev.github.io")

  schema_url <- "https://posit-dev.github.io/brand-yml/schema/brand.schema.json"
  schema <- tempfile(fileext = ".json")
  withr::defer(unlink(schema))

  schema_url |>
    jsonlite::read_json() |>
    jsonlite::write_json(schema, auto_unbox = TRUE)

  brand_files <- c(brand_file(), brand_file(dark = TRUE))

  for (path in brand_files) {
    brand_json <- path |>
      yaml::read_yaml() |>
      jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)
    valid <- jsonvalidate::json_validate(
      brand_json,
      schema = schema,
      engine = "ajv"
    )

    expect_true(valid, info = basename(path))
  }
})
