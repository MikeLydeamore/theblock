## Auction results

seasons <- 5:19

lapply(seasons, function(season) {
  result <- readr::read_csv(paste0("data-raw/auction_results_season_", season, ".csv"))

  if (any(is.na(result$rank))) {
    result$rank <- rank(result$profit)
  }

  result$season <- season

  return (result)
}) |> dplyr::bind_rows()
