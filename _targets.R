## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

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
                               n_individuals = 200, cross_type = "riself", 
                               missing_prob = 0.05)), 

    # Permutations
    tar_target(cross_permutations, 
                do_permutations(simulated_cross, n_perm = 100)), 

    # QTL mapping with stepwiseqtl
    tar_target(qtl_mapping, 
                do_stepwise_mapping(simulated_cross, cross_permutations))



)
