library(tidyverse)
library(zoo)

setwd("~/Documents/GitHub/borzoi/jenna/")

nts <-  c('A', 'C', 'G', 'T')

df <- read_csv("~/Downloads/pred_grad_wt.csv", 
               col_names = nts) %>%
  mutate(pos = 1:n() + 165797856) %>%
  pivot_longer(cols = nts) %>%
  filter(value != 0) %>%
  mutate(mean_val = rollmean(value, k = 10, na.pad = T)) %>%
  filter(!is.na(mean_val)) %>%
  mutate(low_region = mean_val < quantile(mean_val, 0.001),
         high_region = mean_val > quantile(mean_val, 0.999)) 

bed <- df %>% 
  filter(low_region) %>%
  mutate(chr = 'chr2') %>%
  mutate(pos2 = pos+1) %>%
  dplyr::select(chr, pos, pos2)

write_tsv(bed, 'low_regions.bed', col_names = F)


bed2 <- df %>% 
  filter(high_region) %>%
  mutate(chr = 'chr2') %>%
  mutate(pos2 = pos+1) %>%
  dplyr::select(chr, pos, pos2)

write_tsv(bed2, 'high_regions.bed', col_names = F)


best_targets = df %>%
  filter(low_region | value < quantile(value, 0.001))


write_csv(best_targets, 'best_targets.csv')




