#' @title Select a random sample of bulbs all time points.
#' @description A function to standardize the random selection of bulbs for the LED project in BYUI's MATH 119.
#' @param number_bulbs The number of bulbs to sample. Defaults to 1. The most changed argument to the function.
#' @param seed is used to make the random sample reproducible.  May change at teacher request.
#' @param dat is the data object from which the sample is taken.  Defaults to led_study.
#' @param columns_keep are the columns that should be returned from dat. Defaults to keep all the columns.
#' @export
#' @examples led_bulb(2, seed = 1976)
#' @export
led_bulb <- function(number_bulbs = 1, seed = 09012017, dat = data4led::led_study,
                     columns_keep = c("id", "hours", "intensity", 
                                      "normalized_intensity", "percent_intensity")) {
  
  # funciton has default seed.  Teacher can us this to give each 
  # student a random bulb that is retrievable.
  set.seed(seed)
  
  if (nrow(dat) < number_bulbs) stop("Cannot sample more bulbs that are in the data")
  
  id_sample <- sample(unique(dat$id), number_bulbs)
  
  dat[dat$id %in% id_sample,columns_keep]
  
}


#' @title Select all bulbs at the nearest time.
#' @description A function to standardize the time point selection for all LED bulbs for the LED project in BYUI's MATH 119.
#' @param time_bulb The bulb time that you would like. The most changed argument to the function.
#' @param number_bulbs The number of bulbs to sample. Defaults to all. 
#' @param seed is used to make the random sample reproducible.  May change at teacher request.
#' @param dat is the data object from which the sample is taken.  Defaults to led_study.
#' @param columns_keep are the columns that should be returned from dat.
#' @export
#' @examples led_time(425, number_bulbs = 10, seed = 1976)
#' @export
led_time <- function(time_bulb = 294, number_bulbs = NULL, seed = 09012017, 
                     dat = data4led::led_study,
                     columns_keep = c("id", "hours", "intensity", "percent_intensity")) {
  
  
  hour_check <- unique(dat$hours)
  
  nearest <- hour_check[order(abs(hour_check - time_bulb))][1]
  
  out <- dat[dat$hours == nearest, columns_keep]
  
  if (!is.null(number_bulbs)) {
    
    # funciton has default seed.  Teacher can us this to give each 
    set.seed(seed)
    out <- out[sample(nrow(out), number_bulbs), ]
    
  }
  
  out
  
}