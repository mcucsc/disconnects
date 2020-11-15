###Loading Packages###
library(here)
library(tidyverse)
library(reshape2)

### CMS Information ###

#Loading CMS CSV Files
cms_prop <- read.csv(here("01_raw-data", "CMS_Proponants_111420.csv"),
                  stringsAsFactors = F) %>% 
  rename("Rhincodon typus 1999" = "Rhincodon.typus.1999") %>% 
  rename("Isurus spp." = "Isurus.spp.") %>% 
  rename("Lamna nasus" = "Lamna.nasus") %>% 
  rename("Manta birostris" = "Manta.birostris") %>% 
  rename("Alopias spp." = "Alopas.spp.") %>% 
  rename("Carcharhinus falciformis" = "Carcharhinus.falciformis") %>% 
  rename("Manta alfredi" = "Manta.alfredi") %>% 
  rename("Mobula spp." = "Mobula.spp.") %>% 
  rename("Sphyrna spp." = "Sphyrna.spp.") %>% 
  rename("Prionace glauca" = "Prionace.glauca") %>% 
  rename("Rhincodon typus 2017" = "Rhincodon.typus.2017") %>% 
  rename("Sphyrna zygaena" = "Sphyrna.zygaena") %>% 
  rename("Carcharhinus longimanus" = "Carcharhinus.longimanus")

cms_state <- read.csv(here("01_raw-data", "CMS_Statements_111420.csv"),
                     stringsAsFactors = F) %>% 
  rename("Manta birostris" = "Manta.birostris") %>% 
  rename("Alopias spp." = "Alopas.spp.") %>% 
  rename("Carcharhinus falciformis" = "Carcharhinus.falciformis") %>% 
  rename("Manta alfredi" = "Manta.alfredi") %>% 
  rename("Mobula spp." = "Mobula.spp.") %>% 
  rename("Sphyrna spp." = "Sphyrna.spp.") %>% 
  rename("Prionace glauca" = "Prionace.glauca") %>% 
  rename("Rhincodon typus 2017" = "Rhincodon.typus.2017") %>% 
  rename("Sphyrna zygaena" = "Sphyrna.zygaena") %>% 
  rename("Carcharhinus longimanus" = "Carcharhinus.longimanus")

cms_info <- read.csv(here("01_raw-data", "CMS_VotingRecords_111420.csv"),
                     stringsAsFactors = F) %>% 
  select(App.I.Year, App.II.Year, MoU.Annex, Species.Name) %>% 
  rename("Species"="Species.Name")

#Changing from wide to long format
cms_prop_long <- melt(cms_prop, id = c("Alpha3Code","CountryName"), variable.name = "Species") %>% 
  drop_na() 
cms_state_long <- melt(cms_state, id = c("Alpha3Code","CountryName"), variable.name = "Species") %>% 
  drop_na()

#Combining with listing year and Appendix information
cms_prop_combo <- left_join(cms_info,cms_prop_long, by="Species") %>% 
  mutate_all(list(~na_if(.,""))) %>% 
  mutate_all(list(~na_if(.,"-")))
cms_state_combo <- left_join(cms_info,cms_state_long, by="Species") %>% 
  mutate_all(list(~na_if(.,""))) %>% 
  mutate_all(list(~na_if(.,"-")))


