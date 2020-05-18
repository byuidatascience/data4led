#' @title Select a random sample of bulbs all time points.
#' @description A function to standardize the random selection of bulbs for the LED project in BYUI's MATH 119.
#' @param number_bulbs The number of bulbs to sample. Defaults to 1.
#' @param seed is used to make the random sample reproducible.  May change at teacher request.
#' @param dat is the data object from which the sample is taken.  Defaults to led_study.
#' @param columns_keep are the columns that should be returned from dat.
#' @export
#' @examples led_bulb(2, seed = 1976)
#' @export
led_bulb <- function(number_bulbs = 1, seed = 09012007, dat = data4led::led_study,
                     columns_keep = c("id", "hours", "intensity", "percent_intensity")) {
  
  # funciton has default seed.  Teacher can us this to give each 
  # student a random bulb that is retrievable.
  set.seed(seed)
  
  if (nrow(dat) < number_bulbs) stop("Cannot sample more bulbs that are in the data")
  
  id_sample <- sample(unique(dat$id), number_bulbs)
  
  dat[dat$id %in% id_sample,columns_keep]
  
}