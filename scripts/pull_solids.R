## ---------------------------
## parsing script to get solids data from most recent date
## ---------------------------

# library(readxl)
# library(lubridate)
# library(reshape2)
# library(dplyr)

get_recent_tss <- function(file_path, choose_date){
  
  df <- read_excel(path = file_path, sheet = "solids")
  
  # date formatting
  choose_date <- ymd(choose_date) 
  df$date <- as_date(df$date)
  
  all_dates <- unique(df$date)
  
  # find closest date
  close_date <- all_dates[which(abs(choose_date - all_dates) == min(abs(choose_date - all_dates)))]
  
  # select rows with date match
  df_select <- df %>% filter(date == close_date)
  
  # find TSS
  solids_df <- df_select %>% group_by(sample) %>% summarise(TSS = mean(TSS), VSS = mean(VSS))
  
  return(solids_df)
  
} 



## debug zone ---
# file_path <- "C:/Users/mckyf/Northwestern University/Wells Research Group - CANDO+P Reactor/04 Performance data/daily_weekly_measurements.xlsx"
# choose_date <- "2023-03-27"
# 
# get_recent_tss(file_path, choose_date)


