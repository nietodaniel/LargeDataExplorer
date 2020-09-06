<!-- badges: start -->
[![Travis build status](https://travis-ci.org/nietodaniel/LargeDataExplorer.svg?branch=master)](https://travis-ci.org/nietodaniel/LargeDataExplorer)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/nietodaniel/LargeDataExplorer?branch=master&svg=true)](https://ci.appveyor.com/project/nietodaniel/LargeDataExplorer)
[![Coverage status](https://codecov.io/gh/nietodaniel/LargeDataExplorer/branch/master/graph/badge.svg)](https://codecov.io/github/nietodaniel/LargeDataExplorer?branch=master)
<!-- badges: end -->

# LargeDataExplorer

Fast and powerful package for preliminary exploration of large datasets

## Installation & Load

``` r
# install.packages("devtools")
devtools::install_github("nietodaniel/LargeDataExplorer")
library(LargeDataExplorer)
```

## Features

### LDE.AutoProcess(): Automatically explore, Filter relevant variables & Transform data.frame

Exploring, filtering and transforming, just with 2 lines of code
``` r
Expl<-LDE.AutoProcess(df)
df.clean<-Expl$df.filtered #data.frame with only the useful variables
```

Viewing the information of the exploring and filtering process
``` r
#Process information
Expl$process.info$Exploration #See LDE.Explore()
Expl$process.info$UsefulVars #See LDE.Explore()
```

### LDE.Explore(): Preliminary Exploration of data.frame

Performing the exploration
``` r
Expl<-LDE.Explore(df)
```

Viewing the descriptive statistics (mean, min, max, median, sd, nlevels, e1071::skewness,etc.) for each variable type
``` r
View(Expl$df.primarykeys) #Variables that have a different value for each non-NA row
View(Expl$df.num) #Numeric variables
View(Expl$df.bool) #Categorical variables that have only two values (E.g. 0 & 1, or "Red" & "Blue")
View(Expl$df.levels) #Categorical (numerical) variables (If ordinal, they don't have to be transformed)
View(Expl$df.category) #Categorical (text) variables (Must be converted with One-Hot Encoding)
View(Expl$df.onevalue) #Variables that have only 1 value in all its non-NA rows
View(Expl$df.NA) #Empty variables that only contain NAs
View(Expl$df.text) #Plain text variables that contain too much categories to be considered categorical
View(Expl$df.repeatedVars) #Numeric/Categorical variables that hold duplicated information, thus can be removed
```

### LDE.UsefulVars(): Filtering of the useful variables

Selecting the useful variables: Booleans, numeric, categorical and primary keys
``` r
Expl1<-LDE.Explore(df.1)
Expl2<-LDE.Explore(df.2)
useful.vars<-LDE.UsefulVars(maxNARate,Expl1,Expl2) #You can add only 1 or as many as you want
```

Getting the useful varnames
``` r
included.vars.df.1<-useful.vars$useful.varnames$df.1
included.vars.df.2<-useful.vars$useful.varnames$df.2
```

Selecting only the useful variables in my dataset
``` r
df.1<-df.1[ , (names(df.1) %in% included.vars.df.1)]
df.2<-df.2[ , (names(df.2) %in% included.vars.df.2)]
```

Viewing the descriptive statistics for each selected variable in each useful variable type on all the datasets
``` r
View(useful.vars$df.num) #Same structure for other variable types
print(useful.vars$removed.varnames) #Removed Varnames for each dataset
```

## More information?

- [Large Data Explorer Information](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

