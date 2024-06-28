library(tidyverse)

df <- read_csv("/Volumes/lab-ulej/home/users/wilkino/POSTDOC/borzoi/borzoi/jenna/ism_results.csv") %>%
  filter(1:n() > 1) %>%
  mutate(position = as.numeric(position)) %>%
  mutate(downsampled = 10*as.integer(position/10000))

ggplot(df, aes(x = factor(downsampled), y = score)) +
  geom_boxplot() +
  xlab('Genomic position/kb')

best_muts <- df %>%
  filter(downsampled > 165980) %>%
  filter(downsampled < 166160) %>%
  filter(score > quantile(score, 0.99))

write_csv(best_muts, "/Volumes/lab-ulej/home/users/wilkino/POSTDOC/borzoi/borzoi/jenna/best_single_muts.csv")


# then with two mutations

df_second_mut <- read_csv("/Volumes/lab-ulej/home/users/wilkino/POSTDOC/borzoi/borzoi/jenna/ism_results_second_mut.csv")

df_second_mut2 <- df_second_mut %>%
  mutate(initial_pos = as.numeric(word(first_mutation, 1, sep=';')),
         initial_nt = word(first_mutation, 2, sep=';')) %>%
  left_join(df %>% dplyr::select(initial_pos = position, initial_nt = nucleotide, initial_score = score)) %>%
  mutate(score_change = score - initial_score)
