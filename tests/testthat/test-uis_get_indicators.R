test_that("Get all indicators", {
  skip_if_offline()

  result <- uis_get_indicators()

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("indicator_id", "indicator_name", "theme", "last_data_update") %in%
      colnames(result)
  ))
})

test_that("Get all indicators for specific version with extras", {
  skip_if_offline()

  result <- uis_get_indicators(
    version = "20240910-b5ad4d82",
    disaggregations = TRUE,
    glossary_terms = TRUE
  )

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("indicator_id", "indicator_name", "theme", "last_data_update") %in%
      colnames(result)
  ))
})
