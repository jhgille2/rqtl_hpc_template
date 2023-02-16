#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

simulate_soybean_map <- function() {

  # Use genetic lengths from the consensus map
  chr_lens <- c(98, 140, 99, 112, 87, 
                137, 135, 147, 100, 133, 
                124, 121, 120, 106, 100, 
                92, 119, 105, 101, 112)

# Simulate and return the genetic map
simulated_map <- qtl::sim.map(len = chr_lens,
                              n.mar = 50, 
                              include.x = FALSE)

return(simulated_map)
}
