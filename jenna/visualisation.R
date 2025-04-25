library(tidyverse)

df <- read_csv("~/Downloads/result_df_wt.csv.gz")  %>%
  mutate(pos = 1:dplyr::n()) %>%
  pivot_longer(cols = -pos, names_to = 'track', values_to = 'value') %>%
  # mutate(rough_coordinate = 166175000 - 169000 + 32*pos) %>%
  filter(rough_coordinate > 165980000 & rough_coordinate < 166130000)

rough_start = 187965

rough_end = 361399


ggplot(df, aes(x = rough_coordinate, y = value, colour = track %in% c(17, 18, 19))) +
  geom_point(alpha = 0.01) +
  facet_wrap(~track %in% 17:19)


hmm <- df %>%
  group_by(track) %>%
  mutate(sum = sum(value)) %>%
  ungroup() %>%
  distinct(track, sum)
