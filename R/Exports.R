#' Variable exploration, classification & descriptive statistics of a data.frame
#'
#' classifies variables of a data.frame by type (bool, categorical, text, numeric, key,
#' etc.) and by its usefulness for analytics (E.g. Na-only, #' 1-value only, plain text
#' types are not useful). Descriptive statistics (mean, min, max, sd, skewness, etc.)
#' are generated for each variable.
#'
#' @param dat data.frame
#' @param maxNARate numeric vector 0-1. Variables with a higher rate of NAs
#' will be excluded. Null to ignore
#' @param keyNamesMatch string vector containing substrings to search at the
#' start or end of each variable name to classify it as a key. Null to ignore
#' @return A list containing the useful variables classified by its type with
#' their descriptive statistics and a vector containing the useful variable names
#' @export
#' @author Daniel Nieto
#' @examples
#' maxNARate <- 0.2                  #NA Threshold
#' keyNamesMatch<-c("ID","KEY")      #var names that begin or end with id or key will be set as keys
#'
#' df <- data.frame(secop1.full)
#'
#' Explore.1.df <- LDE.Explore(df)                              #Basic Exploring
#' Explore.2.df <- LDE.Explore(df,keyNamesMatch)                #Identifying keys
#' Explore.3.df <- LDE.Explore(df,NULL,maxNARate)               #With a NAs threshold
#' Explore.4.df <- LDE.Explore(df,keyNamesMatch,maxNARate)      #Identifying keys and NAs threshold
#'
#' #See if variables were included or excluded
#' #View(Explore.4.df$var.status$included) #included vars
#' #View(Explore.4.df$var.status$excluded) #excluded vars
#'
#' #See how the included variables were classified E.g.:
#' #View(Explore.4.df$var.classif$included.vars$df.num) #numeric variables
#' #View(Explore.4.df$var.classif$included.vars$df.bool) #boolean variables
#'
#' #See how the excluded variables were classified E.g.:
#' #View(Explore.4.df$var.classif$removed.vars$not.useful) #excluded by type
#' #View(Explore.4.df$var.classif$removed.vars$filtered.byNAs) #excluded by NA rate
#' #View(Explore.4.df$var.classif$removed.vars$not.useful$df.NA) #excluded by type, empty
#' #View(Explore.4.df$var.classif$removed.vars$filtered.byNAs$df.num) #numeric, excluded by NA rate
#'
#' #See statistics of variables by exclusion reason
#' #View(Explore.4.df$statistics$useful.vars) #included
#' #View(Explore.4.df$statistics$filteredbyNAs.vars) #excluded by NA rate
#' #View(Explore.4.df$statistics$unuseful.vars) #excluded by type
#'
#' #See statistics of variables by exclusion reason and type E.g.:
#' #View(Explore.4.df$statistics$useful.vars$df.levels) #included, type level
#' #View(Explore.4.df$statistics$filteredbyNAs.vars$df.num) #numeric, excluded by NA rate
#' #View(Explore.4.df$statistics$unuseful.vars$df.NA) #excluded, type empty
LDE.Explore<-function(dat,maxNARate=NULL,keyNamesMatch=NULL){
  if(is.null(dat)){
    stop("Error: data is null")
  }
  dataname=deparse(substitute(dat))
  return(core.ExploreFull(dat,dataname,maxNARate,keyNamesMatch))
}

#' Automatical exploration, variable filtering & re-formatting of a data.frame
#'
#' Automatically performs LDE.Explore() and then LDE.UsefulVars(), finally
#' returns the transformed dataset, excluding the unuseful variables, and
#' the $statistics $var.status and $var.classif of LDE.UsefulVars()
#'
#' @param dat data.frame

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
