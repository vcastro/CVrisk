library(tibble)

sample_data <- as.data.frame(tribble(
  ~age, ~gender, ~race, ~BMI, ~sbp, ~hdl, ~totchol, ~bp_med, ~smoker, 
      ~diabetes, ~lipid_med, ~fh_heartattack, ~cac,
  55, "male", "white", 30, 140, 50, NA, 0, 0, 0, 0, 0, NA,
  45, "female", "white", 27, 125, 50, 200, 1, 0, 0, 0, 0, 0,
  45, "female", "white", 27, 125, 50, 200, NA, 0, 0, 0, 0, NA,
  70, "male", "hispanic", NA, 140, 50, 190, 1, 0, 0, 0, 0, NA,
  70, "male", "hispanic", NA, 140, 50, 190, 1, 0, 0, 0, 0, 0,
  80, "female", "chinese", NA, 140, 50, 190, 1, 0, 0, 0, 0, 0,
  60, "male", "aa", 29, 140, 50, 190, 1, 0, 0, 0, 0, 50,
))

usethis::use_data(sample_data, overwrite = TRUE)
