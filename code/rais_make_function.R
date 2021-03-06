# need clean_rais function for this to work
# vector for states. This is needed to read in the different files
library(pacman)
p_load(dtplyr, data.table, ggplot2, janitor, stringr, lubridate, glue, tidyverse, parallel)

source("./code/rais_clean_function.R")

states <- c("centro05", "nordeste05", "norte05", "sp05", "sp105", "sudeste05", "sul05" )

base_dir <- "/media/dhidalgo/A610EA2D10EA03E1/rais/rais_original_files"


make_rais <- function(states, base_dir, size = 10000) {
  raw_data <-  fread(glue('{base_dir}/2005/{states}.TXT'),
                     nrows = size, colClasses=c("character"))

  cleaned_data <- clean_rais(raw_data)
}


rais_2005 <- map(states, ~ make_rais(states = .x, base_dir = base_dir, size = Inf)) %>%
  bind_rows()
