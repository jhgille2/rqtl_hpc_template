#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param simulated_cross
#' @param cross_permutations
#' @param pheno
#' @return
#' @author Jay Gillenwater
#' @export
do_stepwise_mapping <- function(cross, combined_permutations, pheno, sig_alpha) {

    # First, get the phenotype column number and the penalties for the phenotype
    pheno_col_number <- str_detect(phenames(simulated_cross), paste0("\\b", pheno, "\\b")) %>% which()
    
    perm_col_names <- combined_permutations %>% 
      purrr::pluck("full") %>% 
      colnames()
    
    # Get the index of the phenotype name in the permutation column names
    perm_col_index <- str_detect(perm_col_names, paste0("\\b", pheno, "\\b")) %>% which()
    
    # Calculate the penalties for the 
    pheno_penalties  <- calc.penalties(combined_permutations, 
                                       lodcolumn = perm_col_index,
                                       alpha     = sig_alpha)

    simulated_cross <- calc.genoprob(simulated_cross)

    # Perform stepwise mapping on the given phenotype
    stepwise_result <- stepwiseqtl(cross            = simulated_cross, 
                                   pheno.col        = pheno, 
                                   method           = "hk", 
                                   penalties        = pheno_penalties, 
                                   keeptrace        = TRUE, 
                                   refine.locations = TRUE,
                                   additive.only    = TRUE)

    # Return the result of the mapping
    return(stepwise_result)
}
