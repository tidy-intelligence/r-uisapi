#' @keywords internal
#' @noRd
convert_to_snake_case <- function(df) {
  new_names <- gsub("([a-z])([A-Z])", "\\1_\\2", names(df))
  new_names <- tolower(new_names)
  colnames(df) <- new_names
  df
}
