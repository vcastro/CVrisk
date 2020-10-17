#' Compute multiple CV risk scores
#'
#' @param df input dataframe
#' @param scores which scores to compute
#' @param age patient age in years
#' @param gender patient gender (male or female)
#' @param race patient race
#' @param sbp character string of systolic blood pressure (in mm Hg) column
#' @param bmi string of bmi column
#' @param hdl string of hdl column
#' @param totchol string of totchol column
#' @param bp_med string of bp_med column
#' @param smoker string of smoker column
#' @param diabetes string of diabetes column
#'
#' @return input data frame with risk score results appended as columns
#'
#' @examples
#'
#' library(CVrisk)
#' compute_CVrisk(sample_data,
#'   age = "age", race = "race", gender = "gender", bmi = "BMI", sbp = "sbp",
#'   hdl = "hdl", totchol = "totchol", bp_med = "bp_med", smoker = "smoker",
#'   diabetes = "diabetes"
#' )
#' @export
compute_CVrisk <- function(df, scores = c(
                             "ascvd_10y_accaha", "ascvd_10y_frs",
                             "ascvd_10y_frs_simple"
                           ),
                           age, gender, race, sbp = NULL, bmi = NULL,
                           hdl = NULL, totchol = NULL,
                           bp_med = NULL, smoker = NULL, diabetes = NULL) {
  all_args <- as.list(environment())
  valid_pred <- c(
    "age", "gender", "race", "sbp", "bmi", "hdl", "totchol",
    "bp_med", "smoker", "diabetes"
  )

  pred_args <- list()
  for (var in valid_pred) {
    if (!is.null(all_args[[var]])) pred_args[[var]] <- df[[all_args[[var]]]]
  }


  results <- sapply(scores, function(x) do.call(Vectorize(x), pred_args))

  row.names(results) <- NULL
  return(cbind(df, results))
}
