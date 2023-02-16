#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

simulate_qtl_model <- function() {

  # The qtl model is a matrix with three columns: 
  # chromosome, position, and effect size of a QTL. 
  # By default, rqtl simulates phenotypes from a 
  # normal distribution with sd=1

  # Simulate 5 QTL of different sizes
  qtl_model <- rbind(c(1, 20, 0.25), 
                     c(2, 15, 0.5), 
                     c(5, 50, 0.75), 
                     c(10, 25, 1), 
                     c(15, 30, 1.25))

  return(qtl_model)
}
