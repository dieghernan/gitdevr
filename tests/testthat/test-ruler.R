test_that("ruler prints expected markers", {
  output <- capture.output(ruler(12))

  expect_equal(output, c("----+----1--", "123456789012"))
})

test_that("test fixture returns NULL", {
  expect_null(test())
})
