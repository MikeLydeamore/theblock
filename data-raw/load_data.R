library(readr)
library(dplyr)
## Auction results

seasons <- 5:19

auction_results <- lapply(seasons, function(season) {
  result <- readr::read_csv(paste0("data-raw/auction_results_season_", season, ".csv"))

  if (any(is.na(result$rank))) {
    result$rank <- rank(-result$profit)
  }

  result$season <- season

  return (result)
}) |> dplyr::bind_rows()

usethis::use_data(auction_results, overwrite = TRUE)


room_results <- lapply(seasons, function(season) {
  result <- readr::read_csv(paste0("data-raw/room_scores_season_", season, ".csv")) |>
    tidyr::pivot_longer(!c(week, area, scores), names_to = "couple", values_to = "score") |>
    rename(judge = "scores")

  result$season <- season

  return (result)
}) |> dplyr::bind_rows()

usethis::use_data(room_results, overwrite = TRUE)
