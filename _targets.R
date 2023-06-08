## Local parallelization
options(clustermq.scheduler="multiprocess")

## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

# The phenotype names for mapping
pheno_names <- read_csv(here::here("data", "phenotype_names.csv"))
mapping_params <- crossing(pheno_names, sig_alpha = c(0.1, 0.05))


## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  
  
  ## Section: Simulated Data
  ## Comment out if using actual cross data
  ##################################################
  # # Simulate a genetic map for soybean
  # tar_target(simulated_map,
  #             simulate_soybean_map()),
  # 
  # # Simulate a QTL model
  # tar_target(simulated_qtl,
  #             simulate_qtl_model()),
  # 
  # # Simulate a cross
  # tar_target(cross,
  #             simulate_cross(simulated_map, simulated_qtl,
  #                            n_individuals = 200, cross_type = "bc",
  #                            missing_prob = 0.05)),
  
  ## Section: Import cross. Comment out if using simulated data
  ##################################################
  # The qtl cross file
  tar_file(cross_file,
           here::here("data", "raleigh_soja_cross.csv")),

  # Read in the cross file
  tar_target(cross,
             read.cross(file         = cross_file,
                        format       = "csv",
                        map.function = "kosambi",
                        F.gen        = 4,
                        genotypes    = c("AA", "AB", "BB", "A-", "B-"))),
  
  
  # Permutations. Run internally in parallel using snow. 
  # change n_cores to match how many cores are requested 
  tar_target(cross_permutations, 
             do_permutations(cross, 
                             n_perm  = 2500, 
                             n_cores = 50, 
                             phenos  = unique(mapping_params$pheno))), 
  
  # QTL mapping with stepwiseqtl, use static branching to 
  # run targets in parallel
  mapping_targets <- tar_map(
    
    # Get phenotype names and significance thresholds from the tibble
    values = mapping_params, 
    
    # Stepwise mapping targets
    tar_target(stepwise_results, 
               do_stepwise_mapping(cross, 
                                   cross_permutations, 
                                   pheno,
                                   sig_alpha))
  ), 
  
  # Combine mapping results to a list
  tar_combine(mapping_results, 
              mapping_targets[[1]], 
              command = list(!!!.x))
  
)
