tar_load(c(cross_permutations, 
            simulated_cross))

# Need a function that takes in a phenotype name and does stepise mapping on 
# just that phenotype. Need to extract the column number of the phenotype
# tp match 

# Table of phenotype names so that static branching can be used
# to make targets
pheno_names


do_stepwise_mapping <- function(simulated_cross, cross_permutations, pheno){

    # First, get the phenotype column number and the penalties for the phenotype
    pheno_col_number <- str_detect(phenames(simulated_cross), paste0("\\b", pheno, "\\b")) %>% which()
    pheno_penalties  <- calc.penalties(cross_permutations, lodcolumn = pheno_col_number)

    stepwise_result <- stepwiseqtl(cross     = simulated_cross, 
                                   pheno.col = pheno, 
                                   method    = "hk", 
                                   penalties = pheno_penalties, 
                                   keeptrace = TRUE, 
                                   refine.locations = TRUE)

    return(stepwise_result)
}

