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
#'   \item{version}{Character. The version identifier.}
#'   \item{publication_date}{Date-time. The date when the version was released.}
#'   \item{description}{Character. The description of the version.}
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
    ) |>
    dplyr::mutate(
      publication_date = as.POSIXct(
        .data$publication_date,
        format = "%Y-%m-%dT%H:%M:%OS",
        tz = "UTC"
      )
    )

  versions
}
