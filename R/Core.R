core.ExploreDataset<-function(dat1,dataname1){
  if(ncol(dat1)<2 || ncol(dat1)<2){
    stop(paste0(dataname1," is not a data.frame"))
  }
  dat1=data.frame(dat1)
  df.text=NULL
  df.num=NULL
  df.NA=NULL
  df.onevalue=NULL
  df.repeatedVars=NULL
  df.category=NULL
  df.levels=NULL
  df.bool=NULL
  df.primarykeys=NULL
  cat(paste0("\nProcessing ",ncol(dat1)," variables\nProcessed:"))
  for (i in 1:ncol(dat1)) {
    cat(paste0(i," "))
    nombreCol<-names(dat1)[i]
    vec1<-as.data.frame(dat1)[,nombreCol]
    type=internalfun.SummType(vec1,dataname1)
    if(type==-2){
      df.onevalue=internalfun.Summary.err(i,nombreCol,df.onevalue)
    }
    if(type==-1){
      df.NA=internalfun.Summary.err(i,nombreCol,df.NA)
    }
    if(type==0){
      df.num=internalfun.Summary.num(i,nombreCol,vec1,dataname1,df.num)
    }
    if(type==1){
      df.category=internalfun.Summary.factor(i,nombreCol,vec1,dataname1,df.category)
    }
    if(type==2){
      df.levels=internalfun.Summary.factor(i,nombreCol,vec1,dataname1,df.levels)
    }
    if(type==3){
      df.bool=internalfun.Summary.bool(i,nombreCol,vec1,dataname1,df.bool)
    }
    if(type==4){
      df.text=internalfun.Summary.txt(i,nombreCol,vec1,dataname1,df.text)
    }
    if(type==5){
      df.primarykeys=internalfun.Summary.err(i,nombreCol,df.primarykeys)
    }
  }
  cat(" Done!\n")
  cat(" Seeking repeated vars...\n")
  rep.category=internalfun.seekRepeated(df.repeatedVars,TRUE,df.category)
  if(rep.category$hasRepeated==TRUE){
    df.category=rep.category$df.filtered
    df.repeatedVars=rep.category$df.repeated
  }
  rep.levels=internalfun.seekRepeated(df.repeatedVars,TRUE,df.levels)
  if(rep.levels$hasRepeated==TRUE){
    df.levels=rep.levels$df.filtered
    df.repeatedVars=rep.levels$df.repeated
  }
  rep.bool=internalfun.seekRepeated(df.repeatedVars,TRUE,df.bool)
  if(rep.bool$hasRepeated==TRUE){
    df.bool=rep.bool$df.filtered
    df.repeatedVars=rep.bool$df.repeated
  }
  rep.num=internalfun.seekRepeated(df.repeatedVars,FALSE,df.num)
  if(rep.num$hasRepeated==TRUE){
    df.num=rep.num$df.filtered
    df.repeatedVars=rep.num$df.repeated
  }
  rep.levelcat=internalfun.seekRepeated(df.repeatedVars,TRUE,df.levels,df.category)
  if(rep.levelcat$hasRepeated==TRUE){
    df.category=rep.levelcat$df.filtered
    df.repeatedVars=rep.levelcat$df.repeated
  }
  cat(" Done!\n")
  if(!is.null(df.category)){
    df.category<-df.category[order(df.category$lvls,df.category$sd),]
    rownames(df.category)<-NULL
  }
  if(!is.null(df.levels)){
    df.levels<-df.levels[order(df.levels$lvls,df.levels$sd),]
    rownames(df.levels)<-NULL
  }
  if(!is.null(df.num)){
    rownames(df.num)<-NULL
  }
  if(is.null(df.primarykeys)){
    print("The dataset Has No primary Key")
  }else{
    print(paste0("Primary keys: ",paste(df.primarykeys$varname,sep=", ")))
  }
  return(list("dataname"=dataname1,"df.repeatedVars"=df.repeatedVars,"df.primarykeys"=df.primarykeys,"df.bool"=df.bool,"df.levels"=df.levels,"df.category"=df.category,"df.onevalue"=df.onevalue,"df.NA"=df.NA,"df.num"=df.num,"df.text"=df.text))
}

