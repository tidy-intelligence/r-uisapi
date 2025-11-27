# uisapi

Retrieve data from the [UNESCO Institute for Statistics (UIS)
API](https://api.uis.unesco.org/api/public/documentation/). UIS provides
public access to more than 4,000 indicators focusing on education,
science and technology, culture, and communication.

The package is part of the
[econdataverse](https://www.econdataverse.org/) family of packages aimed
at helping economists and financial professionals work with
sovereign-level economic data.

> 💡 The UIS API has no known rate limiting, but there is a 100,000
> record limit for each request. For larger data downloads, the UIS
> recommends its [Bulk Data Download Service
> (BDDS)](https://databrowser.uis.unesco.org/resources/bulk).

## Installation

You can install `uisapi` from
[CRAN](https://cran.r-project.org/package=uisapi) via:

``` r
install.packages("uisapi")
```

You can install the development version of `uisapi` from GitHub with:

``` r
# install.packages("pak")
pak::pak("tidy-intelligence/r-uisapi")
```

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
#> # A tibble: 462 × 4
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
#> # ℹ 452 more rows
```

The list of available indicators can be retrieved via:

``` r
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
```

The API supports versioning and you can retrieve all versions using:

``` r
uis_get_versions()
#> # A tibble: 12 × 4
#>    version           publication_date    description                    theme   
#>    <chr>             <dttm>              <chr>                          <list>  
#>  1 20251112-3e719d9a 2025-11-13 17:46:49 November 2025 SCCI Refresh     <tibble>
#>  2 20250917-73f4b95c 2025-09-18 13:31:02 September 2025 Data Release    <tibble>
#>  3 20250910-c4a5b1fe 2025-09-12 02:55:22 September 2025 release         <tibble>
#>  4 20250416-f6707727 2025-04-16 14:45:45 Dropping data for Hong Kong c… <tibble>
#>  5 20250325-6f032139 2025-03-25 23:19:35 Dropping indicators with valu… <tibble>
#>  6 20250312-e714f4e9 2025-03-12 14:01:51 Dropping Moldova 2024 populat… <tibble>
#>  7 20250225-2ae60fad 2025-02-27 15:29:19 February 2025 DR               <tibble>
#>  8 20241121-61101499 2024-11-21 23:37:39 SCCI Data refresh – Nov 2024 … <tibble>
#>  9 20241113-98786d81 2024-11-21 18:57:35 SCCI data refresh              <tibble>
#> 10 20241030-9d4d089e 2024-10-30 17:28:00 Drop data for CIV on MYS for … <tibble>
#> 11 20240913-b8ca1963 2024-09-15 14:44:07 Glossary Update                <tibble>
#> 12 20240910-b5ad4d82 2024-09-11 06:15:13 September 2024 Data Release (… <tibble>
```

If you are only interested in the current default version, you can use
the parameter `default_only`:

``` r
uis_get_versions(default_only = TRUE)
#> # A tibble: 1 × 4
#>   version           publication_date    description                theme   
#>   <chr>             <dttm>              <chr>                      <list>  
#> 1 20251112-3e719d9a 2025-11-13 17:46:49 November 2025 SCCI Refresh <tibble>
```

The API will only return 100,000 records for each query, if more data is
requested, the API call with fail with a 400 http status code. If you
need more data, then UIS recommends using the [Bulk Data Download
Service (BDDS)](https://databrowser.uis.unesco.org/resources/bulk). You
can get a list of available files via:

``` r
uis_bulk_files()
#> # A tibble: 12 × 3
#>    file_name                                     file_url last_updated_descrip…¹
#>    <chr>                                         <chr>    <chr>                 
#>  1 "SDG 4 Education - Global and Thematic Indic… https:/… September 2025        
#>  2 "Other Policy Relevant Indicators (OPRI)"     https:/… September 2025        
#>  3 " SDG 9.5 - Research and Development (R&D)"   https:/… November 2025         
#>  4 "Research and Development (R&D) – Other Poli… https:/… November 2025         
#>  5 "SDG 11.4 Protect the Worlds Cultural and Na… https:/… November 2025         
#>  6 "Demographic and Socio-economic Indicators"   https:/… September 2025        
#>  7 "Education Non Core Archive February 2020"    https:/… <NA>                  
#>  8 "Research and Development (R&D) Archive Marc… https:/… <NA>                  
#>  9 "Innovation Archive April 2017"               https:/… <NA>                  
#> 10 "Cultural employment Archive June 2019"       https:/… <NA>                  
#> 11 "Cultural trade Archive June 2021"            https:/… <NA>                  
#> 12 "Feature Film Archive October 2024"           https:/… October 2024          
#> # ℹ abbreviated name: ¹​last_updated_description
```

Each bulk files consists of multiple CSV files and the `uisapi` package
currently does not provide automatic importers for these files. Rather,
you can use base utils to download a specific file, unzip it, and read
its files. For instance:

``` r
download.file(
  "https://uis.unesco.org/sites/default/files/documents/bdds/092024/SDG.zip",
  destfile = "SDG.zip"
)
unzip("SDG.zip")
read.csv("SDG_COUNTRY.csv")
```

## Contributing

Contributions to `uisapi` are welcome! If you’d like to contribute,
please follow these steps:

1.  **Create an issue**: Before making changes, create an issue
    describing the bug or feature you’re addressing.
2.  **Fork the repository**: After receiving supportive feedback from
    the package authors, fork the repository to your GitHub account.
3.  **Create a branch**: Create a branch for your changes with a
    descriptive name.
4.  **Make your changes**: Implement your bug fix or feature.
5.  **Test your changes**: Run tests to ensure your changes don’t break
    existing functionality.
6.  **Submit a pull request**: Push your changes to your fork and submit
    a pull request to the main repository.
