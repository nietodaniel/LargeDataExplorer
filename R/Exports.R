#' useful variables selection
#'
#' After performing LDE.Explore(), the output can be filtered to
#' obtain only the useful varibles and the variables names in a vector. A
#' max rate of NAs (0-1) can be set to filther further
#'
#' @param maxNARate numeric vector 0-1. Null to ignore
#' @param LDE.ExploreObject LDE.Explore() Object
#' @param ... LDE.Explore() Objects
#' @return A list containing the useful variables classified by its type with
#' their descriptive statistics and a vector containing the useful variable names
#' @export
#' @author Daniel Nieto
#' @examples
#' df.iris <- data.frame(iris)
#' df.cars <- data.frame(cars)
#' Explore.iris <- LDE.Explore(df.iris)
#' Explore.cars <- LDE.Explore(df.cars)
#' maxNARate <- 0.2 #All variables with more than 20% of NAs will be excluded
#' usefulVars <- LDE.UsefulVars(maxNARate,Explore.iris,Explore.cars)
#'
#' #Useful Variables --> usefulVars$varnames
#' str(usefulVars$varnames$df.iris) #Useful varnames of Iris dataset
#' str(usefulVars$varnames$df.cars) #Useful varnames of Cars dataset
#'
#' #View useful variables of each dataset and its characteristics
#' str(usefulVars$df.num) #Variables of numeric type
#' str(usefulVars$df.category) #Variables of categorical (text) type
#' str(usefulVars$df.bool) #Variables of bool type
#' str(usefulVars$df.levels) #Variables of categorical (numeric) type
#' str(usefulVars$df.primarykeys) #Variables which could be primary keys
#' str(usefulVars$df.keys) #Variables which could be keys
LDE.UsefulVars<-function(maxNARate=NULL,LDE.ExploreObject,...){
  if(is.null(LDE.ExploreObject)){
    stop("Error: LDE.ExploreObject is null")
  }
  return(core.UsefulVars(maxNARate,LDE.ExploreObject,...))
}

#' data.frame preliminar exploration
#'
#' classifies a data.frame variables by type (numeric, categorical, boolean,
#' text, etc.) and performs descriptive statistics for each (mean, min, max,
#' sd, skewness, etc).
#'
#' @param dat data.frame
#' @return A list containing the variables classified by its type and their
#' descriptive statistics
#' @export
#' @author Daniel Nieto
#' @examples
#' df <- data.frame(iris)
#' Explore.df <- LDE.Explore(df)
#'
#' #View which variables are of each type and its characteristics
#' str(Explore.df$df.text) #Variables of text type
#' str(Explore.df$df.num) #Variables of numeric type
#' str(Explore.df$df.NA) #Empty variables
#' str(Explore.df$df.univalue) #Variables with only one value
#' str(Explore.df$df.category) #Variables of categorical (text) type
#' str(Explore.df$df.levels) #Variables of categorical (numeric) type
#' str(Explore.df$df.bool) #Variables of bool type
#' str(Explore.df$df.primarykeys) #Variables which could be primary keys
#' str(Explore.df$df.keys) #Variables which could be keys
#' str(Explore.df$df.repeatedVars) #Variables with repeated information
LDE.Explore<-function(dat){
  if(is.null(dat)){
    stop("Error: data is null")
  }
  dataname=deparse(substitute(dat))
  return(core.ExploreDataset(dat,dataname))
}

#' data.frame automatic exploration, filtering and format transformation
#'
#' Automatically removes unuseful variables (Empty, plain text, one-value,
#' with repeated information) and variables with excess NAs.
#'
#' @param dat data.frame
#' @param maxNARate numeric vector 0-1. Null to ignore
#' @return The filtered dataset, with re-formatted variables and all the
#' process information including descriptive statistics
#' @export
#' @author Daniel Nieto
#' @examples
#' dat <- data.frame(iris)
#' maxNARate = 0.2
#' Exploration.dat <- LDE.AutoProcess(dat,maxNARate)
#'
#' #View all the process information
#' #Includes descriptive statistics for each variable
#' str(Exploration.dat$process.info)
#'
#' #Obtains clean dataset
#' dat.clean<-Exploration.dat$df.filtered
#' str(dat.clean)

LDE.AutoProcess<-function(dat,maxNARate=NULL){
  if(is.null(dat)){
    stop("Error: data is null")
  }
  dataname=deparse(substitute(dat))
  return(core.AutoProcess(dat,dataname,maxNARate))
}
