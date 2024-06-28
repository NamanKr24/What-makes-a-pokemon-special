# Loading the packages

library(ggplot2)

# Reading the file

source("Analysis_Wrangling.R")

# Viewing

head(pokedex_leg, n = 10)

head(pokedex_myt, n = 10)

# Total Statistics

pokedex_leg %>%
  ggplot(aes(x = name, y = total)) +
    geom_point(color = "brown") +
    labs(y = "", x = "")  +
    geom_text(aes(label = ifelse(total < 550, as.character(name), "")),
              vjust = 1, hjust = -0.3) +
    theme_minimal() +
    theme(panel.background = element_rect(fill = "snow", color = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(color = "black"),
          axis.text.x = element_blank(),
          axis.text = element_text(color =  "black", face = "bold", family = "serif"))
  
pokedex_myt %>%
  ggplot(aes(x = name, y = total)) +
    geom_point(color = "violet") +
    labs(y = "", x = "")  +
    geom_text(aes(label = ifelse(total != 600, as.character(name), "")),
              vjust = 1, hjust = -0.3) +
    theme_minimal() +
    theme(panel.background = element_rect(fill = "snow", color = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(color = "black"),
          axis.text.x = element_blank(),
          axis.text = element_text(color =  "black", face = "bold", family = "serif"))

# Battle statistics

  pokedex_comb %>%
    ggplot(aes(x = rank, y = value, fill = rank)) +
      geom_boxplot(varwidth = TRUE) +
      facet_wrap(~battle_stats) +
      scale_fill_manual(values = c("Legendary" = "brown", "Mythical" = "violet")) +
      labs(x = "", y = "", fill = "")  +
      theme_minimal() +
      theme(panel.background = element_rect(fill = "snow", color = "white"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.line = element_line(color = "black"),
            axis.text.x = element_blank(),
            axis.text = element_text(color =  "black", face = "bold", family = "serif"))

  
# Height and Weight
  
  pokedex_leg %>%
    ggplot(aes(x = height, y = weight)) +
      geom_point(color = "brown") +
      labs(y = "Weight", x = "Height")  +
      geom_text(aes(label = ifelse(height > 6100 | weight > 5000, as.character(name), "")),
                vjust = 1, hjust = 0.5, size = 3) +
      theme_minimal() +
      theme(panel.background = element_rect(fill = "snow", color = "white"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.line = element_line(color = "black"),
            axis.title.y = element_text(color = "darkgreen", size = 12, family = "serif"),
            axis.title.x = element_text(color = "blue", size = 12, family = "serif"),
            axis.text = element_text(color =  "black", face = "bold", family = "serif"))
  
  pokedex_myt %>%
    ggplot(aes(x = height, y = weight)) +
      geom_point(color = "violet") +
      labs(y = "Weight", x = "Height")  +
      geom_text(aes(label = ifelse(height > 15 & weight > 1500, as.character(name), "")),
                vjust = 1, hjust = 1) +
      theme_minimal() +
      theme(panel.background = element_rect(fill = "snow", color = "white"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.line = element_line(color = "black"),
            axis.title.y = element_text(color = "darkgreen", size = 12, family = "serif"),
            axis.title.x = element_text(color = "blue", size = 12, family = "serif"),
            axis.text = element_text(color =  "black", face = "bold", family = "serif"))

# Generations

  pokedex_leg1 %>%
    ggplot(aes(x = count, y = generation)) +
      geom_bar(stat = "identity", fill = "brown") +
      labs(y = "", x = "Count") +
      theme_minimal() +
      theme(panel.background = element_rect(fill = "snow", color = "white"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.line = element_line(color = "black"),
            axis.title.x = element_text(color = "blue", size = 12, family = "serif"),
            axis.text = element_text(color =  "black", face = "bold", family = "serif"))
  
  pokedex_myt1 %>%
    ggplot(aes(x = count, y = generation)) +
      geom_bar(stat = "identity", fill = "violet")  +
      labs(y = "", x = "Count") +
      theme_minimal() +
      theme(panel.background = element_rect(fill = "snow", color = "white"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.line = element_line(color = "black"),
            axis.title.x = element_text(color = "blue", size = 12, family = "serif"),
            axis.text = element_text(color =  "black", face = "bold", family = "serif"))

# Types

  pokedex_leg2 %>%
    ggplot(aes(x = count, y = reorder(type, count))) +
    geom_bar(stat = "identity", fill = "brown") +
    labs(y = "Type", x = "Count") +
    theme_minimal() +
    theme(panel.background = element_rect(fill = "snow", color = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(color = "black"),
          axis.title.y = element_text(color = "darkgreen", size = 12, family = "serif"),
          axis.title.x = element_text(color = "blue", size = 12, family = "serif"),
          axis.text = element_text(color =  "black", face = "bold", family = "serif"))
  
  pokedex_myt2 %>%
    ggplot(aes(x = count, y = reorder(type, count))) +
    geom_bar(stat = "identity", fill = "violet") +
    labs(y = "Type", x = "Count") +
    theme_minimal() +
    theme(panel.background = element_rect(fill = "snow", color = "white"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(color = "black"),
          axis.title.y = element_text(color = "darkgreen", size = 12, family = "serif"),
          axis.title.x = element_text(color = "blue", size = 12, family = "serif"),
          axis.text = element_text(color =  "black", face = "bold", family = "serif"))