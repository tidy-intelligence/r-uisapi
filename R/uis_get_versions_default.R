uis_get_versions_default <- function() {
  resp <- perform_request("versions/default")

  versions_default_raw <- resp_body_json(resp, simplifyVector = TRUE) |>
    as_tibble()

  versions_default <- versions_default_raw |>
    dplyr::rename(versionDescription = description) |>
    tidyr::unnest(themeDataStatus) |>
    dplyr::rename(
      themeId = theme,
      themeLastUpdate = lastUpdate,
      themeDescription = description
    ) |>
    dplyr::rename(description = versionDescription)

  versions_default <- convert_to_snake_case(versions_default) |>
    tidyr::nest(theme = c(theme_id, theme_last_update, theme_description))

  versions_default
}
