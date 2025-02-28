
<!-- README.md is generated from README.Rmd. Please edit that file -->

# uisapi

<!-- badges: start -->

![R CMD
Check](https://github.com/tidy-intelligence/r-uisapi/actions/workflows/R-CMD-check.yaml/badge.svg)
![Lint](https://github.com/tidy-intelligence/r-uisapi/actions/workflows/lint.yaml/badge.svg)
[![Codecov test
coverage](https://codecov.io/gh/tidy-intelligence/r-uisapi/graph/badge.svg)](https://app.codecov.io/gh/tidy-intelligence/r-uisapi)
[![R-CMD-check](https://github.com/tidy-intelligence/r-uisapi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tidy-intelligence/r-uisapi/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Retrieve data from the [UNESCO Institute for Statistics (UIS)
API](https://api.uis.unesco.org/api/public/documentation/).

The package is part of the
[econdataverse](https://www.econdataverse.org/) family of packages aimed
at helping economists and financial professionals work with
sovereign-level economic data.

Roadmap

- [ ] Add support for API functions and their parameters
- [ ] Add support for [Bulk Data Download Service
  (BDDS)](https://databrowser.uis.unesco.org/resources/bulk)

## Installation

You can install the development version of `uisapi` from GitHub with:

    # install.packages("pak")
    pak::pak("tidy-intelligence/r-uisapi")

## Usage

Load the package:

``` r
library(uisapi)
```

To fetch indicators for specific entities, you can call:

``` r
uis_get(
  entities = c("BRA", "USA"),
  indicators = c("CR.1", "CR.2"),
  start_year = 2010,
  end_year = 2020
)
#> [1] 6
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
```

You can get information about the available entities via:

``` r
uis_get_entities()
#> # A tibble: 467 × 4
#>    entity_id entity_name          entity_type region_group
#>    <chr>     <chr>                <chr>       <chr>       
#>  1 ABW       Aruba                NATIONAL    <NA>        
#>  2 AFG       Afghanistan          NATIONAL    <NA>        
#>  3 AGO       Angola               NATIONAL    <NA>        
#>  4 AIA       Anguilla             NATIONAL    <NA>        
#>  5 ALA       Åland Islands        NATIONAL    <NA>        
#>  6 ALB       Albania              NATIONAL    <NA>        
#>  7 AND       Andorra              NATIONAL    <NA>        
#>  8 ANT       Netherlands Antilles NATIONAL    <NA>        
#>  9 ARE       United Arab Emirates NATIONAL    <NA>        
#> 10 ARG       Argentina            NATIONAL    <NA>        
#> # ℹ 457 more rows
```

The list of available indicators can be retrieved via:

``` r
uis_get_indicators()
#> # A tibble: 4,247 × 7
#>    indicator_id indicator_name     theme last_data_update last_data_update_des…¹
#>    <chr>        <chr>              <chr> <chr>            <chr>                 
#>  1 10           Official entrance… EDUC… 2025-02-23       February 2025 Data Re…
#>  2 10403        Start month of th… EDUC… 2025-02-23       February 2025 Data Re…
#>  3 10404        End month of the … EDUC… 2025-02-23       February 2025 Data Re…
#>  4 10405        Start of the acad… EDUC… 2025-02-23       February 2025 Data Re…
#>  5 10406        End of the academ… EDUC… 2025-02-23       February 2025 Data Re…
#>  6 13           Theoretical durat… EDUC… 2025-02-23       February 2025 Data Re…
#>  7 200101       Total population … DEMO… 2025-02-23       February 2025 Data Re…
#>  8 200144       Population aged 1… DEMO… 2025-02-23       February 2025 Data Re…
#>  9 200151       Population aged 6… DEMO… 2025-02-23       February 2025 Data Re…
#> 10 200343       Population aged 1… DEMO… 2025-02-23       February 2025 Data Re…
#> # ℹ 4,237 more rows
#> # ℹ abbreviated name: ¹​last_data_update_description
#> # ℹ 2 more variables: data_availability <list>, entity_types <list>
```

The API supports versioning and you can retrieve all versions using:

``` r
uis_get_versions()
#> # A tibble: 6 × 4
#>   version           publication_date         description                theme   
#>   <chr>             <chr>                    <chr>                      <list>  
#> 1 20250225-2ae60fad 2025-02-27T15:29:19.309Z February 2025 DR           <tibble>
#> 2 20241121-61101499 2024-11-21T23:37:39.608Z SCCI Data refresh – Nov 2… <tibble>
#> 3 20241113-98786d81 2024-11-21T18:57:35.136Z SCCI data refresh          <tibble>
#> 4 20241030-9d4d089e 2024-10-30T17:28:00.868Z Drop data for CIV on MYS … <tibble>
#> 5 20240913-b8ca1963 2024-09-15T14:44:07.750Z Glossary Update            <tibble>
#> 6 20240910-b5ad4d82 2024-09-11T06:15:13.018Z September 2024 Data Relea… <tibble>
```

If you are only interested in the current default version, you can use
the parameter `default`:

``` r
uis_get_versions(default = TRUE)
#> # A tibble: 1 × 4
#>   version           publication_date         description      theme           
#>   <chr>             <chr>                    <chr>            <list>          
#> 1 20250225-2ae60fad 2025-02-27T15:29:19.309Z February 2025 DR <tibble [4 × 3]>
```
