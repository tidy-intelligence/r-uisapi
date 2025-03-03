test_that("perform_request handles API failure correctly", {
  with_mocked_bindings(
    req_perform = function(...) {
      stop("API connection error: Connection timed out")
    },
    expect_error(
      perform_request("sdg4"),
      "Check your internet connection and function parameters."
    )
  )
})
