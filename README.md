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


### Automatically exploration of a dataset, exclusion of unuseful variables & transformation of variable types

``` r
LDEAuto <- LDE.AutoProcess(df)     
print(LDEAuto$var.classif)             #Show how the variables were clasiffied
df.clean <- LDEAuto$df.filtered        #Retrieve the filtered dataset
```
LDE.AutoProcess(): Removes unuseful variables types: NA-only, 1-value-only, plain text and variables with reapeated information. [(More Info)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#AutoProcess) *Click the image to expand it*
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/AutoProcess.png" width="300">



### Preliminary Exploration of dataset with descriptive statistics

``` r
LDEExplore <- LDE.Explore(df)
View(LDEExplore$df.num)                #View the descriptive statistics
```
LDE.Explore(): Classifies variables as bool, categorical, categorical (numeric), numeric, primary key, etc. [(More Info)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#Explore)  *Click the image to expand it*
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Explore.png" width="300">



### Filtering which variables might be useful

``` r
LDEExplore <- LDE.Explore(df.1)                              #An LDE Exploration must be performed first
maxNARate = 0.2                                              #Values between 0-1
LDEUsefulVars <- LDE.UsefulVars(maxNARate,LDEExplore)        #You can 1 LDEExplore Objects or as many as you want
varsToInclude<-LDEUsefulVars$useful.varnames$df.1            #Retrieve a string vector with the useful variable names for df.1
```
LDE.UsefulVars(): Identifies variables with unuseful information (Na-only, 1-value only, etc.)  [(More Info)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer#UsefulVars)

## More information?
- [Large Data Explorer Information](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)
- Example Dataset used: "SECOP 2", https://www.colombiacompra.gov.co/

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

