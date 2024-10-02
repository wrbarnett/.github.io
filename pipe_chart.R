library(tidyverse)
library(ggplot2)

dat1 <- read_csv("vae.csv", show_col_types = FALSE)

vae_type <- dat1 %>%
  select(vaetype) %>%
  as.data.frame()

vae_type_label <- vae_type %>%
  mutate(
  vae_type = factor(vaetype, levels = c(0, 1, 2, 3), labels = c("No VAE", "VAC", "IVAC", "PVAP")))

ggplot(vae_type_label, aes(x = vae_type)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Distribution of Outcomes on Ventilator", x = "VAE Type", y = "Count")

rm(dat1)
