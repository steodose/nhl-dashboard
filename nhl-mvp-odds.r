library(dplyr) # for data wrangling
library(jsonlite) # for getting data 

# get today's date
today <- Sys.Date() 

# ensure data output folder exists
if (!dir.exists("data")) dir.create("data")

# url for getting mvp odds from rotowire
url <- "https://www.rotowire.com/betting/nhl/tables/player-futures.php?hart-trophy-odds"

# get data
result <- fromJSON(txt=url) 

# add today's date as a column
df <- result %>% 
  mutate(date = today)

# clean df and keep only top 10
df_clean <- df %>% 
  filter(future == 'Hart Trophy') %>%
  select(future:logo,mgm_odds, mgm_winPct) %>%
  slice_head(n = 10)

# write dataframe to .csv in a folder called "data/"
write.csv(df_clean, paste0("data/mvp_odds_", gsub("-", "_", today), ".csv"), row.names = F) 