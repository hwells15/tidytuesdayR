library(tidytuesdayR)
library(tidyverse)
#load data from GitHub
tuesdata <- tidytuesdayR::tt_load('2023-09-12') #object is a list of data frames

#individual data frames
all_countries <- tuesdata$all_countries
country_regions <- tuesdata$country_regions
global_human_day <- tuesdata$global_human_day
global_economic_activity <- tuesdata$global_economic_activity

#context in README: https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-09-12/readme.md

##CHALLENGE: map country and region names from country_regions to all_countries

#replace country_iso3 in all_countries with country_name in country_regions
#get list of country names with the country code and region name they relate to
country_regions1 <- select(country_regions, region_name, country_name, country_iso3)
#left_join keeps all observations in x (all_countries)
all_countries1 <- all_countries %>% 
  left_join(y = country_regions1, by = "country_iso3") %>% 
  #remove unneeded columns
  select(-c("country_iso3", "region_code"))

##CHALLENGE: for the Caribbean as a whole, display the average time spent each day for activities at the category level

#filter all_countries1 to get data for Caribbean only
caribbean <- all_countries1 %>% 
  filter(region_name == "Caribbean") %>%
  #remove unneeded columns and sort by country_name and category
  select(Category, hoursPerDayCombined, country_name) %>% 
  arrange(country_name, Category)

#calculate the total time spent per country in each category
caribbean_totals <- caribbean %>% 
  #group by country name and Category
  group_by(country_name, Category) %>% 
  #create new variable whose values are the sum of hours for each group
  mutate(HPD_categoryTotal = sum(hoursPerDayCombined)) %>% 
  #ungroup and remove unneeded column
  ungroup() %>% 
  select(-hoursPerDayCombined) %>% 
  #refine data
  unique()

#for all countries in the Caribbean, calculate the average time spent on each category
caribbean_averages




