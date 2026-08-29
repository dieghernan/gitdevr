test_that("test() returns NULL invisibly without console output", {
  expect_silent(result <- test("sample value"))

  expect_null(result)
  expect_invisible(test())
})
