
<!-- README.md is generated from README.Rmd. Please edit that file -->

# theblock

<!-- badges: start -->
<!-- badges: end -->

`theblock` provides data on Weekly room wins, by team and judge, and
auction results for Seasons 5 to 19 of the Australian Reality TV Series
“The Block”.

## Installation

You can install the development version of theblock from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("MikeLydeamore/theblock")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(theblock)

# Data on weekly room wins
head(room_results)
#>   week       area   judge      couple score season
#> 1    1 Front Room Shaynna dale_sophie     6      5
#> 2    1 Front Room Shaynna mike_andrew     5      5
#> 3    1 Front Room Shaynna   brad_lara     5      5
#> 4    1 Front Room Shaynna    dan_dani     5      5
#> 5    1 Front Room    John dale_sophie     5      5
#> 6    1 Front Room    John mike_andrew     5      5

# And on auction results
head(auction_results)
#>   rank      couple reserve auction_result profit total_winnings auction_order
#> 1    1   brad_lara 1114000        1620000 506000         606000             1
#> 2    2    dan_dani  992000        1440000 448000         448000             2
#> 3    3 mike_andrew  966000        1400001 434001         434001             4
#> 4    4 dale_sophie  975000        1330000 355000         355000             3
#> 5    1  phil_amity 1375000        1670000 295000         395000             4
#> 6    2  josh_jenna 1375000        1650000 275000         275000             1
#>   season bought_by amount_sold_for_after_auction total_profit
#> 1      5      <NA>                            NA           NA
#> 2      5      <NA>                            NA           NA
#> 3      5      <NA>                            NA           NA
#> 4      5      <NA>                            NA           NA
#> 5      6      <NA>                            NA           NA
#> 6      6      <NA>                            NA           NA
```
