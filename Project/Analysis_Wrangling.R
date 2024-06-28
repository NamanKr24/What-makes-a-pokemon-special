# Loading the packages

library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Reading and Manipulating the file

pokedex <- read_csv("Pokedex.csv") %>%
            select(-c(evolves_from, abilities, desc)) %>%
            mutate(name = str_to_title(name)) %>%
            mutate(rank = str_to_title(rank)) %>%
            mutate(type1 = str_to_title(type1)) %>%
            mutate(type2 = str_to_title(type2)) %>%
            mutate(generation = str_to_title(generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Ii", "Generation-II", generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Iii", "Generation-III", generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Iv", "Generation-IV", generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Vi", "Generation-VI", generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Vii", "Generation-VII", generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Viii", "Generation-VIII", generation)) %>%
            mutate(generation = ifelse(generation == "Generation-Ix", "Generation-IX", generation))

pokedex$generation <- factor(pokedex$generation, levels = c("Generation-I", "Generation-II", "Generation-III", "Generation-IV",
                                                                    "Generation-V", "Generation-VI", "Generation-VII", "Generation-VIII", "Generation-IX"))

# Counting

pokedex_leg <- pokedex %>%
                filter(rank == "Legendary")

pokedex_myt <- pokedex %>%
                filter(rank == "Mythical")

# Combined for stats

  pokedex_comb <- rbind(pokedex_leg, pokedex_myt) %>%
                    select(rank, hp, atk, def, spatk, spdef, speed) %>%
                    pivot_longer(names_to = "battle_stats", values_to = "value", c(-rank)) %>%
                    mutate(battle_stats = ifelse(battle_stats == "atk", "Attack", battle_stats)) %>%
                    mutate(battle_stats = ifelse(battle_stats == "def", "Defense", battle_stats)) %>%
                    mutate(battle_stats = ifelse(battle_stats == "hp", "Health", battle_stats)) %>%
                    mutate(battle_stats = ifelse(battle_stats == "spatk", "Special Attack", battle_stats)) %>%
                    mutate(battle_stats = ifelse(battle_stats == "spdef", "Special Defense", battle_stats)) %>%
                    mutate(battle_stats = ifelse(battle_stats == "speed", "Speed", battle_stats))
    
  pokedex_comb$battle_stats <- factor(pokedex_comb$battle_stats, levels = c("Health", "Attack", "Defense",
                                                                            "Special Attack", "Special Defense", "Speed"))
# Generations

pokedex_leg1 <- pokedex_leg %>%
                  group_by(generation) %>%
                  summarise(count = n())

pokedex_myt1 <- pokedex_myt %>%
                  group_by(generation) %>%
                  summarise(count = n())

# Types

pokedex_leg_temp1 <- pokedex_leg %>%
                      select(-type2) %>%
                      rename(type = type1)

pokedex_leg_temp2 <- pokedex_leg %>%
                      select(-type1) %>%
                      rename(type = type2) %>%
                      filter(type != "None")

pokedex_leg2 <- rbind(pokedex_leg_temp1, pokedex_leg_temp2) %>%
                  arrange(index) %>%
                  group_by(type) %>%
                  summarise(count = n())

pokedex_myt_temp1 <- pokedex_myt %>%
                      select(-type2) %>%
                      rename(type = type1)

pokedex_myt_temp2 <- pokedex_myt %>%
                      select(-type1) %>%
                      rename(type = type2) %>%
                      filter(type != "None")

pokedex_myt2 <- rbind(pokedex_myt_temp1, pokedex_myt_temp2) %>%
                  arrange(index) %>%
                  group_by(type) %>%
                  summarise(count = n())