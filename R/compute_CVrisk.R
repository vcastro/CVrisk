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
#' @param lipid_med character string of lipid medication column (used as statin if statin not provided)
#' @param statin character string of statin medication column (takes precedence over lipid_med)
#' @param egfr character string of estimated glomerular filtration rate column
#' @param fh_heartattack character string of fh of heart attack status column
#' @param cac character string of cac column
#'
#' @return input data frame with risk score results appended as columns
#'
#' @examples
#'
#' library(CVrisk)
#' # Compute traditional risk scores (excluding PREVENT which requires egfr)
#' compute_CVrisk(sample_data,
#'   scores = c("ascvd_10y_accaha", "ascvd_10y_frs", "ascvd_10y_frs_simple",
#'              "chd_10y_mesa", "chd_10y_mesa_cac"),
#'   age = "age", race = "race", gender = "gender", bmi = "BMI", sbp = "sbp",
#'   hdl = "hdl", totchol = "totchol", bp_med = "bp_med", smoker = "smoker",
#'   diabetes = "diabetes", lipid_med = "lipid_med",
#'   fh_heartattack = "fh_heartattack", cac = "cac"
#' )
#' @export
compute_CVrisk <- function(df, scores = c(
                             "ascvd_10y_accaha",
                             "ascvd_10y_frs", "ascvd_10y_frs_simple",
                             "chd_10y_mesa",
                             "chd_10y_mesa_cac"
                           ),
                           age, gender, race, sbp = NULL, bmi = NULL,
                           hdl = NULL, totchol = NULL,
                           bp_med = NULL, smoker = NULL, diabetes = NULL,
                           lipid_med = NULL, statin = NULL, egfr = NULL,
                           fh_heartattack = NULL,
                           cac = NULL) {
  all_args <- as.list(environment())
  valid_pred <- c(
    "age", "gender", "race", "sbp", "bmi", "hdl", "totchol",
    "bp_med", "smoker", "diabetes", "lipid_med", "statin", "egfr",
    "fh_heartattack", "cac"
  )

  pred_args <- list()
  for (var in valid_pred) {
    if (!is.null(all_args[[var]])) pred_args[[var]] <- df[[all_args[[var]]]]
  }
  
  # If statin is not provided but lipid_med is, use lipid_med as statin
  if (is.null(pred_args[["statin"]]) && !is.null(pred_args[["lipid_med"]])) {
    pred_args[["statin"]] <- pred_args[["lipid_med"]]
  }


  results <- sapply(scores, function(x) do.call(x, pred_args), simplify = FALSE)
  results <- as.data.frame(results)

  return(cbind(df, results))
}
