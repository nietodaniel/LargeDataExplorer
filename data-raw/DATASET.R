## code to prepare `DATASET` dataset goes here
library(readr)
secop1.full <- read_csv("data-raw/SECOP1.csv" )
secop1.multas <- read_csv("data-raw/multasSECOP1.csv" )

usethis::use_data(secop1.full, overwrite = TRUE)
usethis::use_data(secop1.multas, overwrite = TRUE)
