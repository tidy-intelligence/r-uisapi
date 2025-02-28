#' Get available UIS API versions
#'
#' @description
#' Retrieves information about the available versions of the UNESCO Institute
#' for Statistics (UIS) API, including version IDs, descriptions, and theme
#' data.
#'
#' @param default Logical. Indicates whether only the current default version
#'  should be retrievend. Defaults to FALSE.
#'
#' @return A data frame with the following columns:
#'   \item{id}{Character. The version identifier.}
#'   \item{code}{Character. The version code.}
#'   \item{description}{Character. The description of the version.}
#'   \item{release_date}{Character. The date when the version was released.}
#'   \item{theme}{List column. Each element is a nested data frame containing
#' information about themes available in the version, with columns: theme_id,
#' theme_last_update, theme_description}
#'
#' @examplesIf curl::has_internet()
#' \donttest{
#' uis_get_versions()
#' }
#'
#' @export
uis_get_versions <- function(default = FALSE) {
  if (default) {
    resp <- perform_request("versions/default")
  } else {
    resp <- perform_request("versions")
  }

  versions_raw <- resp_body_json(resp, simplifyVector = TRUE) |>
    as_tibble()

  versions <- versions_raw |>
    dplyr::rename("versionDescription" = "description") |>
    tidyr::unnest("themeDataStatus") |>
    dplyr::rename(
      "themeId" = "theme",
      "themeLastUpdate" = "lastUpdate",
      "themeDescription" = "description"
    ) |>
    dplyr::rename(
      "description" = "versionDescription"
    )

  versions <- convert_to_snake_case(versions) |>
    tidyr::nest(
      theme = c("theme_id", "theme_last_update", "theme_description")
    )

  versions
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
