#' Get data from the UIS API
#'
#' @description
#' Retrieves data from the UNESCO Institute for Statistics (UIS) API for
#' specified entities, indicators, and time periods.
#'
#' @param entities Character vector. The entity IDs (geoUnits) to retrieve data
#'  for. Must provide either this parameter or `indicators` or both.
#' @param indicators Character vector. The indicator IDs to retrieve data for.
#'   Must provide either this parameter or `entities` or both.
#' @param start_year Numeric or character. The starting year for the data
#'  retrieval period. If NULL, no start year constraint is applied.
#' @param end_year Numeric or character. The ending year for the data retrieval
#'  period. If NULL, no end year constraint is applied.
#' @param version Character. The API version to use. If NULL, the default
#'  version is used.
#'
#' @return A data frame with the following columns:
#'   \item{entity_id}{Character. The ID of the entity (geoUnit).}
#'   \item{indicator_id}{Character. The ID of the indicator.}
#'   \item{year}{Numeric. The year of the observation.}
#'   \item{value}{Numeric. The value of the indicator for the given entity and
#'  year.}
#'
#' @examplesIf curl::has_internet()
#' \donttest{
#' # Get all data for a single indicator
#' uis_get(
#'   indicators = "CR.1"
#' )
#'
#' # Get all data for a single country
#' uis_get(
#'   entities = "BRA"
#' )
#'
#' # Get data for multiple indicators and countries
#' uis_get(
#'   entities = c("BRA", "USA"),
#'   indicators = c("CR.1", "CR.2")
#' )
#'
#' # Get data for multiple indicators and countries and specific time range
#' uis_get(
#'   entities = c("BRA", "USA"),
#'   indicators = c("CR.1", "CR.2"),
#'   start_year = 2010,
#'   end_year = 2020
#' )
#' }
#'
#' @seealso
#' \link{uis_get_entities} for retrieving available geographical entities and
#' \link{uis_get_versions} for retrieving available API versions
#'
#' @export
uis_get <- function(
  entities = NULL,
  indicators = NULL,
  start_year = NULL,
  end_year = NULL,
  version = NULL
) {
  if (is.null(entities) && is.null(indicators)) {
    cli::cli_abort(
      c(
        "!" = "At least {.arg entities} or {.arg indicators} must be provided."
      )
    )
  }

  validate_character_vector(indicators, "indicators")
  validate_character_vector(entities, "entities")
  validate_year(start_year, "end_year")
  validate_year(end_year, "end_year")
  validate_version(version)

  resp <- perform_request(
    "data/indicators",
    entities = entities,
    indicators = indicators,
    start_year = start_year,
    end_year = end_year,
    version = version
  )

  data_raw <- resp |>
    resp_body_json(simplifyVector = TRUE)

  records <- data_raw$records

  print(length(records))
  if (length(records) == 0) {
    cli::cli_inform(
      c("i" = "No records found for this query.")
    )
    return(invisible(NULL))
  } else {
    data <- records |>
      as_tibble() |>
      dplyr::select(
        "entity_id" = "geoUnit",
        "indicator_id" = "indicatorId",
        "year",
        "value"
      )
    return(data)
  }
}
