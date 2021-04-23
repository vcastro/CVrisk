#' Compute multiple CV risk scores
#'
#' @param df input dataframe
#' @param scores scores to compute, default is all scores
#' @param age patient age in years (required for all scores)
#' @param gender patient gender (male or female)
#' @param race character string for patient race (white, aa, other) column
#' @param sbp character string of systolic blood pressure (in mm Hg) column
#' @param bmi character string of Body mass index (kg/m2) column
#' @param hdl character string of HDL column
#' @param totchol character string of total cholesterol column
#' @param bp_med character string of blood pressure medication column
#' @param smoker character string of smoking status column
#' @param diabetes character string of diabetes status column
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


  results <- sapply(scores, function(x) do.call(x, pred_args))

  row.names(results) <- NULL
  return(cbind(df, results))
}
