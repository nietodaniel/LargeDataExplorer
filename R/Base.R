internalfun.findAtBegginingorEnd<-function(varname,keyNamesMatch){
  varname=tolower(varname)
  keyNamesMatch=tolower(keyNamesMatch)
  for(keymatch in keyNamesMatch){
    wordlen = nchar(keymatch)
    if(substr(varname, start = 1, stop = wordlen)==keymatch || substr(varname, nchar(varname)-wordlen+1, nchar(varname))==keymatch)
      return(TRUE)
  }
  return(FALSE)
}

internalfun.findVarnames<-function(df.withvarname){
  if(!is.null(df.withvarname) & length(df.withvarname)>0)
    return(df.withvarname$varname)
  return(c())
}

internalfun.removeRowNames<-function(df){
  if(!is.null(df) & length(df)>0){
    rownames(df)<-NULL
    return(df)
  }
  return(NULL)
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

internalfun.seekRepeated<-function(df.repeated,is.multi,isCategory,dat1=NULL,dat2=NULL,dat3=NULL,dat4=NULL){
  if(is.multi==TRUE){
    null1=ifelse(is.null(dat1),1,0)
    null2=ifelse(is.null(dat2),1,0)
    null3=ifelse(is.null(dat3),1,0)
    null4=ifelse(is.null(dat4),1,0)
    nullnum = null1+null2+null3+null4
    if(nullnum>2)
      return(list("hasRepeated"=FALSE))
    dat.full=NULL
    for(i in 1:4){
      if(i==1)
        datx=dat1
      if(i==2)
        datx=dat2
      if(i==3)
        datx=dat3
      if(i==4)
        datx=dat4
      if(is.null(dat.full)){
        dat.full=datx
      }else{
        dat.full<-rbind(dat.full,datx)
      }
    }
  }else{
    if(is.null(dat1))
      return(list("hasRepeated"=FALSE))
    dat.full=dat1
  }
  summ<- data.frame(matrix(ncol = 5, nrow = nrow(dat.full)))
  colnames(summ)<- c("varname","sd","vals","NAs","originalvar")
  if(isCategory==TRUE){
    summ$sd=dat.full$sdCategory
    summ$vals=dat.full$maxperc
  }else{
    summ$sd=dat.full$sd
    summ$vals=dat.full$mean
  }
  summ$NAs<-dat.full$NAPercent
  summ$varname<-dat.full$varname

  summ.toFilter=summ[, c(2,3,4)]
  rep.indeces=which(duplicated(summ.toFilter)==TRUE)

  summ.filtered=summ[!(rep.indeces),]
  summ.repeated=summ[rep.indeces,]

  if(length(rep.indeces)==0)
    return(list("hasRepeated"=FALSE))

  summ.repeated$originalvar<-by(rep.indeces, 1:length(rep.indeces), function(index) internalfun.findVarname(index,summ))
  summ.repeated=summ.repeated[,c(1,5)]
  df.repeated=utils.MixTableNResult(df.repeated,summ.repeated)

  if(is.multi==TRUE){
    if(!(is.null(dat1))){
      dat1=dat1[!(dat1$varname %in% summ.repeated$varname),]
    }
    if(!(is.null(dat2))){
      dat2=dat2[!(dat2$varname %in% summ.repeated$varname),]
    }
    if(!(is.null(dat3))){
      dat3=dat3[!(dat3$varname %in% summ.repeated$varname),]
    }
    if(!(is.null(dat4))){
      dat4=dat4[!(dat4$varname %in% summ.repeated$varname),]
    }
    df.filtered=list("dat1"=dat1,"dat2"=dat2,"dat3"=dat3,"dat4"=dat4)
  }else{
    df.filtered=dat1[!(dat1$varname %in% summ.repeated$varname),]
  }
  return(list("df.filtered"=df.filtered,"df.repeated"=df.repeated,"hasRepeated"=TRUE))
}

internalfun.UsefulVars.filter<-function(filter.vars,df,maxNApercentage){
  if(is.null(df) || length(df)==0)
    return(list("filtered.df"=NULL,"excluded.df"=NULL))
  if(filter.vars==TRUE){
    filtered.df=df[df$NAPercent<maxNApercentage,]
    excluded.df=df[!(df$NAPercent<maxNApercentage),]
  }else{
    filtered.df=df
    excluded.df=NULL
  }
  return(list("filtered.df"=filtered.df,"excluded.df"=excluded.df))
}
