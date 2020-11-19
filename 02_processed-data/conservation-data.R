###Loading Packages###
library(here)
library(tidyverse)
library(reshape2)

### CMS Information ###

#Test

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

#Combining with listing year and Appendix information ##Need to clearn up.
cms_prop_combo <- left_join(cms_info,cms_prop_long, by="Species") %>% 
  mutate_all(list(~na_if(.,""))) %>% 
  mutate_all(list(~na_if(.,"-")))
cms_state_combo <- left_join(cms_info,cms_state_long, by="Species") %>% 
  mutate_all(list(~na_if(.,""))) %>% 
  mutate_all(list(~na_if(.,"-")))

###CITES Information###

cites_prop <- read.csv(here("01_raw-data", "CITES_Proponants_111820.csv"),
                     stringsAsFactors = F) %>% 
  rename("Rhincodon typus" = "Rhincodon.typus") %>% 
  rename("Isurus spp." = "Isurus.spp.") %>% 
  rename("Lamna nasus" = "Lamna.nasus") %>% 
  rename("Manta spp." = "Manta.spp.") %>% 
  rename("Alopias spp." = "Alopias.spp.") %>% 
  rename("Carcharhinus falciformis" = "Carcharhinus.falciformis") %>% 
  rename("Mobula spp." = "Mobula.spp.") %>% 
  rename("Sphyrna spp." = "Sphyrna.spp.") %>%  
  rename("Carcharhinus longimanus" = "Carcharhinus.longimanus")

cites_state <- read.csv(here("01_raw-data", "CITES_Statements_111820.csv"),
                      stringsAsFactors = F) %>% 
  rename("Rhincodon typus" = "Rhincodon.typus") %>% 
  rename("Isurus spp." = "Isurus.spp.") %>% 
  rename("Lamna nasus" = "Lamna.nasus") %>% 
  rename("Manta spp." = "Manta.spp.") %>% 
  rename("Alopias spp." = "Alopias.spp.") %>% 
  rename("Carcharhinus falciformis" = "Carcharhinus.falciformis") %>% 
  rename("Mobula spp." = "Mobula.spp.") %>% 
  rename("Sphyrna spp." = "Sphyrna.spp.") %>%  
  rename("Carcharhinus longimanus" = "Carcharhinus.longimanus")

cites_info <- read.csv(here("01_raw-data", "CITES_VotingRecords_111820.csv"),
                     stringsAsFactors = F) %>% 
  select(App.I.Year, App.II.Year, MoU.Annex, Species.Name) %>% 
  rename("Species"="Species.Name")

#Changing from long to wide format
cites_prop_long <- melt(cites_prop, id = c("Alpha3Code","CountryName"), variable.name = "Species") %>% 
  drop_na() 
cites_state_long <- melt(cites_state, id = c("Alpha3Code","CountryName"), variable.name = "Species") %>% 
  drop_na()