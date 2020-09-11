######################
#Imported Functions
######################
utils.can.be.numeric <- function(x) {
  #Link: https://stackoverflow.com/questions/24129124/how-to-determine-if-a-character-vector-is-a-valid-numeric-or-integer-vector
  #Author: https://stackoverflow.com/users/3636840/stefan-avey
  stopifnot(is.atomic(x) || is.list(x))
  numNAs <- sum(is.na(x))
  numNAs_new <- suppressWarnings(sum(is.na(as.numeric(x))))
  return(numNAs_new == numNAs)
}

utils.isEntire<-function(vec){
  #Link: ?
  #Author: Anononymous. If this was you, contact us to add you as the author
  if(is.factor(vec)){
    return(TRUE)
  }
  vec<-imports.na.exclude(vec)
  res=all((vec == round(vec)))
  return(res)
}

utils.ConvertNumeric<- function(vardata,varname){
  vardata.trans<-suppressWarnings(as.numeric(as.character(vardata)))
  vardata <- vardata[!is.na(vardata)]
  uniques<-as.character(unique(vardata))
  vardata.err<-which(is.na(suppressWarnings(as.numeric(uniques))))
  res<-as.character(uniques[vardata.err])
  if(length(res)>0){
    print(paste0("[Numeric variable] ",varname,": strings thar will be changed to NA: ",paste(res,collapse=", ")))
  }
  return(vardata.trans)
}

utils.can.be.considered.numeric<- function(uniques){
  stopifnot(is.atomic(uniques) || is.list(uniques))
  numNAs_new <- suppressWarnings(sum(is.na(as.numeric(uniques))))
  if(numNAs_new<3)
   return(TRUE)
  return(FALSE)
}

#############
############
###########

utils.MixTableNResult<- function(dataset,res){
  if(is.null(dataset)){
    return(res)
  }else{
    dataset=rbind(dataset,res)
    return(dataset)
  }
}

utils.Round<- function(dataset,cols){
  for(col in cols){
    dataset[,col]<-ceiling(dataset[,col]*100)/100
  }
  return(dataset)
}

utils.summ.Round<- function(dataset,type){
  cols=NULL
  if(type=="txt")
    cols=c("NAPercent")
  if(type=="num")
    cols=c("sd","mean","skewness","NAPercent")
  if(type=="cat")
    cols=c("sdCategory","minperc","maxperc","NAPercent")
  if(type=="bool")
    cols=c("sdCategory","maxperc","NAPercent","sd","skewness")
  return(utils.Round(dataset,cols))
}


