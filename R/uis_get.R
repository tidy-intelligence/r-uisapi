uis_get <- function(
  entities = NULL,
  indicators = NULL,
  start_year = NULL,
  end_year = NULL,
  version = NULL
) {
  # TODO: at least entities or indicators must be given

  # TODO: add parameter validation

  # TODO: add support for parameters
  resp <- perform_request("data/indicators")

  data_raw <- resp |>
    resp_body_json(simplifyVector = TRUE)

  data <- data_raw$records |>
    as_tibble() |>
    dplyr::select(
      entity_id = geoUnit,
      indicator_id = indicatorId,
      year,
      value
    )

  data
}
