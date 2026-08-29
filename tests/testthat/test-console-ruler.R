test_that("ruler() prints markers at the requested width", {
  output <- capture.output(ruler(12))

  expect_equal(output, c("----+----1--", "123456789012"))
  expect_equal(nchar(output), c(12L, 12L))
})

test_that("ruler() uses the console width by default", {
  withr::local_options(width = 10L)

  output <- capture.output(ruler())

  expect_equal(output, c("----+----1", "1234567890"))
})
