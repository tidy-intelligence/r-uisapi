% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/uis_get_versions.R
\name{uis_get_versions}
\alias{uis_get_versions}
\title{Get available UIS API versions}
\usage{
uis_get_versions(default = FALSE)
}
\arguments{
\item{default}{Logical. Indicates whether only the current default version
should be retrievend. Defaults to FALSE.}
}
\value{
A data frame with the following columns:
\item{id}{Character. The version identifier.}
\item{code}{Character. The version code.}
\item{description}{Character. The description of the version.}
\item{release_date}{Character. The date when the version was released.}
\item{theme}{List column. Each element is a nested data frame containing
information about themes available in the version, with columns: theme_id,
theme_last_update, theme_description}
}
\description{
Retrieves information about the available versions of the UNESCO Institute
for Statistics (UIS) API, including version IDs, descriptions, and theme
data.
}
\examples{
\dontshow{if (curl::has_internet()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
\donttest{
uis_get_versions()
}
\dontshow{\}) # examplesIf}
}
