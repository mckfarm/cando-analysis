## ---------------------------
## plotting params for CANDO+P
## ---------------------------

library(ggplot2)
library(dplyr)

theme_defaults <- list(
  theme_classic(),
  theme(legend.position="top", plot.title = element_text(face = "bold")))


# variable dictionary
## this is actually a df since R doesnt natively support dicts
## make ggplot custom colors/shapes on the fly

palette_df <- tibble(vars = c("phosphate", "nitrite", "nitrate", "acetate", "propionate", "glucose"),
                     labels = c("Phosphate", "Nitrite", "Nitrate", "Acetate", "Propionate", "Glucose"),
                     shapes = c(16, 17, 18, 21, 22, 25),
                     colors = c("#92A36A", "#D27A37", "#E1A77A", "#EB99B8", "#AA2256", "#52298E"),
                     fill = c("#92A36A", "#D27A37", "#E1A77A", "grey", "grey", "grey"))

