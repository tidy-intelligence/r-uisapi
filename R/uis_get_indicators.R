uis_get_indicators <- function(
  version = NULL,
  disaggregations = NULL,
  glossary_terms = NULL
) {
  validate_version(version)

  # TODO: add support for parameters
  resp <- perform_request(
    "definitions/indicators",
    version = version
  )

  indicators_raw <- resp_body_json(resp, simplifyVector = TRUE) |>
    as_tibble()

  # TODO: rename columns and nest them again afterwards with new names
  indicators <- indicators_raw |>
    tidyr::unnest("dataAvailability") |>
    tidyr::unnest("timeLine") |>
    tidyr::unnest("geoUnits") |>
    tidyr::unnest("types")

  indicators <- convert_to_snake_case(indicators)

  indicators
}
