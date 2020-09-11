summarizer.num <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec<-suppressWarnings(as.numeric(vec))
  vec <- vec[!is.na(vec)]
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
  dataset=utils.MixTableNResult(dataset,res)
  return(dataset)
}

summarizer.date <- function(colnum,colname,vec,dataname,dataset) {
  return(summarizer.txt(colnum,colname,vec,dataname,dataset))
}

summarizer.bool.base <- function(colnum,colname,vec,dataname) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  vec<-as.factor(vec)
  vec2<-table(vec)
  vec2<-vec2[order(vec2)]
  res<- data.frame(matrix(ncol = 9, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","modelvl","maxperc","sd","sdCategory","skewness","NAPercent")
  res$dataname<-dataname
  res$varnum<-colnum
  res$varname<-colname
  res$modelvl<-names(vec2)[length(vec2)]
  res$maxperc<-vec2[length(vec2)]*100/length(vec)
  if(!(is.numeric(vec)) & !(utils.can.be.numeric(vec))){
    vec=replace(vec, vec==vec2[length(vec2)], 1)
    vec=replace(vec, vec==vec2[1], 0)
  }
  vec=as.numeric(vec)
  res$skewness<-imports.skewness(vec)
  res$sd<-imports.sd(vec)
  res$sdCategory<-imports.sd(vec2)
  res$NAPercent<-NAResult
  return(res)
}

summarizer.bool <- function(colnum,colname,vec,dataname,dataset) {
  res<-summarizer.bool.base(colnum,colname,vec,dataname)
  dataset=utils.MixTableNResult(dataset,res)
  return(dataset)
}

summarizer.factor <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  vec<-as.factor(vec)
  vec2<-table(vec)
  vec2<-vec2[order(vec2)]

  res<- data.frame(matrix(ncol = 11, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","lvls","minlvl","minperc","maxlvl","maxperc","sd","sdCategory","NAPercent")
  res$dataname<-dataname
  res$varnum<-colnum
  res$varname<-colname
  res$lvls<-length(vec2)
  res$minlvl<-names(vec2)[1]
  res$maxlvl<-names(vec2)[length(vec2)]
  res$minperc<-vec2[1]*100/length(vec)
  res$maxperc<-vec2[length(vec2)]*100/length(vec)
  if(!(is.numeric(vec)) & !(utils.can.be.numeric(vec))){
    vec=as.numeric(vec)
    res$skewness<-imports.skewness(vec)
    res$sd<-imports.sd(vec)
  }else{
    res$skewness<-"-"
    res$sd<-"-"
  }
  res$sdCategory<-imports.sd(vec2)
  res$NAPercent<-NAResult
  dataset=utils.MixTableNResult(dataset,res)
  return(dataset)
}

summarizer.err <- function(colnum,colname,dataset) {
  res<- data.frame(matrix(ncol = 2, nrow = 1))
  colnames(res)<- c("varnum","varname")
  res$varnum<-colnum
  res$varname<-colname
  dataset=utils.MixTableNResult(dataset,res)
  return(dataset)
}

summarizer.txt <- function(colnum,colname,vec,dataname,dataset) {
  NAResult<-100*sum(is.na(vec))/length(vec)
  vec <- vec[!is.na(vec)]
  res<- data.frame(matrix(ncol = 5, nrow = 1))
  colnames(res)<- c("varnum","varname","dataname","UniqueValues","NAPercent")
  res$varnum<-colnum
  res$varname<-colname
  res$dataname<-dataname
  res$UniqueValues<-length(unique(vec))
  res$NAPercent<-NAResult
  dataset=utils.MixTableNResult(dataset,res)
  return(dataset)
}
