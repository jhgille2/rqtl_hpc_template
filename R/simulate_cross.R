#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param simulated_map
#' @param simulated_qtl
#' @param n_individuals
#' @param cross_type
#' @param missing_prob
simulate_cross <- function(simulated_map, simulated_qtl, n_individuals = 200,
                           cross_type = "riself", missing_prob = 0.05) {

  # Simulate a cross using the simulated map, qtl model, 
  # and user-supplied parameters
  simulated_cross <- qtl::sim.cross(map = simulated_map,
                                    model = simulated_qtl, 
                                    n.ind = n_individuals,
                                    type = cross_type, 
                                    missing.prob = missing_prob)

  # Add some more phenotypes to the cross (just copies of
  # the phenotype thats already been simulated)
  for(i in 2:5){

      current_pheno_name <- paste0("phenotype", i)
      simulated_cross$pheno[, current_pheno_name] <- simulated_cross$pheno$phenotype

  }

  return(simulated_cross)
}
