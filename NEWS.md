# CVrisk 1.1.0

Improve risk score calculation performance for large datasets.  Contribution by 
@hhubbell

Add other race in ACC/AHA 2013 ASCVD risk score.  Other race have same risk as 
White race as used in the official online calculator. See #2.

Added two additional risk scores: 
- MESA 2015 10-year ASCVD risk (traditional risk factors)
- MESA 2015 10-year ASCVD risk (using coronary artery calcium)

Out of range or missing inputs now return NA instead of erroring out

# CVrisk 1.0.0

Initial CRAN release.
