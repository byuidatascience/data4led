#'
#' @title LED example bulbs of lumen output
#' @description An example data set of LED bulbs based on actual data.
#' @format A data frame with columns:
#' \describe{
#'  \item{id}{The variable is integer. An id for each LED light measured}
#'  \item{hours}{The variable is numeric. The number of hours since the first measurement}
#'  \item{intensity}{The variable is numeric. The lumen output of the bulb. 800 lumens maps to a 60 watt incandescent bulb (https://www.lumens.com/how-tos-and-advice/light-bulb-facts.html)}
#'  \item{percent_intensity}{The variable is numeric. The percent light output based on the first measured intensity of the bulb}
#' }
#' @source \url{data_led_private}
#' @examples
#' \dontrun{
#' led_study
#'}
'led_study'



#'
#' @title LED example bulbs of lumen output for two products with standard procedure time point measurements
#' @description An example data set of LED bulbs based on actual data.
#' @format A data frame with columns:
#' \describe{
#'  \item{id}{The variable is numeric. An id for each LED light measured}
#'  \item{hours}{The variable is numeric. The number of hours since the first measurement}
#'  \item{percent_intensity}{The variable is numeric. The percent light output based on the first measured intensity of the bulb}
#'  \item{company}{The variable is character. Either A or B to represent to different company products}
#' }
#' @source \url{data_led_private}
#' @examples
#' \dontrun{
#' led_testing
#'}
'led_testing'



