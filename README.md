
<!-- README.md is generated from README.Rmd. Please edit that file -->

# uisapi

<!-- badges: start -->

![R CMD
Check](https://github.com/tidy-intelligence/r-uisapi/actions/workflows/R-CMD-check.yaml/badge.svg)
![Lint](https://github.com/tidy-intelligence/r-uisapi/actions/workflows/lint.yaml/badge.svg)
[![Codecov test
coverage](https://codecov.io/gh/tidy-intelligence/r-uisapi/graph/badge.svg)](https://app.codecov.io/gh/tidy-intelligence/r-uisapi)
<!-- badges: end -->

Retrieve data from the [UNESCO Institute for Statistics (UIS)
API](https://api.uis.unesco.org/api/public/documentation/).

The package is part of the
[econdataverse](https://www.econdataverse.org/) family of packages aimed
at helping economists and financial professionals work with
sovereign-level economic data.

Roadmap:

- [x] Add support for API functions and their parameters
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
#>   version           publication_date    description                     theme   
#>   <chr>             <dttm>              <chr>                           <list>  
#> 1 20250225-2ae60fad 2025-02-27 15:29:19 February 2025 DR                <tibble>
#> 2 20241121-61101499 2024-11-21 23:37:39 SCCI Data refresh – Nov 2024 -… <tibble>
#> 3 20241113-98786d81 2024-11-21 18:57:35 SCCI data refresh               <tibble>
#> 4 20241030-9d4d089e 2024-10-30 17:28:00 Drop data for CIV on MYS for 1… <tibble>
#> 5 20240913-b8ca1963 2024-09-15 14:44:07 Glossary Update                 <tibble>
#> 6 20240910-b5ad4d82 2024-09-11 06:15:13 September 2024 Data Release (f… <tibble>
```

If you are only interested in the current default version, you can use
the parameter `default`:

``` r
uis_get_versions(default = TRUE)
#> # A tibble: 1 × 4
#>   version           publication_date    description      theme           
#>   <chr>             <dttm>              <chr>            <list>          
#> 1 20250225-2ae60fad 2025-02-27 15:29:19 February 2025 DR <tibble [4 × 3]>
```

The API will only return 100,000 records for each query, if more data is
requested, the API call with fail with a 400 http status code. If you
need more data, then UIS recommends using the [Bulk Data Download
Service (BDDS)](https://databrowser.uis.unesco.org/resources/bulk). You
can get a list of available files via:

``` r
uis_bulk_files()
#> # A tibble: 11 × 3
#>    file_name                                               file_url last_updated
#>    <chr>                                                   <chr>    <chr>       
#>  1 "SDG 4 Education - Global and Thematic Indicators "     https:/… Septembre 2…
#>  2 "Other Policy Relevant Indicators (OPRI)"               https:/… September 2…
#>  3 " SDG 9.5 - Research and Development (R&D)"             https:/… October 2024
#>  4 "Research and Development (R&D) – Other Policy Relevan… https:/… October 2024
#>  5 "SDG 11.4 Protect the Worlds Cultural and Natural Heri… https:/… October 2024
#>  6 "Demographic and Socio-economic Indicators"             https:/… September 2…
#>  7 "Education Non Core Archive February 2020"              https:/… <NA>        
#>  8 "Research and Development (R&D) Archive March 2021"     https:/… <NA>        
#>  9 "Innovation Archive April 2017"                         https:/… <NA>        
#> 10 "Cultural employment Archive June 2019"                 https:/… <NA>        
#> 11 "Cultural trade Archive June 2021"                      https:/… <NA>
```

To download a specific file provide the URL:

``` r
uis_bulk("https://uis.unesco.org/sites/default/files/documents/bdds/092024/SDG.zip ")
```
