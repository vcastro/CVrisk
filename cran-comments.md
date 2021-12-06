# Review 1 - 2021-12-06

>   Found the following (possibly) invalid URLs: URL: https://codecov.io/vcastro/CVrisk?branch=master (moved to https://app.codecov.io/vcastro/CVrisk?branch=master)        
> From: README.md
>       Status: 301
>       Message: Moved Permanently


Updated link in the README file 


## R CMD check results
There were no errors, warnings or notes.

0 errors v | 0 warnings v | 0 notes v


## Test environments

* macOS 11.6.1 (on github actions), R 4.1.2
* ubuntu 20.04 (release) (on github actions), R 4.1.2
* ubuntu 20.04 (dev) (on github actions), R 4.1.2
* Windows 10.0.17763 (on github actions), R 4.1.2


## Downstream dependencies

There are currently no downstream dependencies for this package


# Previous CRAN Comments

## Test environments
* Windows local R installation, R 4.0.3
* macOS 10.15.7 (on github actions), R 4.0.3
* ubuntu 20.04 (release) (on github actions), R 4.0.3
* ubuntu 20.04 (dev) (on github actions), R 4.0.3
* Windows 10.0.17763 (on github actions), R 4.0.3

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Downstream dependencies

There are currently no downstream dependencies for this package


### Review 1 - 2020-10-19

> Both "+ file LICENSE" in the declaration and the file are not needed and should be omitted unless there are attribution requirements.

Removed LICENSE file.  There are no specific attribution requirements.

>Is there some reference about the method you can add in the Description 
field in the form Authors (year) <doi:.....>?

Changed the Description from:

"Calculate cardiovascular risk scores, including the ACC/AHA ASCVD score."

to:

"Calculate various cardiovascular disease risk scores from the
    Framingham Heart Study (FHS), the American College of Cardiology (ACC),
    and the American Heart Association (AHA) as described in D’agostino, et al
    (2008) <doi:10.1161/circulationaha.107.699579>, Goff, et al (2013)
    <doi:10.1161/01.cir.0000437741.48606.98>, and Mclelland, et al (2015)
    <doi:10.1016/j.jacc.2015.08.035>"


Thank you for the review!