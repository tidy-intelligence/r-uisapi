# Get indicator definitions from UIS API

Retrieves information about indicators available in the UNESCO Institute
for Statistics (UIS) API.

## Usage

``` r
uis_get_indicators(
  version = NULL,
  disaggregations = FALSE,
  glossary_terms = FALSE
)
```

## Arguments

- version:

  Character. The API version to use. If NULL (default), the API's
  default version will be used. See
  [uis_get_versions](https://tidy-intelligence.github.io/r-uisapi/reference/uis_get_versions.md)
  for a list of supported versions.

- disaggregations:

  Logical. If TRUE, includes disaggregation information for indicators.
  Default is FALSE.

- glossary_terms:

  Logical. If TRUE, includes glossary terms associated with indicators.
  Default is FALSE.

## Value

A data frame with information about indicators:

- indicator_id:

  Character. The unique identifier for the indicator.

- indicator_name:

  Character. The name of the indicator.

- theme:

  Character. The theme of the indicator.

- last_data_update:

  Date. The last update date.

- last_data_update_description:

  Character. A description about the last update date.

- data_availability:

  List column. Contains nested information about data availability,
  including total record count and timeline min/max years.

- entity_types:

  List column. Contains information about entity types associated with
  the indicator.

## Examples

``` r
# \donttest{
# Download indicators
uis_get_indicators()
#> # A tibble: 4,636 × 7
#>    indicator_id indicator_name     theme last_data_update last_data_update_des…¹
#>    <chr>        <chr>              <chr> <date>           <chr>                 
#>  1 10           Official entrance… EDUC… 2025-09-17       September 2025 Data R…
#>  2 10403        Start month of th… EDUC… 2025-09-17       September 2025 Data R…
#>  3 10404        End month of the … EDUC… 2025-09-17       September 2025 Data R…
#>  4 10405        Start of the acad… EDUC… 2025-09-17       September 2025 Data R…
#>  5 10406        End of the academ… EDUC… 2025-09-17       September 2025 Data R…
#>  6 13           Theoretical durat… EDUC… 2025-09-17       September 2025 Data R…
#>  7 200101       Total population … DEMO… 2025-09-09       September 2025 Data R…
#>  8 200144       Population aged 1… DEMO… 2025-09-09       September 2025 Data R…
#>  9 200151       Population aged 6… DEMO… 2025-09-09       September 2025 Data R…
#> 10 200343       Population aged 1… DEMO… 2025-09-09       September 2025 Data R…
#> # ℹ 4,626 more rows
#> # ℹ abbreviated name: ¹​last_data_update_description
#> # ℹ 2 more variables: data_availability <list>, entity_types <list>

# Download indicators with glossary terms and disaggregations
uis_get_indicators(disaggregations = TRUE, glossary_terms = TRUE)
#> # A tibble: 4,636 × 9
#>    indicator_id indicator_name     theme last_data_update last_data_update_des…¹
#>    <chr>        <chr>              <chr> <date>           <chr>                 
#>  1 10           Official entrance… EDUC… 2025-09-17       September 2025 Data R…
#>  2 10403        Start month of th… EDUC… 2025-09-17       September 2025 Data R…
#>  3 10404        End month of the … EDUC… 2025-09-17       September 2025 Data R…
#>  4 10405        Start of the acad… EDUC… 2025-09-17       September 2025 Data R…
#>  5 10406        End of the academ… EDUC… 2025-09-17       September 2025 Data R…
#>  6 13           Theoretical durat… EDUC… 2025-09-17       September 2025 Data R…
#>  7 200101       Total population … DEMO… 2025-09-09       September 2025 Data R…
#>  8 200144       Population aged 1… DEMO… 2025-09-09       September 2025 Data R…
#>  9 200151       Population aged 6… DEMO… 2025-09-09       September 2025 Data R…
#> 10 200343       Population aged 1… DEMO… 2025-09-09       September 2025 Data R…
#> # ℹ 4,626 more rows
#> # ℹ abbreviated name: ¹​last_data_update_description
#> # ℹ 4 more variables: data_availability <list>, entity_types <list>,
#> #   disaggregations <list>, glossary_terms <list>
# }
```
