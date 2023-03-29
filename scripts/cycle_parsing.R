## ---------------------------
## spreadsheet parsing script for CANDO+P in-cycle sampling data
## ---------------------------

# library(readxl)
# library(lubridate)
# library(reshape2)
# library(dplyr)

cycle_parse <- function(file_path, choose_date){
  df <- read_excel(path = file_path, sheet = "data")
  
  # calculate time in hour from beginning of cycle
  df_parsed <- df %>% 
    filter(date == ymd(choose_date)) %>%
    mutate(hour = time_length(interval(min(time), time), "hour")) %>%
    select(-c(date, time, "NO2+NO3_mgNL"))
  
  # long df for plotting
  df_parsed <- melt(df_parsed, id = c("hour", "phase"))

  
  # order the factors and clean up names
  df_parsed$phase <- factor(df_parsed$phase,
                               levels=c("ana", "anx", "aer"))
  
  df_parsed$variable <- factor(df_parsed$variable,
                               levels=c("OP_mgPL","NO2_mgNL","NO3_mgNL",
                                        "Ace_mgCODL","Pr_mgCODL","Glu_mgCODL"))
  
  df_parsed$variable <- recode_factor(df_parsed$variable,
                                      OP_mgPL = "phosphate", NO2_mgNL = "nitrite", NO3_mgNL = "nitrate", 
                                      Ace_mgCODL = "acetate", Pr_mgCODL = "propionate", Glu_mgCODL = "glucose")
  
  return (df_parsed)
  
}


## debug zone ---

# file_path <- "C:/Users/mckyf/Northwestern University/Wells Research Group - CANDO+P Reactor/04 Performance data/cycle_results_2023.xlsx"
# choose_date <- "2023-03-13"
# cycle_parse(file_path, choose_date)



