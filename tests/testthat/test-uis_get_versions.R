test_that("Get all versions", {
  skip_if_offline()

  result <- uis_get_versions()

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("version", "publication_date", "description", "theme") %in%
      colnames(result)
  ))
})

test_that("Get default version", {
  skip_if_offline()

  result <- uis_get_versions(default_only = TRUE)

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("version", "publication_date", "description", "theme") %in%
      colnames(result)
  ))
})
