## ---------------------------
## max rate calculations
## ---------------------------

# use this script assuming you have an in-cycle plot with hour, phase, variable, and value columns 

# library(dplyr)

# this is assuming the max rate happens at the beginning of a phase
get_max_rate <- function(df, choose_phase, choose_variable, n_points, solids_df){
  
  # filter values
  df_select <- df %>%
    filter(phase == choose_phase) %>%
    filter(variable == choose_variable) %>%
    slice(1:n_points)

  lm_ana_phos <- lm(value ~ hour, data = df_select)
  
  max_rate <- abs(unname(coef(lm_ana_phos)["hour"]))
  
  # normalize rate if solids df is supplied, else return non-normalized rate
  
  if(missing(solids_df)) {
    return(max_rate)
  } else {
      max_norm_rate <- max_rate / filter(solids, sample == "ml")$TSS
      return(max_norm_rate)
  }
  
} 


# this is assuming the max rate happens at a different point of the phase, not just the beginning
get_max_rate_custom_range <- function(df, choose_phase, choose_variable, n_start, n_end, solids_df){
  
  # filter values
  df_select <- df %>%
    filter(phase == choose_phase) %>%
    filter(variable == choose_variable) %>%
    slice(n_start:n_end)
  
  lm_ana_phos <- lm(value ~ hour, data = df_select)
  
  max_rate <- abs(unname(coef(lm_ana_phos)["hour"]))
  
  # normalize rate if solids df is supplied, else return non-normalized rate
  
  if(missing(solids_df)) {
    return(max_rate)
  } else {
    max_norm_rate <- max_rate / filter(solids, sample == "ml")$TSS
    return(max_norm_rate)
  }
  
} 

# adds COD, N, P info to the rate df
append_rates_df <- function(rates_df, df, choose_date){
  rates_df$date <- choose_date
  rates_df$glucose <- df %>% filter(variable == "glucose" & hour == 0) %>% .$value
  rates_df$propionate <- df %>% filter(variable == "propionate" & hour == 0) %>% .$value
  rates_df$phosphate <- df %>% filter(variable == "phosphate" & hour == 0) %>% .$value
  rates_df$nitrite <- df %>% filter(variable == "nitrite" & phase == "anx") %>% slice(1) %>% .$value
  
  return(rates_df)
}

## debug zone ---


