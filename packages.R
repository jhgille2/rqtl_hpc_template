# Check if pacman is installed and install it if it is not
list.of.packages <- c("pacman")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Workflow organization
pacman::p_load(conflicted,
dotenv,
targets,
tarchetypes)

# Data wrangling
pacman::p_load(dplyr,
tidyr,
janitor,
jsonlite,
tibble,
stringr)

# Parallel
pacman::p_load(snow,
clustermq)

# Analysis
pacman::p_load(qtl,
pryr)