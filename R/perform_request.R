#' @keywords internal
#' @noRd
perform_request <- function(
  resource,
  entities = NULL,
  indicators = NULL,
  start_year = NULL,
  end_year = NULL,
  version = NULL,
  disaggregations = NULL,
  glossary_terms = NULL
) {
  base_url <- c(
    "https://api.uis.unesco.org/api/public"
  )

  req <- request(base_url) |>
    req_url_path_append(resource) |>
    req_url_query(
      geoUnit = entities,
      indicator = indicators,
      start = start_year,
      end = end_year,
      version = version,
      disaggregations = disaggregations,
      glossary_terms = glossary_terms,
      .multi = "explode"
    )

  tryCatch(
    {
      resp <- req |>
        req_user_agent(
          "uisapi R package (https://github.com/tidy-intelligence/r-uisapi)"
        ) |>
        req_perform()
    },
    error = function(e) {
      cli::cli_abort(
        c(
          "Failed to retrieve data from UNESCO Institute for Statistics API.",
          "x" = "Error message: {conditionMessage(e)}",
          "i" = "Check your internet connection and function parameters."
        )
      )
    }
  )

  resp
}
