# Changelog

## CVrisk 1.2.0

Added PREVENT 10-year ASCVD risk equations (via preventr) \[#14\]

## CVrisk 1.1.1

CRAN release: 2023-08-19

Update package documentation to proper CVrisk-package sentinel file.

## CVrisk 1.1.0

CRAN release: 2021-12-06

Improve risk score calculation performance for large datasets.
Contribution by [@hhubbell](https://github.com/hhubbell)

Add other race in ACC/AHA 2013 ASCVD risk score. Other race have same
risk as White race as used in the official online calculator. See
[\#2](https://github.com/vcastro/CVrisk/issues/2).

Added two additional risk scores: - MESA 2015 10-year ASCVD risk
(traditional risk factors) - MESA 2015 10-year ASCVD risk (using
coronary artery calcium)

Out of range or missing inputs now return NA instead of erroring out

## CVrisk 1.0.0

CRAN release: 2020-10-27

Initial CRAN release.
