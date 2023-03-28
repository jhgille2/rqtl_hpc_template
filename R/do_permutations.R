#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param simulated_cross
#' @param n_perm
do_permutations <- function(cross, n_perm = 100, n_cores = 5, phenos = pheno_names) {
  
  # Need to break the permutations down into smaller chunks of phenotypes
  interval_width <- 3
  start <- 2
  end   <- nphe(cross)
  
  # Numbr of intervals 
  n_intervals <- ceiling((nphe(cross)-1)/4)
  
  # Do scantwo permutations of chunks of size interval-width +  1
  permutation_chunks <- vector("list", length = n_intervals)
  for(i in 1:n_intervals){
    
    int_start <- start
    int_end   <- int_start + interval_width
    
    
    
    if(int_end > end){
      int_end <- end
    }
    
    # Scantwo permutations for stepwise mapping
    permutation_chunks[[i]] <- scantwo(cross     = cross, 
                                       pheno.col = c(int_start:int_end), 
                                       model     = "normal", 
                                       method    = "hk", 
                                       n.perm    = n_perm, 
                                       n.cluster = n_cores)
    
  }
  
  # Combine all permutations
  scantwo_perms <- permutation_chunks %>% 
    reduce(cbind)

  return(scantwo_perms)
}
