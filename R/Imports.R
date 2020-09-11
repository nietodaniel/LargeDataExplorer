imports.skewness <- function(vec) {
 return(e1071::skewness(vec,na.rm = TRUE))
}

imports.median <- function(vec) {
  return(stats::median(vec,na.rm = TRUE))
}

imports.sd <- function(vec) {
  return(stats::sd(vec,na.rm = TRUE))
}

imports.na.exclude <- function(vec) {
  return(stats::na.exclude(vec))
}
