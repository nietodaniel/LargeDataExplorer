#' Variable exploration & descriptive statistics of a data.frame
#'
#' classifies variables of a data.frame by type (bool, categorical, text, numeric, key,
#' etc.). Descriptive statistics (mean, min, max, sd, skewness, etc.) are generated for
#' each variable.
#'
#' @param dat data.frame
#' @param keyNamesMatch string vector containing substrings to search at the
#' start or end of each variable name to classify it as a key. Null to ignore
#' @return A list containing the descriptive statistics for each variable
#' classified by its type
#' @export
#' @author Daniel Nieto
#' @examples
#' df <- data.frame(secop1.full)
#'
#' #Basic Exploring of the data.frame
#' Explore.1.df <- LDE.Explore(df)
#
#' #Using only substrings to identify variables names as keys
#' keyNamesMatch<-c("ID","KEY")
#' Explore.2.df <- LDE.Explore(df,keyNamesMatch)
#'
#' #View which variables are of each type and its characteristics
#' #View(Explore.2.df$df.text)          #Text type
#' #View(Explore.2.df$df.num)           #Numeric type
#' #View(Explore.2.df$df.NA)            #Empty variables
#' #View(Explore.2.df$df.univalue)      #only one value type
#' #View(Explore.2.df$df.category)      #Categorical (text) type
#' #View(Explore.2.df$df.levels)        #categorical (numeric) type
#' #View(Explore.2.df$df.bool)          #Bool type
#' #View(Explore.2.df$df.primarykeys)   #Primary keys
#' #View(Explore.2.df$df.keys)          #Keys
#' #View(Explore.2.df$df.repeatedVars)  #With repeated information
LDE.Explore<-function(dat,keyNamesMatch=NULL){
  if(is.null(dat)){
    stop("Error: data is null")
  }
  dataname=deparse(substitute(dat))
  return(core.ExploreDataset(dat,dataname,keyNamesMatch))
}

#' Automatical exploration, variable filtering & re-formatting of a data.frame
#'
#' Automatically performs LDE.Explore() and then LDE.UsefulVars(), finally
#' returns the transformed dataset, excluding the unuseful variables, and
#' the $statistics $var.status and $var.classif of LDE.UsefulVars()
#'
#' @param dat data.frame
#' @param maxNARate numeric vector 0-1. Variables with a higher rate of NAs
#' will be excluded. Null to ignore
#' @param keyNamesMatch string vector containing substrings to search at the
#' start or end of each variable name to classify it as a key. Null to ignore
#' @return The filtered dataset, with re-formatted variables and all the
#' process information including descriptive statistics
#' @export
#' @author Daniel Nieto
#' @examples
#' df <- data.frame(secop1.full)
#' maxNARate <- 0.2
#' keyNamesMatch<-c("ID","KEY")
#'
#' #Basic AutoProcess of the data.frame
#' Auto.1.df <- LDE.AutoProcess(df)
#'
#' #Using a Max Rate of NA per variable
#' Auto.2.df <- LDE.AutoProcess(df,maxNARate)
#'
#' #Using substrings to identify variables names as keys, but without NAs filtering
#' Auto.3.df <- LDE.AutoProcess(df,NULL,keyNamesMatch)
#'
#' #Using Max Rate of NAs and substrings to identify variables names as keys
#' Auto.4.df <- LDE.AutoProcess(df,maxNARate,keyNamesMatch)
#'
#' #Obtention of the cleaned dataset
#' df.clean<-Auto.4.df$df.filtered
#'
#' #See if variables were included or excluded
#' #View(Auto.4.df$var.status$included) #included vars
#' #View(Auto.4.df$var.status$excluded) #excluded vars
#'
#' #See how the included variables were classified E.g.:
#' #View(Auto.4.df$var.classif$included.vars$df.num)  #numeric vars
#' #View(Auto.4.df$var.classif$included.vars$df.bool) #boolean vas
#'
#' #See how the excluded variables were classified E.g.:
#' #View(Auto.4.df$var.classif$removed.vars$not.useful)            #excluded by type
#' #View(Auto.4.df$var.classif$removed.vars$filtered.byNAs)        #excluded by NA rate
#' #View(Auto.4.df$var.classif$removed.vars$not.useful$df.NA)      #excluded by type, empty
#' #View(Auto.4.df$var.classif$removed.vars$filtered.byNAs$df.num) #numeric excluded by NA rate
#'
#' #See statistics of variables by exclusion reason
#' #View(Auto.4.df$statistics$useful.vars)        #included
#' #View(Auto.4.df$statistics$filteredbyNAs.vars) #excluded by NAs
#' #View(Auto.4.df$statistics$unuseful.vars)      #excluded by type
#'
#' #See statistics of variables by exclusion reason and type E.g.:
#' #View(Auto.4.df$statistics$useful.vars$df.levels)     #included that were levels
#' #View(Auto.4.df$statistics$filteredbyNAs.vars$df.num) #numeric, excluded by NA rate
#' #View(Auto.4.df$statistics$unuseful.vars$df.NA)       #excluded by type, empty vars
LDE.AutoProcess<-function(dat,maxNARate=NULL,keyNamesMatch=NULL){
  if(is.null(dat)){
    stop("Error: data is null")
  }
  dataname=deparse(substitute(dat))
  return(core.AutoProcess(dat,dataname,maxNARate,keyNamesMatch))
}

