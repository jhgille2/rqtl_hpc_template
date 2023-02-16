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
do_stepwise_mapping <- function(simulated_cross, cross_permutations, pheno) {

      # First, get the phenotype column number and the penalties for the phenotype
    pheno_col_number <- str_detect(phenames(simulated_cross), paste0("\\b", pheno, "\\b")) %>% which()
    pheno_penalties  <- calc.penalties(cross_permutations, lodcolumn = pheno_col_number)

    # Perform stepwise mapping on the given phenotype
    stepwise_result <- stepwiseqtl(cross     = simulated_cross, 
                                   pheno.col = pheno, 
                                   method    = "hk", 
                                   penalties = pheno_penalties, 
                                   keeptrace = TRUE, 
                                   refine.locations = TRUE)

    # Return the result of the mapping
    return(stepwise_result)
}
