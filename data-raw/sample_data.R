library(tibble)

sample_data <- as.data.frame(tribble(~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, ~diabetes,
                                  55, "male", "white", 30, 140, 50, 213, 0, 0, 0, 
                                  45, "female",  "white",27, 125, 50, 200, 1, 0, 0, 
                                  45, "female",  "white",27, 125, 50, 200, NA, 0, 0))

usethis::use_data(sample_data, overwrite = TRUE)