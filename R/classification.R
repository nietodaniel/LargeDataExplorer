classif.sample.var<-function(vec,num){
  ct = length(vec)
  if(num>ct)
    num=ct
  indexes<-sample(1:ct, num, replace=FALSE)
  return(vec[indexes])
}

classif.text.vector.len<-function(vec){
  res=c()
  for(i in vec){
    res=c(res,nchar(i))
  }
  return(res)
}


classif.vartype<-function(ori.vec,varname,keyNamesMatch){
  # -3 Mismatch
  # -2 Only One Value
  # -1 NA
  # 0 Number
  # 1 Categoric
  #2 Levels
  #3 Boolean
  #4 Text
  #5 Primary key
  #6 key
  #7 date
  len.ori.vec<-length(ori.vec)

  vec <- ori.vec[!is.na(ori.vec)]
  len.vec=length(vec)

  if(len.vec==0)
    return(-1) #df.NA

  uniques = unique(vec)
  len.uniques=length(uniques)

  if(len.uniques==1)
    return(-2) #df.univalue

  if(len.uniques==2)
    return(3) #df.boolean

  if(len.vec==len.uniques){
    if(len.vec==len.ori.vec)
      return(5) #primary key
    return(6) #key
  }

  keyNamesMatch=c("ID","COD",keyNamesMatch)
  if(internalfun.findAtBegginingorEnd(varname,keyNamesMatch)==TRUE)
    return(6) #key

  is.uniques.numeric =is.numeric(uniques)
  can.unique.be.considered.numeric = utils.can.be.considered.numeric(uniques)

  if(len.uniques<(100)){
    if(is.uniques.numeric==TRUE){
      return(2) #df.levels
    }else{
      return(1) #df.category
    }
  }else{
    if(is.uniques.numeric==TRUE || can.unique.be.considered.numeric==TRUE){
      return(0) #df.numeric
    }else{
      sample.mini<-classif.sample.var(uniques,200)
      vec.txt.len=classif.text.vector.len(sample.mini)
      vec.txt.len=unique(vec.txt.len)
      med.vec.txt.len=imports.median(vec.txt.len)
      if(length(vec.txt.len)<3 && med.vec.txt.len>5)
        return(7) #df.date
      return(4) #text
    }
  }
}
