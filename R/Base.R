
######################
#Imported Functions
######################
internalfun.can.be.numeric <- function(x) {
  #Link: https://stackoverflow.com/questions/24129124/how-to-determine-if-a-character-vector-is-a-valid-numeric-or-integer-vector
  #Author: https://stackoverflow.com/users/3636840/stefan-avey
  stopifnot(is.atomic(x) || is.list(x))
  numNAs <- sum(is.na(x))
  numNAs_new <- suppressWarnings(sum(is.na(as.numeric(x))))
  return(numNAs_new == numNAs)
}
#############
############
###########


internalfun.Summary.num <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  vec<-as.numeric(vec)
  res<- data.frame(matrix(ncol = 10, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","min","max","mean","median","sd","skewness","NAPercent")
  res$dataname<-dataname
  res$varnum<-colnum
  res$varname<-colname
  res$min<-min(vec,na.rm = TRUE)
  res$max<-max(vec,na.rm = TRUE)
  res$mean<-mean(vec,na.rm = TRUE)
  res$median<-imports.median(vec)
  res$sd<-imports.sd(vec)
  res$skewness<-imports.skewness(vec)
  res$NAPercent<-NAResult
  dataset=internalfun.MixTableNResult(dataset,res)
  return(dataset)
}

internalfun.Summary.bool <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  vec<-as.factor(vec)
  vec2<-table(vec)
  vec2<-vec2[order(vec2)]
  res<- data.frame(matrix(ncol = 11, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","modelvl","maxperc","mean","median","sd","sdCategory","skewness","NAPercent")
  res$dataname<-dataname
  res$varnum<-colnum
  res$varname<-colname
  res$modelvl<-names(vec2)[length(vec2)]
  res$maxperc<-vec2[length(vec2)]*100/length(vec)
  if(!(is.numeric(vec)) & !(internalfun.can.be.numeric(vec))){
    vec=replace(vec, vec==vec2[length(vec2)], 1)
    vec=replace(vec, vec==vec2[1], 0)
  }
  vec=as.numeric(vec)
  res$skewness<-imports.skewness(vec)
  res$mean<-mean(vec,na.rm = TRUE)
  res$median<-imports.median(vec)
  res$sd<-imports.sd(vec)
  res$sdCategory<-imports.sd(vec2)
  res$NAPercent<-NAResult
  dataset=internalfun.MixTableNResult(dataset,res)
  return(dataset)
}

internalfun.Summary.factor <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  vec<-as.factor(vec)
  vec2<-table(vec)
  vec2<-vec2[order(vec2)]

  res<- data.frame(matrix(ncol = 13, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","lvls","minlvl","minperc","maxlvl","maxperc","mean","median","sd","sdCategory","NAPercent")
  res$dataname<-dataname
  res$varnum<-colnum
  res$varname<-colname
  res$lvls<-length(vec2)
  res$minlvl<-names(vec2)[1]
  res$maxlvl<-names(vec2)[length(vec2)]
  res$minperc<-vec2[1]*100/length(vec)
  res$maxperc<-vec2[length(vec2)]*100/length(vec)
  res$mean<-mean(vec2,na.rm = TRUE)
  res$median<-imports.median(vec2)
  if(!(is.numeric(vec)) & !(internalfun.can.be.numeric(vec))){
    vec=as.numeric(vec)
    res$skewness<-imports.skewness(vec)
    res$sd<-imports.sd(vec)
  }else{
    res$skewness<-"-"
    res$sd<-"-"
  }
  res$sdCategory<-imports.sd(vec2)
  res$NAPercent<-NAResult
  dataset=internalfun.MixTableNResult(dataset,res)
  return(dataset)
}

internalfun.MixTableNResult<- function(dataset,res){
  if(is.null(dataset)){
    return(res)
  }else{
    dataset=rbind(dataset,res)
    return(dataset)
  }
}

internalfun.Summary.err <- function(colnum,colname,dataset) {
  res<- data.frame(matrix(ncol = 2, nrow = 1))
  colnames(res)<- c("varnum","varname")
  res$varnum<-colnum
  res$varname<-colname
  dataset=internalfun.MixTableNResult(dataset,res)
  return(dataset)
}

internalfun.Summary.txt <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  res<- data.frame(matrix(ncol = 5, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","UniqueValues","NAPercent")
  res$varnum<-colnum
  res$varname<-colname
  res$dataname<-dataname
  res$UniqueValues<-length(table(vec))
  res$NAPercent<-NAResult
  dataset=internalfun.MixTableNResult(dataset,res)
  return(dataset)
}

internalfun.isEntire<-function(vec){
  if(is.factor(vec)){
    return(TRUE)
  }
  vec<-stats::na.exclude(vec)
  res=all((vec == round(vec)))
  return(res)
}

internalfun.SummType<-function(vec,dataname){
  if(sum(is.na(vec))==length(vec)){
    return(-1) #df.NA
  }
  if(length(vec)==length(unique(vec))){
    return(5) #primary key
  }
  vec <- vec[!is.na(vec)]
  rrr<-table(vec)
  if(length(rrr)==1){
    return(-2) #df.univalue
  }
  if(length(rrr)==2){
    return(3) #df.univalue
  }
  if(is.numeric(vec) || internalfun.can.be.numeric(vec)){
    if((length(rrr)<(100)) & internalfun.isEntire(vec)){
      return(2) #df.levels
    }
    return(0)
  }
  if(length(rrr)<(100)){
    return(1) #df.category
  }
  return(4)
}

internalfun.VarTypeName<-function(type){
  if(type==-3){
    return("Mismatch")
  }
  if(type==-2){
    return("Only One Value")
  }
  if(type==-1){
    return("NA")
  }
  if(type==0){
    return("Number")
  }
  if(type==1){
    return("Categoric")
  }
  if(type==2){
    return("Levels")
  }
  if(type==3){
    return("Boolean")
  }
  if(type==4){
    return("Text")
  }
  if(type==5){
    return("Primary key")
  }
}

internalfun.findVarname<-function(index,df.summ){
  df.summ.num<-df.summ[,c(2:4)]
  indeces= which(df.summ.num[,1]==df.summ.num[index,1] & df.summ.num[,2]==df.summ.num[index,2] & df.summ.num[,3]==df.summ.num[index,3])
  if(length(indeces)>0){
    index=indeces[1]
    varname=df.summ[index,1]
    return(varname)
  }else{
    return("-")
  }
}

internalfun.seekRepeated<-function(df.repeated,isCategory,dat1,dat2=NULL){
  if((is.null(dat1))){
    return(list("hasRepeated"=FALSE))
  }
  if(!(is.null(dat2))){
    dat3<-dat1
    dat1<-rbind(dat1,dat2)
  }
  summ<- data.frame(matrix(ncol = 5, nrow = nrow(dat1)))
  colnames(summ)<- c("varname","sd","vals","NAs","repeatedVar")
  if(isCategory==TRUE){
    summ$sd=dat1$sdCategory
    summ$vals=dat1$maxperc
  }else{
    summ$sd=dat1$sd
    summ$vals=dat1$mean
  }
  summ$NAs<-dat1$NAPercent
  summ$varname<-dat1$varname
  summ.toFilter=summ[, (names(summ) %in% c("NAs","sd","vals"))]
  rep.index=duplicated(summ.toFilter)
  summ.filtered=summ[!(rep.index),]
  summ.repeated=summ[rep.index,]
  hasRepeated=FALSE
  rep.indeces=which(rep.index==TRUE)
  if(nrow(summ.repeated)>0){
    hasRepeated=TRUE
    summ.repeated$repeatedVar<-by(rep.indeces, 1:length(rep.indeces), function(index) internalfun.findVarname(index,summ))
  }
  if(!(is.null(dat2))){
    dat1=dat3
  }
  dat1=dat1[!(dat1$varname %in% summ.repeated$varname),]
  summ.repeated=summ.repeated[,c(1,5)]
  df.repeated=internalfun.MixTableNResult(df.repeated,summ.repeated)
  return(list("df.filtered"=dat1,"df.repeated"=df.repeated,"hasRepeated"=hasRepeated))
}

internalfun.UsefulVars.filter<-function(filter.vars,df,maxNApercentage){
  if(filter.vars==TRUE)
    df=df[df$NAPercent<maxNApercentage,]
  return(df)
}
