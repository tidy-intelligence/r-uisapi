#' @keywords internal
#' @noRd
convert_to_snake_case <- function(df) {
  new_names <- gsub("([a-z])([A-Z])", "\\1_\\2", names(df))
  new_names <- tolower(new_names)
  colnames(df) <- new_names
  df
}

#' @noRd
#' @keywords internal
validate_logical <- function(arg, arg_name) {
  if (!is.logical(arg) || is.na(arg)) {
    cli::cli_abort(
      c(
        "!" = paste("{.arg {arg_name}} must be a logical.")
      )
    )
  }
}

#' @noRd
#' @keywords internal
validate_character_vector <- function(arg, arg_name) {
  if (!is.null(arg)) {
    if (!is.character(arg) || any(is.na(arg))) {
      cli::cli_abort(
        c(
          "!" = paste(
            "{.arg {arg_name}} must be a character vector and cannot contain ",
            "NA values."
          )
        )
      )
    }
  }
}

#' @noRd
#' @keywords internal
validate_year <- function(year, arg_name) {
  if (!is.null(year)) {
    if (!is.numeric(year)) {
      cli::cli_abort(
        c(
          "!" = paste("{.arg {arg_name}} must be an integer.")
        )
      )
    }
  }
}

#' @keywords internal
#' @noRd
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
