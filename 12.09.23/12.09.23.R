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

#map country and region names from country_regions to all_countries
#replace country_iso3 in all_countries with country_name in country_regions

#get list of region names and the code each relates to
regions <- unique(select(country_regions, region_code, region_name))
#get list of country names and the code each relates to
#not using alternative country names as these columns contain NA values
countries <- unique(select(country_regions, country_iso3, country_name))


