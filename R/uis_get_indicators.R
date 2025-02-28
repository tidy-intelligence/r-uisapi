#' Get indicator definitions from UIS API
#'
#' @description
#' Retrieves information about indicators available in the UNESCO Institute for
#' Statistics (UIS) API, including their definitions, data availability, and
#' associated metadata.
#'
#' @param version Character. The API version to use. If NULL (default), the
#'  API's default version will be used.
#' @param disaggregations Logical. If TRUE, includes disaggregation information
#'  for indicators. Default is FALSE.
#' @param glossary_terms Logical. If TRUE, includes glossary terms associated
#'  with indicators. Default is FALSE.
#'
#' @return A data frame with information about indicators:
#'   \item{indicator_id}{Character. The unique identifier for the indicator.}
#'   \item{indicator_name}{Character. The name of the indicator.}
#'   \item{data_availability}{List column. Contains nested information about
#'  data availability, including total record count and timeline min/max years.}
#'   \item{entity_types}{List column. Contains information about entity types
#'  associated with the indicator.}
#'
#' @examples
#' \donttest{
#' uis_get_indicators()
#' }
#'
#' @seealso
#' \code{uis_get_versions} for retrieving available API versions.
#'
#' @export
uis_get_indicators <- function(
  version = NULL,
  disaggregations = FALSE,
  glossary_terms = FALSE
) {
  # TODO: add support for glossary_terms and disagreggations
  validate_version(version)
  validate_logical(disaggregations)
  validate_logical(glossary_terms)

  resp <- perform_request(
    "definitions/indicators",
    version = version,
    glossary_terms = glossary_terms,
    disaggregations = disaggregations
  )

  indicators_raw <- resp_body_json(resp, simplifyVector = TRUE) |>
    as_tibble()

  indicators <- indicators_raw |>
    tidyr::unnest("dataAvailability") |>
    tidyr::unnest("timeLine") |>
    tidyr::unnest("geoUnits") |>
    tidyr::unnest("types")

  indicators <- convert_to_snake_case(indicators)

  indicators <- indicators |>
    dplyr::rename(
      "indicator_id" = "indicator_code",
      "indicator_name" = "name",
      "timeline_min" = "min",
      "timeline_max" = "max",
      "entity_types" = "types"
    ) |>
    tidyr::nest(
      "data_availability" = c(
        "total_record_count",
        "timeline_min",
        "timeline_max"
      )
    ) |>
    tidyr::nest(
      "entity_types" = "entity_types"
    )

  indicators
}
