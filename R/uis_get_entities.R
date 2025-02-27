uis_get_entities <- function(
  version = NULL
) {
  # TODO: add parameter validation

  # TODO: add support for parameters
  resp <- perform_request("definitions/geounits")

  entities_raw <- resp_body_json(resp) |>
    dplyr::bind_rows()

  entities <- entities_raw |>
    dplyr::rename(
      entity_id = id,
      entity_name = name,
      entity_typ = type,
      region_group = regionGroup
    )

  entities <- convert_to_snake_case(entities)

  entities
}
