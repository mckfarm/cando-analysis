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


## debug zone ---