core.UsefulVars<-function(maxNARate,LargeDataExplorer.Explore1,...){
  filter.vars=FALSE
  if(!(is.null(maxNARate))){
    filter.vars=TRUE
    if(!(is.numeric(maxNARate)) | maxNARate<0 | maxNARate>1){
      stop("maxNARate must be a value between 0 and 1")
    }
    maxNApercentage=maxNARate*100
  }
  listx<-list(LargeDataExplorer.Explore1,...)
  df.num=NULL
  df.category=NULL
  df.levels=NULL
  df.bool=NULL
  df.primarykeys=NULL
  useful.varnames=list()
  removed.varnames=list()
  cat(" \nExploring summaries: ")
  for(Exploration in listx) {
    dataname=Exploration$dataname
    cat(paste0(dataname,"... "))
    res.cat=Exploration$df.category
    res.num=Exploration$df.num
    res.bool=Exploration$df.bool
    res.levels=Exploration$df.levels
    res.primarykeys=Exploration$df.primarykeys
    res.names=c()
    res.names.removed=c(Exploration$df.text$varname,Exploration$df.NA$varname,Exploration$df.onevalue$varname,Exploration$df.repeatedVars$varname)
    res.names.filtered=c()
    if(!(is.null(res.num))){
      res.num.filtered=internalfun.UsefulVars.filter(filter.vars,res.num,maxNApercentage)
      df.num=internalfun.MixTableNResult(df.num,res.num.filtered)
      res.names=c(res.names,res.num.filtered$varname)
      res.names.filtered=c(res.names.filtered,setdiff(res.num$varname,res.num.filtered$varname))
    }
    if(!(is.null(res.cat))){
      res.cat.filtered=internalfun.UsefulVars.filter(filter.vars,res.cat,maxNApercentage)
      df.category=internalfun.MixTableNResult(df.category,res.cat.filtered)
      res.names=c(res.names,res.cat.filtered$varname)
      res.names.filtered=c(res.names.filtered,setdiff(res.cat$varname,res.cat.filtered$varname))
    }
    if(!(is.null(res.bool))){
      res.bool.filtered=internalfun.UsefulVars.filter(filter.vars,res.bool,maxNApercentage)
      df.bool=internalfun.MixTableNResult(df.bool,res.bool.filtered)
      res.names=c(res.names,res.bool.filtered$varname)
      res.names.filtered=c(res.names.filtered,setdiff(res.bool$varname,res.bool.filtered$varname))
    }
    if(!(is.null(res.levels))){
      res.levels.filtered=internalfun.UsefulVars.filter(filter.vars,res.levels,maxNApercentage)
      df.levels=internalfun.MixTableNResult(df.levels,res.levels.filtered)
      res.names=c(res.names,res.levels.filtered$varname)
      res.names.filtered=c(res.names.filtered,setdiff(res.levels$varname,res.levels.filtered$varname))
    }
    if(!(is.null(res.primarykeys))){
      df.primarykeys=internalfun.MixTableNResult(df.primarykeys,res.primarykeys)
      res.names=c(res.names,res.primarykeys$varname)
    }
    useful.varnames[[dataname]] = res.names
    removed.varnames[[dataname]] = list("not.useful"=res.names.removed,"filtered.out"=res.names.filtered)
  }
  cat("\nDone!")
  rownames(df.category)<-NULL
  rownames(df.levels)<-NULL
  rownames(df.num)<-NULL
  rownames(df.bool)<-NULL
  rownames(df.primarykeys)<-NULL
  return(list("removed.varnames"=removed.varnames,"useful.varnames"=useful.varnames,"df.primarykeys"=df.primarykeys,"df.bool"=df.bool,"df.levels"=df.levels,"df.category"=df.category,"df.num"=df.num))
}

core.AutoProcess<-function(dat,dataname,maxNARate){
  if(ncol(dat)<2 || ncol(dat)<2){
    stop(paste0(dataname," is not a data.frame"))
  }
  if(!(is.null(maxNARate))){
    if(!(is.numeric(maxNARate)) | maxNARate<0 | maxNARate>1){
      stop("maxNARate must be a value between 0 and 1")
    }
  }
  dat=data.frame(dat)
  if(sum(is.na(dat))==0){
    dat[dat==""]<-NA
  }
  tmp.Explore<-core.ExploreDataset(dat,dataname)
  tmp.UsefulVars<-core.UsefulVars(maxNARate,tmp.Explore)
  process.info=list("Exploration"=tmp.Explore,"UsefulVars"=tmp.UsefulVars)
  included.vars<-tmp.UsefulVars$useful.varnames[[dataname]]
  dat.filtered<-subset(dat,select=included.vars)
  ####
  for (varname in tmp.UsefulVars$df.category$varname) {
    dat.filtered[,varname]=as.factor(dat.filtered[,varname])
  }
  for (varname in tmp.UsefulVars$df.num$varname) {
    dat.filtered[,varname]=as.numeric(dat.filtered[,varname])
  }
  i_bool=0
  for (varname in tmp.UsefulVars$df.bool$varname) {
    i_bool=i_bool+1
    modelvl=tmp.UsefulVars$df.bool$modelvl[i_bool]
    dat.filtered[,varname]=as.factor(as.numeric(ifelse((dat[,varname]==modelvl)==TRUE,1,0)))
    names(dat.filtered)[which( colnames(dat.filtered)==varname )]=paste0(varname,"_is",modelvl)
  }
  for (varname in tmp.UsefulVars$df.levels$varname) {
    dat.filtered[,varname]=as.factor(as.numeric(dat.filtered[,varname]))
  }
  for (varname in tmp.UsefulVars$df.primarykeys$varname) {
    dat.filtered[,varname]=as.factor(dat.filtered[,varname])
  }

  ###
  return(list("df.filtered"=dat.filtered,"process.info"=process.info))
}
