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
    req_url_path_append(resource)

  if (!is.null(entities)) {
    req <- req |>
      req_url_query(geoUnit = entities, .multi = "explode")
  }

  if (!is.null(indicators)) {
    req <- req |>
      req_url_query(indicator = indicators, .multi = "explode")
  }

  if (!is.null(start_year)) {
    req <- req |>
      req_url_query(start = start_year)
  }

  if (!is.null(end_year)) {
    req <- req |>
      req_url_query(end = end_year)
  }

  if (!is.null(version)) {
    req <- req |>
      req_url_query(version = version)
  }

  if (!is.null(disaggregations)) {
    disaggregations <- ifelse(disaggregations, "true", "false")
    req <- req |>
      req_url_query(disaggregations = disaggregations)
  }

  if (!is.null(glossary_terms)) {
    glossary_terms <- ifelse(glossary_terms, "true", "false")
    req <- req |>
      req_url_query(glossaryTerms = glossary_terms)
  }

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
