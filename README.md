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

## Variable exploration & descriptive statistics

``` r
Explore.df.1 <- LDE.Explore(df.1,keyNamesMatch)                   #With LDE.AutoProcess(df,c("key","id,"code")) You can  tell LargeDataExplorer to assign variables that start or end with "key", "id" and "code" as key type. Null to ignore.
View(Explore.df.1$df.num)                                         #View the descriptive statistics for numeric variables. You can also see $df.levels, $df.category,
```
LDE.Explore() classifies variables of a data.frame by type (bool, categorical, text, numeric, key, etc). Descriptive statistics are generated for each variable.

<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Explore.png" width="200">

## Retrieving useful variables for analytics

``` r
maxNARate <- 0.2                                                  #Values between 0-1. It can be set as null if you don't want to filter by NAs
Usefulness.df.1 <- LDE.UsefulVars(maxNARate,Explore.df.1)         #Each Explore.df is an LDE.Explore() Object. You can use 1 or as many as you want E.g. LDE.UsefulVars(maxNARate,Explore.df.1,Explore.df.2,Explore.df.3).  Null to ignore.

print(Usefulness.df.1$statistics)                                 #See statistics of included and excluded variables
print(Usefulness.df.1f$var.status)                                #See whether the variables were excluded or not
print(Usefulness.df.1$var.classif)                                #Show how the variables were clasiffied and why excluded variables were excluded
```
LDE.UsefulVars() classifies variables by its type and usefulness for analytics (E.g. Na-only, 1-value only, plain text types are not useful). It also includes descriptive statistics for each included and excluded variable


## Automatical exploration, variable filtering & re-formatting

``` r
Auto.1.df <- LDE.AutoProcess(df)                                  #With LDE.AutoProcess(df,c("key","id,"code")) You can  tell LargeDataExplorer to assign variables that start or end with "key", "id" and "code" as key type
df.clean <- Auto.1.df$df.filtered                                 #Retrieve the cleaned dataset
```
LDE.AutoProcess() automatically performs LDE.Explore() and then LDE.UsefulVars(), finally returns the transformed dataset, excluding the unuseful variables, and the $statistics $var.status and $var.classif of LDE.UsefulVars()

<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/AutoProcess.png" width="200">

## More information?
- [Large Data Explorer Full Information](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)
- Example dataset used: "SECOP 2", https://www.colombiacompra.gov.co/

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

