uis_get_versions <- function() {
  resp <- perform_request("versions")

  versions_raw <- resp_body_json(resp, simplifyVector = TRUE) |>
    as_tibble()

  versions <- versions_raw |>
    dplyr::rename(versionDescription = description) |>
    tidyr::unnest(themeDataStatus) |>
    dplyr::rename(
      themeId = theme,
      themeLastUpdate = lastUpdate,
      themeDescription = description
    ) |>
    dplyr::rename(description = versionDescription)

  versions <- convert_to_snake_case(versions) |>
    tidyr::nest(theme = c(theme_id, theme_last_update, theme_description))

  versions
}
