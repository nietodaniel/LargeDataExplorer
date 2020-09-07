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

### Automatically explore, Filter relevant variables & Transform data.frame

LDE.AutoProcess(): Exploring, filtering and transforming, with a few lines of code [(More Info)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#AutoProcess)
``` r
Expl<-LDE.AutoProcess(df)
print(Expl$var.classif) #How the variables were clasiffied

df.clean<-Expl$df.filtered #Filtered dataset
```
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/AutoProcess.png" width="700">



### Preliminary Exploration of data.frame

LDE.Explore(): Preliminary exploration and calculation of descriptive statistics [(More Info)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#Explore)
``` r
Expl<-LDE.Explore(df)
View(Expl$df.num) #View numeric variables statistics

# You can also see Expl$df.bool, Expl$df.levels, Expl$df.category, Expl$df.onevalue, Expl$df.NA, 
#   Expl$df.text, Expl$df.repeatedVars 
```
Example of View(Expl$df.num)
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Explore.png" width="700">



### Filtering of the useful variables

LDE.UsefulVars(): Selecting the useful variables: Booleans, numeric, categorical and primary keys [(More Info)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#UsefulVars)
``` r
Expl1<-LDE.Explore(df.1)
maxNARate<-0.2
UsefulVarsObject<-LDE.UsefulVars(maxNARate,Expl1) #You can add only 1 Expl Object or as many as you want

varsToInclude<-UsefulVarsObject$useful.varnames$df.1 #useful variable names for df.1
```

## More information?
- [Large Data Explorer Information](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)
- Example Dataset used: https://www.colombiacompra.gov.co/transparencia/conjuntos-de-datos-abiertos

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

