test_that("uis_get requires either entities or indicators", {
  expect_error(
    uis_get(),
    "At least `entities` or `indicators` must be provided"
  )
})

test_that("Get all data for a single indicator", {
  skip_if_offline()

  result <- uis_get(indicators = "CR.1")

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("entity_id", "indicator_id", "year", "value") %in% colnames(result)
  ))
})

test_that("Get all data for a single country", {
  skip_if_offline()

  result <- uis_get(entities = "BRA")

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("entity_id", "indicator_id", "year", "value") %in% colnames(result)
  ))
})

test_that("Get data for multiple indicators and countries", {
  skip_if_offline()

  result <- uis_get(
    entities = c("BRA", "USA"),
    indicators = c("CR.1", "CR.2")
  )

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("entity_id", "indicator_id", "year", "value") %in% colnames(result)
  ))
})

test_that("Get data for multiple indicators, countries, and a time range", {
  skip_if_offline()

  result <- uis_get(
    entities = c("BRA", "USA"),
    indicators = c("CR.1", "CR.2"),
    start_year = 2010,
    end_year = 2020
  )

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("entity_id", "indicator_id", "year", "value") %in% colnames(result)
  ))
})

test_that("uis_get handles wrong inputs gracefully", {
  skip_if_offline()
  expect_message(uis_get(entities = c("XXX"), indicators = c("YYY")))
})
