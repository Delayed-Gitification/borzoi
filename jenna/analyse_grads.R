library(tidyverse)


nts <-  c('A', 'C', 'G', 'T')

df <- read_csv("~/Downloads/pred_grad_wt.csv", 
               col_names = nts) %>%
  mutate(pos = 1:n() + 165797856) %>%
  pivot_longer(cols = nts) %>%
  filter(value != 0)
