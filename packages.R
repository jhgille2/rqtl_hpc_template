# Check if pacman is installed and install it if it is not
list.of.packages <- c("pacman")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Workflow organization
pacman::p_load(conflicted, 
dotenv, 
targets)

# Data wrangling
pacman::p_load(dplyr, 
tidyr, 
janitor, 
jsonlite)

# Analysis
pacman::p_load(qtl)