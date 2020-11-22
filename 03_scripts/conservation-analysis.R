###Loading Packages###
library(here)
library(tidyverse)
library(reshape2)

cms_prop <- read.csv(here("02_processed-data","cms_prop_combo.csv"))
cms_state <- read.csv(here("02_processed-data","cms_state_combo.csv"))

cites_prop <- read.csv(here("02_processed-data","cites_prop_combo.csv"))
cites_state <- read.csv(here("02_processed-data","cites_state_combo.csv"))