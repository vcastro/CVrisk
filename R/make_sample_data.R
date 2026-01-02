#' Generate sample cardiovascular risk data
#'
#' Creates a data frame with randomly generated patient data suitable for testing
#' cardiovascular risk calculations. The function generates realistic ranges for
#' all standard cardiovascular risk factors.
#'
#' @param n Number of rows to generate (default: 100)
#'
#' @return A data frame with \code{n} rows and the following columns:
#' \describe{
#'   \item{id}{Sequential patient identifier (1 to n)}
#'   \item{age}{Patient age in years (30-79)}
#'   \item{sex}{Patient sex ("female" or "male")}
#'   \item{sbp}{Systolic blood pressure in mm Hg (90-200)}
#'   \item{bp_med}{Blood pressure medication status (TRUE/FALSE)}
#'   \item{totchol}{Total cholesterol in mg/dL (130-320)}
#'   \item{hdl}{HDL cholesterol in mg/dL (20-100)}
#'   \item{lipid_med}{Lipid medication status (TRUE/FALSE)}
#'   \item{diabetes}{Diabetes status (TRUE/FALSE)}
#'   \item{smoker}{Smoking status (TRUE/FALSE)}
#'   \item{egfr}{Estimated glomerular filtration rate in mL/min/1.73m2 (15-140)}
#'   \item{bmi}{Body mass index in kg/m2 (18.5-49.9)}
#'   \item{hba1c}{Hemoglobin A1c percentage (4.5-15.0 or NA)}
#'   \item{uacr}{Urine albumin-to-creatinine ratio in mg/g (0.1-25000 or NA)}
#'   \item{zip}{ZIP code (30 valid codes or NA)}
#' }
#'
#' @export
#'
#' @examples
#' library(CVrisk)
#' # Generate default 100 rows
#' sample_data <- make_sample_data()
#'
#' # Generate 50 rows
#' sample_data_50 <- make_sample_data(n = 50)
#'
#' # Use with compute_CVrisk (add race column as needed)
#' \dontrun{
#' data <- make_sample_data(n = 10)
#' data$race <- "white"  # Add race column
#' result <- compute_CVrisk(
#'   data,
#'   scores = "ascvd_10y_accaha",
#'   age = "age",
#'   gender = "sex",
#'   race = "race",
#'   sbp = "sbp",
#'   totchol = "totchol",
#'   hdl = "hdl",
#'   bp_med = "bp_med",
#'   smoker = "smoker",
#'   diabetes = "diabetes"
#' )
#' }
make_sample_data <- function(n = 100) {
  
  valid_zips <- 
    c("27844","76201","24630","48821","89146","84631","23950","56552","14174", 
      "63454","53965","50561","27320","86336","00976","96744","55805","32548", 
      "12959","12138","77057","68118","07940","28579","26291","72601","48228",
      "11719","76667","02129")
    
  data.frame(
    id = seq_len(n),
    age = sample(30:79, n, replace = TRUE),
    sex = sample(c("female", "male"), n, replace = TRUE),
    sbp = sample(90:200, n, replace = TRUE),
    bp_med = sample(c(TRUE, FALSE), n, replace = TRUE),
    totchol = sample(130:320, n, replace = TRUE),
    hdl = sample(20:100, n, replace = TRUE),
    lipid_med = sample(c(TRUE, FALSE), n, replace = TRUE),
    diabetes = sample(c(TRUE, FALSE), n, replace = TRUE),
    smoker = sample(c(TRUE, FALSE), n, replace = TRUE),
    egfr = sample(15:140, n, replace = TRUE),
    bmi = sample(seq(18.5, 49.9, 0.1), n, replace = TRUE),
    hba1c = sample(
      # Sampling to give HbA1c and NA_real_ an
      # equal chance of being recorded for the sampled data
      c(
        seq(4.5, 15, 0.1), 
        rep(NA_real_, length(seq(4.5, 15, 0.1)))
      ), 
      n, 
      replace = TRUE
    ),
    uacr = sample(
      c(
        seq(0.1, 25000, 0.1), 
        rep(NA_real_, length(seq(0.1, 25000, 0.1)))
      ), 
      n, 
      replace = TRUE
    ),
    zip = sample(
      c(
        valid_zips, 
        rep(NA_character_, length(valid_zips))
      ), 
      n, 
      replace = TRUE
    )
  )

}
