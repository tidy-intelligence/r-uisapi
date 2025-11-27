# Get available UIS API versions

Retrieves information about the available versions of the UNESCO
Institute for Statistics (UIS) API.

## Usage

``` r
uis_get_versions(default_only = FALSE)
```

## Arguments

- default_only:

  Logical. Indicates whether only the current default version should be
  retrievend. Defaults to FALSE.

## Value

A data frame with the following columns:

- version:

  Character. The version identifier.

- publication_date:

  Date-time. The date when the version was released.

- description:

  Character. The description of the version.

- theme:

  List column. Each element is a nested data frame containing
  information about themes available in the version, with columns:
  theme_id, theme_last_update, theme_description

## Examples

``` r
# \donttest{
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
# }
```
