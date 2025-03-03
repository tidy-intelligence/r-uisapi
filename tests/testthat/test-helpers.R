test_that("convert_to_snake_case properly converts camelCase to snake_case", {
  df <- data.frame(
    firstName = c("John", "Jane"),
    lastName = c("Doe", "Smith"),
    userID = c(1, 2),
    stringsAsFactors = FALSE
  )

  result <- convert_to_snake_case(df)
  expect_equal(names(result), c("first_name", "last_name", "user_id"))
  expect_equal(result$first_name, c("John", "Jane"))
  expect_equal(result$last_name, c("Doe", "Smith"))
  expect_equal(result$user_id, c(1, 2))
})

test_that("convert_to_snake_case properly converts PascalCase to snake_case", {
  df <- data.frame(
    FirstName = c("John", "Jane"),
    LastName = c("Doe", "Smith"),
    UserID = c(1, 2),
    stringsAsFactors = FALSE
  )
  result <- convert_to_snake_case(df)
  expect_equal(names(result), c("first_name", "last_name", "user_id"))
})

test_that("convert_to_snake_case converts mixed case styles correctly", {
  df <- data.frame(
    firstName = c("John", "Jane"),
    LastName = c("Doe", "Smith"),
    user_id = c(1, 2),
    DATA_VALUE = c(100, 200),
    stringsAsFactors = FALSE
  )
  result <- convert_to_snake_case(df)
  expect_equal(
    names(result),
    c("first_name", "last_name", "user_id", "data_value")
  )
})

test_that("convert_to_snake_case handles empty dataframes", {
  df <- data.frame()
  result <- convert_to_snake_case(df)
  expect_equal(dim(result), c(0, 0))
})

test_that("convert_to_snake_case preserves already snake_case names", {
  df <- data.frame(
    first_name = c("John", "Jane"),
    last_name = c("Doe", "Smith"),
    user_id = c(1, 2),
    stringsAsFactors = FALSE
  )
  result <- convert_to_snake_case(df)
  expect_equal(names(result), c("first_name", "last_name", "user_id"))
})

test_that("validate_logical accepts valid logical values", {
  expect_no_error(validate_logical(TRUE, "flag"))
  expect_no_error(validate_logical(FALSE, "flag"))
})

test_that("validate_logical rejects non-logical values", {
  expect_error(
    validate_logical(1, "flag"),
    regexp = "`flag` must be a logical"
  )
  expect_error(
    validate_logical("TRUE", "flag"),
    regexp = "`flag` must be a logical"
  )
  expect_error(
    validate_logical(NA, "flag"),
    regexp = "`flag` must be a logical"
  )
  expect_error(
    validate_logical(NULL, "flag"),
    regexp = "`flag` must be a logical"
  )
  expect_error(
    validate_logical(list(TRUE), "flag"),
    regexp = "`flag` must be a logical"
  )
})

test_that("validate_logical uses the correct argument name in error messages", {
  expect_error(
    validate_logical(1, "is_active"),
    regexp = "`is_active` must be a logical"
  )
  expect_error(
    validate_logical("TRUE", "verbose"),
    regexp = "`verbose` must be a logical"
  )
})

test_that("validate_character_vector accepts valid character vectors", {
  expect_no_error(validate_character_vector("test", "arg1"))
  expect_no_error(validate_character_vector(c("a", "b", "c"), "arg1"))
  expect_no_error(validate_character_vector(character(0), "arg1"))
  expect_no_error(validate_character_vector(NULL, "arg1"))
})

test_that("validate_character_vector rejects non-character vectors", {
  expect_error(
    validate_character_vector(1, "arg1"),
    regexp = "`arg1` must be a character vector"
  )
  expect_error(
    validate_character_vector(TRUE, "arg1"),
    regexp = "`arg1` must be a character vector"
  )
  expect_error(
    validate_character_vector(list("a"), "arg1"),
    regexp = "`arg1` must be a character vector"
  )
})

test_that("validate_character_vector rejects vectors with NA values", {
  expect_error(
    validate_character_vector(c("a", NA), "arg1"),
    regexp = "`arg1` must be a character vector"
  )
  expect_error(
    validate_character_vector(NA_character_, "arg1"),
    regexp = "`arg1` must be a character vector"
  )
})

test_that("validate_character_vector uses argument name in error messages", {
  expect_error(
    validate_character_vector(1, "custom_name"),
    regexp = "`custom_name` must be a character vector"
  )
})

test_that("validate_year accepts valid numeric years", {
  expect_no_error(validate_year(2022, "year"))
  expect_no_error(validate_year(c(2020, 2021, 2022), "year"))
  expect_no_error(validate_year(1900.5, "year"))
  expect_no_error(validate_year(NULL, "year"))
})

test_that("validate_year rejects non-numeric years", {
  expect_error(
    validate_year("2022", "year"),
    regexp = "`year` must be an integer"
  )
  expect_error(
    validate_year(TRUE, "year"),
    regexp = "`year` must be an integer"
  )
  expect_error(
    validate_year(list(2022), "year"),
    regexp = "`year` must be an integer"
  )
  expect_error(
    validate_year(NA, "year"),
    regexp = "`year` must be an integer"
  )
})

test_that("validate_year uses the correct argument name in error messages", {
  expect_error(
    validate_year("2022", "custom_year_arg"),
    regexp = "`custom_year_arg` must be an integer"
  )
})

validate_version <- function(version) {
  if (!is.null(version)) {
    if (!is.character(version)) {
      cli::cli_abort(
        c(
          "!" = "{.arg version} must be a character."
        )
      )
    }
    version_length <- nchar(version)
    if (version_length != 17) {
      cli::cli_abort(
        c(
          "!" = "{.arg version} must have length 17.",
          "x" = "You've supplied {version_length}."
        )
      )
    }
  }
}

test_that("validate_version() allows NULL", {
  expect_silent(validate_version(NULL))
})

test_that("validate_version() allows valid 17-character string", {
  expect_silent(validate_version("12345678901234567"))
})

test_that("validate_version() rejects non-character input", {
  expect_error(
    validate_version(12345),
    "must be a character"
  )
})

test_that("validate_version() rejects wrong-length string", {
  expect_error(
    validate_version("short"),
    "must have length 17"
  )
})

test_that("validate_version() reports actual length when wrong", {
  expect_error(
    validate_version("short"),
    "You've supplied 5"
  )
})
