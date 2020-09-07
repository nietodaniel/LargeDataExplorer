<!-- badges: start -->
[![Travis build status](https://travis-ci.org/nietodaniel/LargeDataExplorer.svg?branch=master)](https://travis-ci.org/nietodaniel/LargeDataExplorer)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/nietodaniel/LargeDataExplorer?branch=master&svg=true)](https://ci.appveyor.com/project/nietodaniel/LargeDataExplorer)
[![Coverage status](https://codecov.io/gh/nietodaniel/LargeDataExplorer/branch/master/graph/badge.svg)](https://codecov.io/github/nietodaniel/LargeDataExplorer?branch=master)
<!-- badges: end -->

# LargeDataExplorer

Fast and powerful package for preliminary exploration of large datasets

## Installation & Loading

``` r
# install.packages("devtools")
library(devtools)
devtools::install_github("nietodaniel/LargeDataExplorer")
library(LargeDataExplorer)
```

## Features

### LDE.AutoProcess(): Automatically explore, Filter relevant variables & Transform data.frame

Exploring, filtering and transforming, just with 2 lines of code [More Info](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#AutoProcess)
``` r
Expl<-LDE.AutoProcess(df)
df.clean<-Expl$df.filtered #data.frame with only the useful variables

print(Expl$var.classif) #How the variables were clasiffied
```

![LDE.AutoProcess()](/images/AutoProcess.png)
Format: ![Alt Text](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#AutoProcess)



### LDE.Explore(): Preliminary Exploration of data.frame

Preliminary exploration and calculation of descriptive statistics [More Info](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#Explore)
``` r
Expl<-LDE.Explore(df)

#Descriptive statistics for each variable type
View(Expl$df.primarykeys) #Variables that have a different value for each non-NA row
View(Expl$df.keys) #Variables which could be keys
View(Expl$df.num) #Numeric variables
View(Expl$df.bool) #Categorical variables that have only two values (E.g. 0 & 1, or "Red" & "Blue")
View(Expl$df.levels) #Categorical (numerical) variables (If ordinal, they don't have to be transformed)
View(Expl$df.category) #Categorical (text) variables (Must be converted with One-Hot Encoding)
View(Expl$df.onevalue) #Variables that have only 1 value in all its non-NA rows
View(Expl$df.NA) #Empty variables that only contain NAs
View(Expl$df.text) #Plain text variables that contain too much categories to be considered categorical
View(Expl$df.repeatedVars) #Numeric/Categorical variables that hold duplicated information, thus can be removed
```

![LDE.Explore()](/images/Explore.png)
Format: ![Alt Text](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#Explore)



### LDE.UsefulVars(): Filtering of the useful variables

Selecting the useful variables: Booleans, numeric, categorical and primary keys [More Info](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#UsefulVars)
``` r
Expl1<-LDE.Explore(df.1)
Expl2<-LDE.Explore(df.2)
maxNARate<-0.2
useful.vars<-LDE.UsefulVars(maxNARate,Expl1,Expl2) #You can add only 1 Expl or as many as you want

included.vars.df.1<-useful.vars$useful.varnames$df.1 #Getting the useful varnames for df.1
df.1<-df.1[ , (names(df.1) %in% included.vars.df.1)] #Selecting only the useful variables
```

![LDE.UsefulVars()](/images/UsefulVars.png)
Format: ![Alt Text](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#UsefulVars)



## More information?

- [Large Data Explorer Information](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

