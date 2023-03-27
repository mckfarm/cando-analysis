## ---------------------------
## spreadsheet parsing script for CANDO+P data
## import into Rmd or use standalone
## ---------------------------

library(readxl)
library(lubridate)
library(reshape2)
library(dplyr)

cycle_parse <- function(file_path, choose_date){
  df <- read_excel(path = file_path, sheet = "data")
  
  df_parsed <- df %>% filter(date == ymd(choose_date)) %>%
    select(-c(date, time, phase, "NO2+NO3_mgNL")) %>%
    melt(id.vars=c("hour", "date_time")) %>%
    mutate(date_time = ymd_hms(date_time))
  
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
