library(rvest)
library(dplyr)
library(tidyr)

url <- "https://en.wikipedia.org/wiki/The_Block_season_19"

page <- read_html(url)



get_scores_table <- function(webpage) {
  tbls <- html_nodes(webpage, "table")
  
  scores <- html_table(tbls[grep("Judges' Scores", tbls, ignore.case = TRUE)], fill = TRUE)[[1]]

  if (!"Week" %in% colnames(scores) | "Teams" %in% colnames(scores)) {
    colnames(scores) <- scores[1,]
    scores <- scores[-1,]
  }
  
  
  scores |>
    janitor::clean_names() |>
    mutate(
      across(!(1:3), ~gsub("\\[\\d+\\]", "", .x)),
      across(!(1:3),  ~ gsub("½", ".5", .x)),
      across(!(1:3), ~ gsub("\\^.*", "", .x)),
      across(!(1:3), ~ gsub("\\*", "", .x)),
      across(!(1:3), ~gsub("\\(.*?\\)", "", .x)),
      across(!(1:3), ~gsub("\\[.*?\\]", "", .x)),
      #across(!(1:3),  as.numeric),
    ) |>
    rename(area = "area_s") |>
    filter( week == 9)
}

convert_money <- function(money_str) {
  
  money_str <- tolower(money_str)
  money_str <- gsub("\\$", "", money_str)
  money_str <- gsub(",", "", money_str)
  
  # Identify the abbreviation and extract the numeric part
  if (grepl("k$", money_str)) {
    return(as.numeric(sub("k$", "", money_str)) * 1e3)
  } else if (grepl("m$", money_str)) {
    return(as.numeric(sub("m$", "", money_str)) * 1e6)
  } else if (grepl("b$", money_str)) {
    return(as.numeric(sub("b$", "", money_str)) * 1e9)
  } else {
    # If there's no abbreviation, just convert to numeric
    return(as.numeric(money_str))
  }
}

convert_ordinals <- function(string) {
  digits <- gregexpr("\\d+", string)
  regmatches(string, digits)[[1]] |> as.numeric() # I'm sure this will never go wrong
}

get_auction_table <- function(webpage) {
  tbls <- html_nodes(webpage, "table")
  
  auction_results <- html_table(tbls[grep("(Total Winnings|Total Profit)", tbls, ignore.case = TRUE)], fill = TRUE, na.strings = c("NA", "N/A", "Passed In"))[[1]]

  auction_results |>
    janitor::clean_names() |>
    rowwise() |>
    rename(
      auction_result = starts_with("auction_result"),
      couple = starts_with("couple"),
      rank = starts_with("rank"),
      reserve = starts_with("reserve"),
      auction_result = starts_with("auction_result"),
      profit = starts_with("profit"),
      total_winnings = starts_with("total_winnings"),
      auction_order = starts_with("auction_order")      
    ) |>
    mutate(
      across(matches(c("reserve", "auction_result", "profit", "total_winnings", "amount_sold_for_after_auction")), convert_money),
      auction_order = convert_ordinals(auction_order),
      rank = as.numeric(rank)
    ) |>
    ungroup() |>
    mutate(
      couple = tolower(gsub("\\s(&|and)\\s", "_", couple))
    )
    
}

seasons <- 5:19

for (season in seasons) {
  url <- paste0("https://en.wikipedia.org/wiki/The_Block_season_", season)

  page <- read_html(url)

  scores <- get_scores_table(page)
  auctions <- get_auction_table(page)

  write.csv(
    x = scores, 
    file = paste0("data-raw/room_scores_season_", season, ".csv"),
    row.names = FALSE
  )

  # write.csv(
  #   x = auctions, 
  #   file = paste0("data-raw/auction_results_season_", season, ".csv"),
  #   row.names = FALSE
  # )

}


