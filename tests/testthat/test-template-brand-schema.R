test_that("template brand files validate against the published schema", {
  testthat::skip_if_offline("posit-dev.github.io")

  schema_url <- "https://posit-dev.github.io/brand-yml/schema/brand.schema.json"
  schema <- tempfile(fileext = ".json")
  withr::defer(unlink(schema))

  schema_url |>
    jsonlite::read_json() |>
    jsonlite::write_json(schema, auto_unbox = TRUE)

  brand_files <- c(brand_file(), brand_file(dark = TRUE))
  valid <- vapply(
    brand_files,
    \(path) {
      brand_json <- path |>
        yaml::read_yaml() |>
        jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)
      jsonvalidate::json_validate(
        brand_json,
        schema = schema,
        engine = "ajv"
      )
    },
    logical(1)
  )
  names(valid) <- basename(brand_files)

  expect_equal(
    valid,
    stats::setNames(rep(TRUE, length(brand_files)), basename(brand_files))
  )
})
