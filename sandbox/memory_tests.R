tar_load(simulated_cross)


mem_2_cores <- mem_change(do_permutations(simulated_cross, n_perm = 10,
                n_cores = 5, phenos = pheno_names$pheno))
