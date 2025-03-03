test_that("Get all files", {
  skip_if_offline()

  result <- uis_bulk_files()

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("file_name", "file_url", "last_updated") %in%
      colnames(result)
  ))
})

test_that("uis_bulk_files handels connection errors", {
  with_mocked_bindings(
    req_perform = function(...) {
      stop("API connection error: Connection timed out")
    },
    expect_error(
      uis_bulk_files(),
      "Check your internet connection."
    )
  )
})
