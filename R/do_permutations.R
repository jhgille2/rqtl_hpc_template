#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param simulated_cross
#' @param n_perm
do_permutations <- function(cross, n_perm = 100, n_cores = 5, phenos = pheno_names) {
  
  # # Need to break the permutations down into smaller chunks of phenotypes
  interval_width <- 1
  int_start      <- 2
  end            <- nphe(cross)
  # 
  # # Number of intervals 
  # n_intervals <- ceiling((nphe(cross) - 1)/(interval_width + 1))
  
  # Do scantwo permutations of chunks of size interval-width +  1
  # permutation_chunks <- vector("list", length = n_intervals)
  
  permutation_chunks <- vector("list", length = nphe(cross) - 1)
  for(i in 1:length(permutation_chunks)){
    
    int_end   <- int_start + interval_width
    
    if(int_end >= end){
      int_end <- end
    }
    
    # Scantwo permutations for stepwise mapping
    permutation_chunks[[i]] <- scantwo(cross     = cross, 
                                       pheno.col = int_start, 
                                       model     = "normal", 
                                       method    = "hk", 
                                       n.perm    = n_perm, 
                                       n.cluster = n_cores)
    
    print(paste("i:", i))
    print(paste("int_start:", int_start))
    print(paste("int_end", int_end))
    print(phenames(cross)[int_start:int_end])
    int_start <- int_end + 1
  }
  
  # # Combine all permutations
  # scantwo_perms <- permutation_chunks %>% 
  #   reduce(cbind)
  
  return(permutation_chunks)
}