#' Retrieving useful variables for analytics
#'
#' Classifies variables by its type and usefulness for analytics (E.g. Na-only,
#' 1-value only, plain text types are not useful). It also includes descriptive
#' statistics for each included and excluded variable.
#'
#' @param maxNARate numeric vector 0-1. Variables with a higher rate of NAs
#' will be excluded. Null to ignore
#' @param LDE.ExploreObject LDE.Explore() Object
#' @param ... LDE.Explore() Objects
#' @return A list containing the useful variables classified by its type with
#' their descriptive statistics and a vector containing the useful variable names
#' @export
#' @author Daniel Nieto
#' @examples
#' df1 <- data.frame(secop1.full)
#' df2 <- data.frame(secop1.multas)
#' Explore.df1 <- LDE.Explore(df1)
#' Explore.df2 <- LDE.Explore(df2)
#'
#' maxNARate <- 0.2
#'
#' #Basic variable filtering of a single dataset exploration
#' Usefulness.1.df1 <- LDE.UsefulVars(NULL,Explore.df1)
#'
#' #Basic variable filtering of a multiple datasets explortaions
#' Usefulness.1 <- LDE.UsefulVars(NULL,Explore.df1,Explore.df2)
#'
#' #Variable filtering, including NA threshold, using multiple datasets explortaions
#' Usefulness.2 <- LDE.UsefulVars(maxNARate,Explore.df1,Explore.df2)
#'
#' #df1: See if variables were included or excluded
#' #View(Usefulness.2$var.status$df1$included) #included vars
#' #View(Usefulness.2$var.status$df1$excluded) #excluded vars
#'
#' #df1: See how the included variables were classified E.g.:
#' #View(Usefulness.2$var.classif$df1$included.vars$df.num) #numeric variables
#' #View(Usefulness.2$var.classif$df1$included.vars$df.bool) #boolean variables
#'
#' #df1: See how the excluded variables were classified E.g.:
#' #View(Usefulness.2$var.classif$df1$removed.vars$not.useful) #excluded by type
#' #View(Usefulness.2$var.classif$df1$removed.vars$filtered.byNAs) #excluded by NA rate
#' #View(Usefulness.2$var.classif$df1$removed.vars$not.useful$df.NA) #excluded by type, empty
#' #View(Usefulness.2$var.classif$df1$removed.vars$filtered.byNAs$df.num) #numeric, excluded by NA rate
#'
#' #df1: See statistics of variables by exclusion reason
#' #View(Usefulness.2$statistics$df1$useful.vars) #included
#' #View(Usefulness.2$statistics$df1$filteredbyNAs.vars) #excluded by NA rate
#' #View(Usefulness.2$statistics$df1$unuseful.vars) #excluded by type
#'
#' #df1: See statistics of variables by exclusion reason and type E.g.:
#' #View(Usefulness.2$statistics$df1$useful.vars$df.levels) #included, type level
#' #View(Usefulness.2$statistics$df1$filteredbyNAs.vars$df.num) #numeric, excluded by NA rate
#' #View(Usefulness.2$statistics$df1$unuseful.vars$df.NA) #excluded, type empty


LDE.UsefulVars<-function(maxNARate=NULL,LDE.ExploreObject,...){
  if(is.null(LDE.ExploreObject)){
    stop("Error: LDE.ExploreObject is null")
  }
  return(core.UsefulVars(maxNARate,LDE.ExploreObject,...))
}
