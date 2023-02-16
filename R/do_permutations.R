#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param simulated_cross
#' @param n_perm
do_permutations <- function(simulated_cross, n_perm = 100, n_cores = 5, phenos = pheno_names) {

  # Scantwo permutations for stepwise mapping
  scantwo_perms <- scantwo(cross     = simulated_cross, 
                           pheno.col = phenos, 
                           model     = "normal", 
                           method    = "hk", 
                           n.perm    = n_perm, 
                           n.cluster = n_cores)

  return(scantwo_perms)
}
