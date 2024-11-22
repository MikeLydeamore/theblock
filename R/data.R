#' Auction Results from The Block
#' 
#' Contains auction results from Seasons 5 to 19 of The Block.
#' 
#' @format ## `auction_results`
#' A `tibble` containing 71 rows and 11 columns:
#' \describe{
#'  \item{rank}{Auction Rank. 1 indicates winning the auction}
#'  \item{couple}{Couple name, separated by underscore}
#'  \item{reserve}{Reserve price of the property}
#'  \item{auction_result}{Sell price of the property}
#'  \item{profit}{Amount taken home by team. Includes any penalties}
#'  \item{total_winnings}{Total winnings - includes prize money}
#'  \item{auction_order}{Order of the auction. 1 is first}
#'  \item{season}{Show season}
#'  \item{bought_by}{Some notably buyers have their names included. Most are NA}
#'  \item{amount_sold_for_after_auction}{Some properties are sold after auction, their price is put here}
#'  \item{total_profit}{Total amount taken home, includes deductions and prize money. Is often NA as Wikipedia doesn't store it for all seasons.}
#'}
#'  
"auction_results"

#' Room Results from The Block
#' 
#' Contains individual room results from Seasons 5 to 19 of The Block
#' 
#' @format ## `room_results`
#' A `tibble` containing 3236 rows and 6 columns:
#' \describe{
#'  \item{week}{Week of the show}
#'  \item{area}{Description of the room type}
#'  \item{judge}{Which judge gave the score. Includes "Total" as a judge. Note that
#'   total scores may not be the sum of the individual judge scores, due to penalties or bonus points.}
#'  \item{couple}{Couple name, separated by underscore}
#'  \item{score}{Score for the room, out of 10 (except for Total)}
#'  \item{season}{Show season}
#' }
"room_results"