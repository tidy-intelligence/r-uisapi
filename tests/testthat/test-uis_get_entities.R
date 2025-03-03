test_that("Get all entities", {
  skip_if_offline()

  result <- uis_get_entities()

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("entity_id", "entity_name", "entity_type", "region_group") %in%
      colnames(result)
  ))
})

test_that("Get entities for specific version", {
  skip_if_offline()

  result <- uis_get_entities("20240910-b5ad4d82")

  expect_s3_class(result, "data.frame")
  expect_true(all(
    c("entity_id", "entity_name", "entity_type", "region_group") %in%
      colnames(result)
  ))
})
