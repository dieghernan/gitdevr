test_that("brand YAML files validate against the remote brand schema", {
  testthat::skip_if_offline("posit-dev.github.io")

  schema_url <- "https://posit-dev.github.io/brand-yml/schema/brand.schema.json"
  schema <- tempfile(fileext = ".json")
  schema_json <- jsonlite::read_json(schema_url)
  jsonlite::write_json(schema_json, schema, auto_unbox = TRUE)

  brand_files <- c(
    system.file(
      "brand_yml",
      "_brand.yml",
      package = "gitdevr",
      mustWork = TRUE
    ),
    system.file(
      "brand_yml",
      "_brand-dark.yml",
      package = "gitdevr",
      mustWork = TRUE
    )
  )

  for (brand_file in brand_files) {
    json_brand <- yaml::read_yaml(brand_file) |>
      jsonlite::toJSON(pretty = TRUE, auto_unbox = TRUE)

    expect_equal(
      jsonvalidate::json_validate(json_brand, schema = schema, engine = "ajv"),
      TRUE,
      info = brand_file
    )
  }
})
