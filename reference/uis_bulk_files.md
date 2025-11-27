# Get files available for download via UIS BDDS

Retrieves information about files available in the UNESCO Institute for
Statistics (UIS) Bulk Data Download Service (BDDS).

## Usage

``` r
uis_bulk_files()
```

## Value

A data frame with information about files:

- file_name:

  Character. The name of the data set.

- file_url:

  Character. The URL of the data set.

- last_updated_description:

  Character. Information about last update.

## Examples

``` r
# \donttest{
# Download available files for bulk download
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
#>  7 "Education Non Core Archive February 2020"    https:/… NA                    
#>  8 "Research and Development (R&D) Archive Marc… https:/… NA                    
#>  9 "Innovation Archive April 2017"               https:/… NA                    
#> 10 "Cultural employment Archive June 2019"       https:/… NA                    
#> 11 "Cultural trade Archive June 2021"            https:/… NA                    
#> 12 "Feature Film Archive October 2024"           https:/… October 2024          
#> # ℹ abbreviated name: ¹​last_updated_description
# }
```
