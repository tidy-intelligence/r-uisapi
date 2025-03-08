% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/uis_bulk_files.R
\name{uis_bulk_files}
\alias{uis_bulk_files}
\title{Get files available for download via UIS BDDS}
\usage{
uis_bulk_files()
}
\value{
A data frame with information about files:
\item{file_name}{Character. The name of the data set.}
\item{file_url}{Character. The URL of the data set.}
\item{last_updated_description}{Character. Information about last update.}
}
\description{
Retrieves information about files available in the UNESCO Institute for
Statistics (UIS) Bulk Data Download Service (BDDS).
}
\examples{
\donttest{
# Download available files for bulk download
uis_bulk_files()
}

}
