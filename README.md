<!-- badges: start -->
[![Travis build status](https://travis-ci.org/nietodaniel/LargeDataExplorer.svg?branch=master)](https://travis-ci.org/nietodaniel/LargeDataExplorer)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/nietodaniel/LargeDataExplorer?branch=master&svg=true)](https://ci.appveyor.com/project/nietodaniel/LargeDataExplorer)
[![Coverage status](https://codecov.io/gh/nietodaniel/LargeDataExplorer/branch/master/graph/badge.svg)](https://codecov.io/github/nietodaniel/LargeDataExplorer?branch=master)
<!-- badges: end -->

# LargeDataExplorer

Powerful package to clean and re-format very large datasets after classifying its variables by their usefulness for machine learning.
[(Full Package Information)](http://www.digitalmedtools.com/Freeware/LargeDataExplorer)

*Because summary() isn't enough when you have >200 columns and even GBs of data, and you can't easily know which variables have no relevant information*

## Installation & Loading
``` r
# install.packages("devtools")
library(devtools)
devtools::install_github("nietodaniel/LargeDataExplorer")
library(LargeDataExplorer)
```
## Detected variable types

LargeDataExplorer can automatically can automatically classify the variables of a dataset within the following categories:

  Relevant Data Vars         | Relevant Information Vars | Unuseful Vars (To exclude)
:---------------------------:|:-------------------------:|:--------------------------:
<ul><li>Numeric</li></ul> | <ul><li>Primary keys</li></ul> | <ul><li>NAs</li></ul>
<ul><li>Boolean</li></ul> | <ul><li>Keys and Ids</li></ul> | <ul><li>Uni-value</li></ul>
<ul><li>Categoric (Numeric)</li></ul> | <ul><li>Dates</li></ul> | <ul><li>Text</li></ul>
<ul><li>Categoric (Text)</li></ul> | | <li>Repeated information</li></ul>
 
 
## Variable exploration & classification, and descriptive statistics

LDE.Explore() classifies the variables by its type and usefulness. It generates descriptive statistics, but doesn't transform the data. Useful for datasets of gygabytes, where the RAM is limited
``` r
df<-secop1.full                                                                          #Example dataset of government purchases included in this package. See full package info
keyNamesMatch <- c("key","id")                                                           #Variable names that start or end with these strings will be asigned as keys. E.g. c("key","id,"code"). String vector, or NULL to ignore.
Explore.df <- LDE.Explore(df,keyNamesMatch)                                                
```
  Explore.df$statistics      |  Explore.df$var.status    |  Explore.df$classif
:---------------------------:|:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Explore.png" width="200">   |  <img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Status.png" width="200">   |  <img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/Classif.png" width="200">


## Automatical exploration, variable filtering & re-formatting

LDE.AutoProcess() returns a cleaned and reformatted dataset after removing unuseful varibles (It also returns statistics and classification)

``` r
df<-secop1.full   
keyNamesMatch <- c("key","id")                                                           #See LDE.Explore()
Auto.df <- LDE.AutoProcess(df,keyNamesMatch)                                               
df.clean <- Auto.df$df.filtered                                                          #Cleaned dataset
```
<img src="https://raw.githubusercontent.com/nietodaniel/LargeDataExplorer/master/images/AutoProcess.png" width="200">


## More
- [More Free packages and apps](http://www.digitalmedtools.com/Freeware)
- [Digital MedTools: Software & Services for Biomedic Researchers](http://www.digitalmedtools.com)

## Author

**Daniel Nieto-González** - [GitHub Profile](https://github.com/nietodaniel) - [Send email](mailto:nieto.daniel221@gmail.com)
* CEO - [Digital MedTools](Http://www.digitalmedtools.com) 

