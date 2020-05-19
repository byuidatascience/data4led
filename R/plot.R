
#' @title Create a time-series chart of LED bulbs.
#' @description Plot a ggplot2 linechart colored by bulb.
#' @param led_data is a data object from the function led_bulb().
#' @param use_intensity defines whether inensity or percent intensity is plotted on the y-axis.
#' @examples led_linechart(led_bulb(5))
#' led_linechart(led_bulb(5), TRUE)
#' @export
led_linechart <- function(led_data, use_intensity = FALSE) {
  
  
  if (use_intensity) {
    
    p_out <- ggplot2::ggplot(led_data, 
                             ggplot2::aes(x = hours, y = intensity, color = factor(id))) +
      ggplot2::geom_line() +
      ggplot2::geom_point() +
      ggplot2::theme_bw() +
      ggplot2::labs(x = "Time (hours)", y = "Lumens (intensity)", 
                    title = "Lumen intensity by bulb", 
                    color = "Bulb ID"
      )
    
  } else {
    
    p_out <- ggplot2::ggplot(led_data, 
                             ggplot2::aes(x = hours, y = percent_intensity, 
                                          color = factor(id))) +
      ggplot2::geom_line() +
      ggplot2::geom_point() +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position = "bottom") +
      ggplot2::labs(x = "Time (hours)", y = "Percent lumen output", 
                    title = "Percent Lumen intensity by bulb", 
                    color = "Bulb ID"
      )
    
  }
  
  p_out
  
} 

#' @title Create a histogram for bulb values.
#' @description Plot a ggplot2 histogram.
#' @param led_data is a data object from the function led_bulb().
#' @param use_intensity defines whether inensity or percent intensity is plotted on the y-axis.
#' @param nbins the number of bins to use in the histogram
#' @examples led_histogram(led_time(425))
# led_histogram(led_time(425), TRUE, 25)
#' @export
led_histogram <- function(led_data, use_intensity = FALSE, nbins = 15) {
  
  hour <- paste0(unique(led_data$hours), collapse = ",")
  
  if (use_intensity) {
    
    p_out <- ggplot2::ggplot(led_data, ggplot2::aes(x = intensity)) +
      ggplot2::geom_histogram(bins = nbins, color = "white") +
      ggplot2::theme_bw() +
      ggplot2::labs(x = "Lumen intensity", y = "Count", 
                    title = paste0("Lumen intensity at ", hour," hours"))
    
  } else {
    
    p_out <- ggplot2::ggplot(led_data, ggplot2::aes(x = percent_intensity)) +
      ggplot2::geom_histogram(bins = nbins, color = "white") +
      ggplot2::theme_bw() +
      ggplot2::labs(x = "Percent Lumen intensity", y = "Count", 
                    title = paste0("Lumen intensity at", hour," hours"))
    
  }
  
  p_out
  
}

