<!-- badges: start -->
[![Travis build status](https://travis-ci.org/nietodaniel/LargeDataExplorer.svg?branch=master)](https://travis-ci.org/nietodaniel/LargeDataExplorer)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/nietodaniel/LargeDataExplorer?branch=master&svg=true)](https://ci.appveyor.com/project/nietodaniel/LargeDataExplorer)
[![Coverage status](https://codecov.io/gh/nietodaniel/LargeDataExplorer/branch/master/graph/badge.svg)](https://codecov.io/github/nietodaniel/LargeDataExplorer?branch=master)
<!-- badges: end -->

# LargeDataExplorer

Fast and powerful package for preliminary exploration of large datasets.
[(Full Package Information)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)

## Installation & Loading

``` r
# install.packages("devtools")
library(devtools)
devtools::install_github("nietodaniel/LargeDataExplorer")
library(LargeDataExplorer)
```

## Variable exploration & classification, and descriptive statistics

LDE.Explore() classifies variables of a data.frame by type (bool, categorical, text, numeric, key, etc) and assess whether variables are useful or not for analytics (E.g. Na-only, 1-value only, plain text types are not useful) and if there's a NA threshold that should be reason of exclusion. Descriptive statistics are generated for each variable.

``` r
df<-secop1.full                                                                            #secop1.full and secop1.multas are example datasets of government purchases included in this package. See full package info

keyNamesMatch <- c("key","id")                                                             #Variable names that start or end with these strings will be asigned as keys. E.g. c("key","id,"code"). String vector, or NULL to ignore.
Explore.df <- LDE.Explore(df,keyNamesMatch)                                                #To set a NA limit. You can use LDE.Explore(df,keyNamesMatch,maxNARate). Numeric values between 0-1 are permited
```
  Explore.df$statistics      |  Explore.df$var.status    |  Explore.df$classif
:---------------------------:|:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Explore.png" width="200">   |  <img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Status.png" width="200">   |  <img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Classif.png" width="200">

## Automatical exploration, variable filtering & re-formatting

LDE.AutoProcess() automatically fixes the variable types and excludes variables based on the criteria of LDE.Explore()

``` r
df<-secop1.full   
Auto.df <- LDE.AutoProcess(df)                                                             #You can use LDE.Explore(df.1,maxNARate,keyNamesMatch). See full package info
df.clean <- Auto.df$df.filtered                                           
```
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/AutoProcess.png" width="200">

## More
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

