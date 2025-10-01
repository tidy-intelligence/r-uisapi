#' Get indicator definitions from UIS API
#'
#' @description
#' Retrieves information about indicators available in the UNESCO Institute for
#' Statistics (UIS) API.
#'
#' @param version Character. The API version to use. If NULL (default), the
#'  API's default version will be used. See \link{uis_get_versions} for a list
#'  of supported versions.
#' @param disaggregations Logical. If TRUE, includes disaggregation information
#'  for indicators. Default is FALSE.
#' @param glossary_terms Logical. If TRUE, includes glossary terms associated
#'  with indicators. Default is FALSE.
#'
#' @return A data frame with information about indicators:
#'   \item{indicator_id}{Character. The unique identifier for the indicator.}
#'   \item{indicator_name}{Character. The name of the indicator.}
#'   \item{theme}{Character. The theme of the indicator.}
#'   \item{last_data_update}{Date. The last update date.}
#'   \item{last_data_update_description}{Character. A description about the
#'  last update date.}
#'   \item{data_availability}{List column. Contains nested information about
#'  data availability, including total record count and timeline min/max years.}
#'   \item{entity_types}{List column. Contains information about entity types
#'  associated with the indicator.}
#'
#' @examples
#' \donttest{
#' # Download indicators
#' uis_get_indicators()
#'
#' # Download indicators with glossary terms and disaggregations
#' uis_get_indicators(disaggregations = TRUE, glossary_terms = TRUE)
#' }
#'
#' @export
uis_get_indicators <- function(
  version = NULL,
  disaggregations = FALSE,
  glossary_terms = FALSE
) {
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

  if (glossary_terms) {
    glossary_terms_raw <- indicators_raw |>
      select("indicatorCode", "glossaryTerms") |>
      tidyr::unnest("glossaryTerms") |>
      select(-"themes") |>
      dplyr::distinct()

    glossary_terms_processed <- glossary_terms_raw |>
      convert_to_snake_case() |>
      dplyr::rename(
        "indicator_id" = "indicator_code",
        "term_name" = "name"
      ) |>
      tidyr::nest(
        glossary_terms = -"indicator_id"
      )

    indicators_raw <- indicators_raw |>
      select(-"glossaryTerms")
  }

  if (disaggregations) {
    disaggregations_raw <- indicators_raw |>
      select("indicatorCode", "disaggregations") |>
      tidyr::unnest("disaggregations") |>
      dplyr::rename(
        "disaggregation_id" = "code",
        "disaggregation_name" = "name"
      ) |>
      select(-"glossaryTerms") |>
      tidyr::unnest("disaggregationType") |>
      dplyr::rename(
        "disaggregation_type_id" = "code",
        "disaggregation_type_name" = "name"
      ) |>
      select(-"glossaryTerms")

    disaggregations_processed <- disaggregations_raw |>
      convert_to_snake_case() |>
      dplyr::rename(
        "indicator_id" = "indicator_code"
      ) |>
      tidyr::nest(
        disaggregations = -"indicator_id"
      )

    indicators_raw <- indicators_raw |>
      select(-"disaggregations")
  }

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
    ) |>
    dplyr::mutate(
      last_data_update = as.Date(
        .data$last_data_update,
        tryFormats = c("%Y-%m-%d", "%m/%d/%Y")
      )
    )

  if (disaggregations || glossary_terms) {
    if (disaggregations) {
      indicators <- indicators |>
        dplyr::left_join(disaggregations_processed, by = "indicator_id")
    }
    if (glossary_terms) {
      indicators <- indicators |>
        dplyr::left_join(glossary_terms_processed, by = "indicator_id")
    }
  }
  indicators
}
