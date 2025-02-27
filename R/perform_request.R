#' @keywords internal
#' @noRd
perform_request <- function(
  resource,
  version = NULL,
  disaggregations = NULL,
  glossary_terms = NULL
) {
  base_url <- c(
    "https://api.uis.unesco.org/api/public"
  )

  req <- request(base_url) |>
    req_url_path_append(resource)

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
          "i" = "Check your internet connection and parameters."
        ),
        call = call("uis_get_entities")
      )
    }
  )
}
