## Local parallelization
options(clustermq.scheduler="multiprocess")

## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

# The phenotype names for mapping
pheno_names <- tibble(pheno = c("phenotype", 
                                paste0("phenotype", 2:5)))

## tar_plan supports drake-style targets and also tar_target()
tar_plan(


    # Simulate a genetic map for soybean
    tar_target(simulated_map, 
                simulate_soybean_map()), 

    # Simulate a QTL model
    tar_target(simulated_qtl, 
                simulate_qtl_model()), 

    # Simulate a cross
    tar_target(simulated_cross, 
                simulate_cross(simulated_map, simulated_qtl, 
                               n_individuals = 200, cross_type = "bc", 
                               missing_prob = 0.05)), 

    # Permutations. Run internally in parallel using snow. 
    # change n_cores to match how many cores are requested 
    tar_target(cross_permutations, 
                do_permutations(simulated_cross, n_perm = 10, 
                n_cores = 5, phenos = pheno_names$pheno)), 

    # QTL mapping with stepwiseqtl, use static branching to 
    # run targets in parallel
    mapping_targets <- tar_map(
            # Get phenotype names from the tibble
            values = pheno_names, 

            # Stepwise mapping targets
            tar_target(stepwise_results, 
                        do_stepwise_mapping(simulated_cross, 
                                            cross_permutations, 
                                            pheno))
    ), 

    # Combine mapping results to a list
    tar_combine(mapping_results, 
                mapping_targets[[1]], 
                command = list(!!!.x))

)
