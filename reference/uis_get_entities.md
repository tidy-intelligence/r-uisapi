# Get geographical entities from UIS API

Retrieves information about geographical entities (countries, regions,
etc.) available in the UNESCO Institute for Statistics (UIS) API.

## Usage

``` r
uis_get_entities(version = NULL)
```

## Arguments

- version:

  Character. The API version to use. If NULL (default), the API's
  default version will be used. See
  [uis_get_versions](https://tidy-intelligence.github.io/r-uisapi/reference/uis_get_versions.md)
  for a list of supported versions.

## Value

A data frame with information about geographical entities:

- entity_id:

  Character. The unique identifier for the entity.

- entity_name:

  Character. The name of the geographical entity.

- entity_type:

  Character. The type of entity (e.g., country, region).

- region_group:

  Character. Information about the region grouping.

## Examples

``` r
# \donttest{
# Download entities for default version
uis_get_entities()
#> # A tibble: 462 × 4
#>    entity_id entity_name          entity_type region_group
#>    <chr>     <chr>                <chr>       <chr>       
#>  1 ABW       Aruba                NATIONAL    NA          
#>  2 AFG       Afghanistan          NATIONAL    NA          
#>  3 AGO       Angola               NATIONAL    NA          
#>  4 AIA       Anguilla             NATIONAL    NA          
#>  5 ALA       Åland Islands        NATIONAL    NA          
#>  6 ALB       Albania              NATIONAL    NA          
#>  7 AND       Andorra              NATIONAL    NA          
#>  8 ANT       Netherlands Antilles NATIONAL    NA          
#>  9 ARE       United Arab Emirates NATIONAL    NA          
#> 10 ARG       Argentina            NATIONAL    NA          
#> # ℹ 452 more rows

# Download entities for a specific version
uis_get_entities("20240910-b5ad4d82")
#> # A tibble: 475 × 4
#>    entity_id entity_name          entity_type region_group
#>    <chr>     <chr>                <chr>       <chr>       
#>  1 ABW       Aruba                NATIONAL    NA          
#>  2 AFG       Afghanistan          NATIONAL    NA          
#>  3 AGO       Angola               NATIONAL    NA          
#>  4 AIA       Anguilla             NATIONAL    NA          
#>  5 ALA       Åland Islands        NATIONAL    NA          
#>  6 ALB       Albania              NATIONAL    NA          
#>  7 AND       Andorra              NATIONAL    NA          
#>  8 ANT       Netherlands Antilles NATIONAL    NA          
#>  9 ARE       United Arab Emirates NATIONAL    NA          
#> 10 ARG       Argentina            NATIONAL    NA          
#> # ℹ 465 more rows
# }
```
