#' AHA/ACC PREVENT 2023 10-year ASCVD risk model coefficients (lipid-based)
#'
#' Coefficients for computing 10-year ASCVD risk using the PREVENT equations
#' with lipid measurements.
#'
#' @format A data frame with 2 rows and 12 variables:
#' \describe{
#'   \item{gender}{patient gender (male, female)}
#'   \item{ln_age}{coefficient for log(age)}
#'   \item{ln_totchol}{coefficient for log(total cholesterol)}
#'   \item{ln_hdl}{coefficient for log(HDL cholesterol)}
#'   \item{ln_sbp}{coefficient for log(systolic blood pressure)}
#'   \item{bp_med}{coefficient for blood pressure medication}
#'   \item{diabetes}{coefficient for diabetes}
#'   \item{smoker}{coefficient for current smoking}
#'   \item{egfr}{coefficient for estimated glomerular filtration rate}
#'   \item{uacr}{coefficient for urine albumin-to-creatinine ratio}
#'   \item{group_mean}{group mean}
#'   \item{baseline_survival}{baseline survival}
#' }
#' @source Khan SS, Matsushita K, Sang Y, et al. Development and Validation of
#' the American Heart Association's PREVENT Equations. Circulation.
#' 2024;149(6):430-449. doi:10.1161/CIRCULATIONAHA.123.067626
"prevent_10y_coef"

#' AHA/ACC PREVENT 2023 10-year ASCVD risk model coefficients (BMI-based)
#'
#' Coefficients for computing 10-year ASCVD risk using the PREVENT equations
#' with BMI instead of lipid measurements.
#'
#' @format A data frame with 2 rows and 11 variables:
#' \describe{
#'   \item{gender}{patient gender (male, female)}
#'   \item{ln_age}{coefficient for log(age)}
#'   \item{ln_bmi}{coefficient for log(BMI)}
#'   \item{ln_sbp}{coefficient for log(systolic blood pressure)}
#'   \item{bp_med}{coefficient for blood pressure medication}
#'   \item{diabetes}{coefficient for diabetes}
#'   \item{smoker}{coefficient for current smoking}
#'   \item{egfr}{coefficient for estimated glomerular filtration rate}
#'   \item{uacr}{coefficient for urine albumin-to-creatinine ratio}
#'   \item{group_mean}{group mean}
#'   \item{baseline_survival}{baseline survival}
#' }
#' @source Khan SS, Matsushita K, Sang Y, et al. Development and Validation of
#' the American Heart Association's PREVENT Equations. Circulation.
#' 2024;149(6):430-449. doi:10.1161/CIRCULATIONAHA.123.067626
"prevent_10y_bmi_coef"

#' AHA/ACC PREVENT 2023 30-year ASCVD risk model coefficients (lipid-based)
#'
#' Coefficients for computing 30-year ASCVD risk using the PREVENT equations
#' with lipid measurements.
#'
#' @format A data frame with 2 rows and 12 variables:
#' \describe{
#'   \item{gender}{patient gender (male, female)}
#'   \item{ln_age}{coefficient for log(age)}
#'   \item{ln_totchol}{coefficient for log(total cholesterol)}
#'   \item{ln_hdl}{coefficient for log(HDL cholesterol)}
#'   \item{ln_sbp}{coefficient for log(systolic blood pressure)}
#'   \item{bp_med}{coefficient for blood pressure medication}
#'   \item{diabetes}{coefficient for diabetes}
#'   \item{smoker}{coefficient for current smoking}
#'   \item{egfr}{coefficient for estimated glomerular filtration rate}
#'   \item{uacr}{coefficient for urine albumin-to-creatinine ratio}
#'   \item{group_mean}{group mean}
#'   \item{baseline_survival}{baseline survival}
#' }
#' @source Khan SS, Matsushita K, Sang Y, et al. Development and Validation of
#' the American Heart Association's PREVENT Equations. Circulation.
#' 2024;149(6):430-449. doi:10.1161/CIRCULATIONAHA.123.067626
"prevent_30y_coef"

#' AHA/ACC PREVENT 2023 30-year ASCVD risk model coefficients (BMI-based)
#'
#' Coefficients for computing 30-year ASCVD risk using the PREVENT equations
#' with BMI instead of lipid measurements.
#'
#' @format A data frame with 2 rows and 11 variables:
#' \describe{
#'   \item{gender}{patient gender (male, female)}
#'   \item{ln_age}{coefficient for log(age)}
#'   \item{ln_bmi}{coefficient for log(BMI)}
#'   \item{ln_sbp}{coefficient for log(systolic blood pressure)}
#'   \item{bp_med}{coefficient for blood pressure medication}
#'   \item{diabetes}{coefficient for diabetes}
#'   \item{smoker}{coefficient for current smoking}
#'   \item{egfr}{coefficient for estimated glomerular filtration rate}
#'   \item{uacr}{coefficient for urine albumin-to-creatinine ratio}
#'   \item{group_mean}{group mean}
#'   \item{baseline_survival}{baseline survival}
#' }
#' @source Khan SS, Matsushita K, Sang Y, et al. Development and Validation of
#' the American Heart Association's PREVENT Equations. Circulation.
#' 2024;149(6):430-449. doi:10.1161/CIRCULATIONAHA.123.067626
"prevent_30y_bmi_coef"
