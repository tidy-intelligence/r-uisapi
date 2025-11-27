# Get data from the UIS API

Retrieves data from the UNESCO Institute for Statistics (UIS) API for
specified entities, indicators, and time periods.

## Usage

``` r
uis_get(
  entities = NULL,
  indicators = NULL,
  start_year = NULL,
  end_year = NULL,
  version = NULL
)
```

## Arguments

- entities:

  Character vector. The entity IDs (ISO 3166-1 alpha-3 codes) to
  retrieve data for. Must provide either this parameter or `indicators`
  or both. See
  [uis_get_entities](https://tidy-intelligence.github.io/r-uisapi/reference/uis_get_entities.md)
  for a list of supported entities.

- indicators:

  Character vector. The indicator IDs to retrieve data for. Must provide
  either this parameter or `entities` or both. See
  [uis_get_indicators](https://tidy-intelligence.github.io/r-uisapi/reference/uis_get_indicators.md)
  for a list of supported indicators.

- start_year:

  Numeric or character. The starting year for the data retrieval period.
  If NULL, no start year constraint is applied.

- end_year:

  Numeric or character. The ending year for the data retrieval period.
  If NULL, no end year constraint is applied.

- version:

  Character. The API version to use. If NULL, the default version is
  used. See
  [uis_get_versions](https://tidy-intelligence.github.io/r-uisapi/reference/uis_get_versions.md)
  for a list of supported versions.

## Value

A data frame with the following columns:

- entity_id:

  Character. The ID of the entity (geoUnit).

- indicator_id:

  Character. The ID of the indicator.

- year:

  Numeric. The year of the observation.

- value:

  Numeric. The value of the indicator for the given entity and year.

## Examples

``` r
# \donttest{
# Get all data for a single indicator
uis_get(
  indicators = "CR.1"
)
#> # A tibble: 2,163 × 4
#>    entity_id indicator_id  year value
#>    <chr>     <chr>        <int> <dbl>
#>  1 AFG       CR.1          2011  40.7
#>  2 AFG       CR.1          2015  54.5
#>  3 AFG       CR.1          2022  44.2
#>  4 AGO       CR.1          2015  60.0
#>  5 ALB       CR.1          2000  95.2
#>  6 ALB       CR.1          2005  98.9
#>  7 ALB       CR.1          2009  98.2
#>  8 ALB       CR.1          2017  97.4
#>  9 ARG       CR.1          2000  95.5
#> 10 ARG       CR.1          2001  95.6
#> # ℹ 2,153 more rows

# Get all data for a single country
uis_get(
  entities = "BRA"
)
#> # A tibble: 48,310 × 4
#>    entity_id indicator_id  year value
#>    <chr>     <chr>        <int> <dbl>
#>  1 BRA       10            1999     0
#>  2 BRA       10            2000     0
#>  3 BRA       10            2001     0
#>  4 BRA       10            2002     0
#>  5 BRA       10            2003     0
#>  6 BRA       10            2004     0
#>  7 BRA       10            2005     0
#>  8 BRA       10            2006     0
#>  9 BRA       10            2007     0
#> 10 BRA       10            2008     0
#> # ℹ 48,300 more rows

# Get data for multiple indicators and countries
uis_get(
  entities = c("BRA", "USA"),
  indicators = c("CR.1", "CR.2")
)
#> # A tibble: 66 × 4
#>    entity_id indicator_id  year value
#>    <chr>     <chr>        <int> <dbl>
#>  1 BRA       CR.1          2001  82  
#>  2 BRA       CR.1          2002  84.1
#>  3 BRA       CR.1          2003  86.6
#>  4 BRA       CR.1          2004  87.4
#>  5 BRA       CR.1          2005  87.9
#>  6 BRA       CR.1          2006  89.3
#>  7 BRA       CR.1          2007  88.4
#>  8 BRA       CR.1          2008  88.4
#>  9 BRA       CR.1          2009  88.6
#> 10 BRA       CR.1          2011  89.9
#> # ℹ 56 more rows

# Get data for multiple indicators and countries and specific time range
uis_get(
  entities = c("BRA", "USA"),
  indicators = c("CR.1", "CR.2"),
  start_year = 2010,
  end_year = 2020
)
#> # A tibble: 36 × 4
#>    entity_id indicator_id  year value
#>    <chr>     <chr>        <int> <dbl>
#>  1 BRA       CR.1          2011  89.9
#>  2 BRA       CR.1          2012  91.6
#>  3 BRA       CR.1          2013  91.5
#>  4 BRA       CR.1          2014  92.9
#>  5 BRA       CR.1          2015  93.2
#>  6 BRA       CR.1          2016  93.8
#>  7 BRA       CR.1          2017  94.6
#>  8 BRA       CR.1          2018  95.1
#>  9 BRA       CR.1          2019  95.7
#> 10 BRA       CR.1          2020  96.3
#> # ℹ 26 more rows
# }
```
