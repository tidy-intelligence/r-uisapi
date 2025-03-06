#' Get geographical entities from UIS API
#'
#' @description
#' Retrieves information about geographical entities (countries, regions, etc.)
#' available in the UNESCO Institute for Statistics (UIS) API.
#'
#' @param version Character. The API version to use. If NULL (default), the
#'  API's default version will be used. See \link{uis_get_versions} for a list
#'  of supported versions.
#'
#' @return A data frame with information about geographical entities:
#'   \item{entity_id}{Character. The unique identifier for the entity.}
#'   \item{entity_name}{Character. The name of the geographical entity.}
#'   \item{entity_type}{Character. The type of entity (e.g., country, region).}
#'   \item{region_group}{Character. Information about the region
#' grouping.}
#'
#' @examples
#' \donttest{
#' # Download entities for default version
#' uis_get_entities()
#'
#' # Download entities for a specific version
#' uis_get_entities("20240910-b5ad4d82")
#' }
#'
#' @export
uis_get_entities <- function(
  version = NULL
) {
  validate_version(version)

  resp <- perform_request(
    "definitions/geounits",
    version = version
  )

  entities_raw <- resp_body_json(resp) |>
    dplyr::bind_rows()

  entities <- entities_raw |>
    dplyr::rename(
      "entity_id" = "id",
      "entity_name" = "name",
      "entity_type" = "type",
      "region_group" = "regionGroup"
    )

  entities <- convert_to_snake_case(entities)

  entities
}
