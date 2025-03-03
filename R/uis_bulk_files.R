#' Get files available for download via UIS BDDS
#'
#' @description
#' Retrieves information about files available in the UNESCO Institute for
#' Statistics (UIS) Bulk Data Download Service (BDDS).
#'
#' @return A data frame with information about files:
#'   \item{file_name}{Character. The name of the data set.}
#'   \item{file_url}{Character. The URL of the data set.}
#'   \item{last_updated}{Character. Information about last update.}
#'
#' @examples
#' \donttest{
#' # Download available files for bulk download
#' uis_bulk_files()
#' }
#'
#' @export
uis_bulk_files <- function() {
  base_url <- "https://databrowser.uis.unesco.org/resources/bulk"

  tryCatch(
    {
      resp <- request(base_url) |>
        req_user_agent(
          "uisapi R package (https://github.com/tidy-intelligence/r-uisapi)"
        ) |>
        req_perform()
    },
    error = function(e) {
      cli::cli_abort(
        c(
          "Failed to retrieve data from UNESCO Institute for Statistics Bulk.",
          "x" = "Error message: {conditionMessage(e)}",
          "i" = "Check your internet connection."
        )
      )
    }
  )

  resp <- resp |>
    resp_body_string()

  pattern <- '<script id="__NEXT_DATA__" type="application/json">(.*?)</script>'
  matches <- regmatches(resp, gregexpr(pattern, resp, perl = TRUE))[[1]]

  json_str <- sub(
    '^<script id="__NEXT_DATA__" type="application/json">',
    '',
    matches
  )

  json_str <- sub('</script>$', '', json_str)

  json_data <- jsonlite::fromJSON(json_str, flatten = TRUE)

  resources <- json_data$props$pageProps$dato$bulkDownload$resources

  files <- tibble(
    file_name = resources$title,
    file_url = resources$url,
    last_updated = resources$lastUpdated
  ) |>
    dplyr::filter(grepl(".zip", .data$file_url))

  files$last_updated <- sub(
    "^.*last update: ([A-Za-z]+ \\d{4}).*$",
    "\\1",
    files$last_updated
  )

  files$last_updated[files$last_updated == ""] <- NA

  files
}
