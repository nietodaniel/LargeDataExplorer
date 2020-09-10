core.AutoProcess<-function(dat,dataname,maxNARate,keyNamesMatch){
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
  tmp.Explore<-core.ExploreDataset(dat,dataname,keyNamesMatch)
  tmp.UsefulVars<-core.UsefulVars(maxNARate,tmp.Explore)

  #Here begins the code of processing previous steps

  included.vars<-tmp.UsefulVars$var.status[[dataname]]$included
  dat.filtered<-subset(dat,select=included.vars)
  ### Unuseful variable removal and type transformation
  for (varname in tmp.UsefulVars$var.classif[[dataname]]$useful.vars$df.primarykeys) {
    dat.filtered[,varname]=as.character(dat.filtered[,varname])
  }
  for (varname in tmp.UsefulVars$var.classif[[dataname]]$useful.vars$df.keys) {
    dat.filtered[,varname]=as.character(dat.filtered[,varname])
  }
  for (varname in tmp.UsefulVars$var.classif[[dataname]]$useful.vars$df.category) {
    dat.filtered[,varname]=as.factor(dat.filtered[,varname])
  }
  for (varname in tmp.UsefulVars$var.classif[[dataname]]$useful.vars$df.num) {
    dat.filtered[,varname]=as.numeric(dat.filtered[,varname])
  }
  for (varname in tmp.UsefulVars$var.classif[[dataname]]$useful.vars$df.levels) {
    dat.filtered[,varname]=as.factor(as.numeric(dat.filtered[,varname]))
  }
  i_bool=0
  for (varname in tmp.UsefulVars$var.classif[[dataname]]$useful.vars$df.bool) {
    i_bool=i_bool+1
    modelvl=tmp.UsefulVars$statistics[[dataname]]$useful.vars$df.bool$modelvl[i_bool]
    newvalues=as.factor(as.numeric(ifelse((dat[,varname]==modelvl)==TRUE,1,0)))
    newname=gsub(' ','_',modelvl)
    newname=paste0(newname,"_is",newname)
    dat.filtered[,varname]=newvalues
    var_index=which( colnames(dat.filtered)==varname )
    names(dat.filtered)[var_index]=newname
    old.bool.vector<-tmp.UsefulVars$statistics[[dataname]]$useful.vars$df.bool[i_bool,]
    #Changing name in statistics
    new.bool.stat.values<-internalfun.Summary.bool.base(var_index,varname,newvalues,dataname)
    tmp.UsefulVars$statistics[[dataname]]$useful.vars$df.bool[i_bool,]=new.bool.stat.values
  }

  return(list("df.filtered"=dat.filtered,"statistics"=tmp.UsefulVars$statistics[[dataname]],"var.classif"=tmp.UsefulVars$var.classif[[dataname]],"var.status"=tmp.UsefulVars$var.status[[dataname]]))
}

core.ExploreDataset<-function(dat1,dataname1,keyNamesMatch){
  if(ncol(dat1)<2 || ncol(dat1)<2){
    stop(paste0(dataname1," is not a data.frame"))
  }
  if(is.null(keyNamesMatch)){
    keyNamesMatch=c()
  }else{
    keyNamesMatch=as.vector(as.character(keyNamesMatch))
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
  df.keys=NULL
  cat(paste0("\nProcessing ",ncol(dat1)," variables\nProcessed:"))
  for (i in 1:ncol(dat1)) {
    cat(paste0(i," "))
    nombreCol<-names(dat1)[i]
    vec1<-as.data.frame(dat1)[,nombreCol]
    type=internalfun.SummType(vec1,nombreCol,keyNamesMatch)
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
    if(type==6){
      df.keys=internalfun.Summary.factor(i,nombreCol,vec1,dataname1,df.keys)
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
  rep.levelcatkey=internalfun.seekRepeated(df.repeatedVars,TRUE,df.levels,df.category,df.keys)
  if(rep.levelcatkey$hasRepeated==TRUE){
    df.levels=rep.levelcatkey$df.filtered$df1
    df.category=rep.levelcatkey$df.filtered$df2
    df.keys=rep.levelcatkey$df.filtered$df2b
    df.repeatedVars=rep.levelcatkey$df.repeated
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
    print(paste0("Primary keys: ",paste(internalfun.findVarnames(df.primarykeys),collapse=", ")))
  }
  return(list("dataname"=dataname1,"df.keys"=df.keys,"df.repeatedVars"=df.repeatedVars,"df.primarykeys"=df.primarykeys,"df.bool"=df.bool,"df.levels"=df.levels,"df.category"=df.category,"df.onevalue"=df.onevalue,"df.NA"=df.NA,"df.num"=df.num,"df.text"=df.text))
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

  statistics=list()
  var.classif=list()
  var.status=list()

  cat(" \nExploring summaries: ")
  for(Exploration in listx) {
    dataname=Exploration$dataname
    cat(paste0(dataname,"... "))

    dataset.df.text=Exploration$df.text
    dataset.df.num=Exploration$df.num
    dataset.df.NA=Exploration$df.NA
    dataset.df.onevalue=Exploration$df.onevalue
    dataset.df.repeatedVars=Exploration$df.repeatedVars
    dataset.df.category=Exploration$df.category
    dataset.df.levels=Exploration$df.levels
    dataset.df.bool=Exploration$df.bool
    dataset.df.primarykeys=Exploration$df.primarykeys
    dataset.df.keys=Exploration$df.keys

    res.num.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.num,maxNApercentage)
    res.cat.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.category,maxNApercentage)
    res.bool.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.bool,maxNApercentage)
    res.levels.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.levels,maxNApercentage)
    res.keys.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.keys,maxNApercentage)

    dataset.df.num<-res.num.filtered$filtered.df
    dataset.df.category<-res.cat.filtered$filtered.df
    dataset.df.bool<-res.bool.filtered$filtered.df
    dataset.df.levels<-res.levels.filtered$filtered.df
    dataset.df.keys<-res.keys.filtered$filtered.df

    dataset.df.num.out<-res.num.filtered$excluded.df
    dataset.df.category.out<-res.cat.filtered$excluded.df
    dataset.df.bool.out<-res.bool.filtered$excluded.df
    dataset.df.levels.out<-res.levels.filtered$excluded.df
    dataset.df.keys.out<-res.keys.filtered$excluded.df

    dataset.df.text<-internalfun.removeRowNames(dataset.df.text)
    dataset.df.num<-internalfun.removeRowNames(dataset.df.num)
    dataset.df.NA<-internalfun.removeRowNames(dataset.df.NA)
    dataset.df.onevalue<-internalfun.removeRowNames(dataset.df.onevalue)
    dataset.df.repeatedVars<-internalfun.removeRowNames(dataset.df.repeatedVars)

    dataset.df.category<-internalfun.removeRowNames(dataset.df.category)
    dataset.df.levels<-internalfun.removeRowNames(dataset.df.levels)
    dataset.df.bool<-internalfun.removeRowNames(dataset.df.bool)
    dataset.df.primarykeys<-internalfun.removeRowNames(dataset.df.primarykeys)
    dataset.df.num<-internalfun.removeRowNames(dataset.df.num)
    dataset.df.keys<-internalfun.removeRowNames(dataset.df.keys)

    dataset.df.category.out<-internalfun.removeRowNames(dataset.df.category.out)
    dataset.df.levels.out<-internalfun.removeRowNames(dataset.df.levels.out)
    dataset.df.bool.out<-internalfun.removeRowNames(dataset.df.bool.out)
    dataset.df.num.out<-internalfun.removeRowNames(dataset.df.num.out)
    dataset.df.keys.out<-internalfun.removeRowNames(dataset.df.keys.out)

    ###################################
    ########Summary for each dataset
    #################################

    dataset.classif.useful.vars=list()
    dataset.classif.useful.vars$df.category=internalfun.findVarnames(dataset.df.category)
    dataset.classif.useful.vars$df.num=internalfun.findVarnames(dataset.df.num)
    dataset.classif.useful.vars$df.primarykeys=internalfun.findVarnames(dataset.df.primarykeys)
    dataset.classif.useful.vars$df.levels=internalfun.findVarnames(dataset.df.levels)
    dataset.classif.useful.vars$df.keys=internalfun.findVarnames(dataset.df.keys)
    dataset.classif.useful.vars$df.bool=internalfun.findVarnames(dataset.df.bool)

    dataset.classif.filteredbyNAs.vars=list()
    dataset.classif.filteredbyNAs.vars$df.category=internalfun.findVarnames(dataset.df.category.out)
    dataset.classif.filteredbyNAs.vars$df.num=internalfun.findVarnames(dataset.df.num.out)
    dataset.classif.filteredbyNAs.vars$df.levels=internalfun.findVarnames(dataset.df.levels.out)
    dataset.classif.filteredbyNAs.vars$df.keys=internalfun.findVarnames(dataset.df.keys.out)
    dataset.classif.filteredbyNAs.vars$df.bool=internalfun.findVarnames(dataset.df.bool.out)

    dataset.classif.unuseful.vars=list()
    dataset.classif.unuseful.vars$df.text=internalfun.findVarnames(dataset.df.text)
    dataset.classif.unuseful.vars$df.NA=internalfun.findVarnames(dataset.df.NA)
    dataset.classif.unuseful.vars$df.onevalue=internalfun.findVarnames(dataset.df.onevalue)
    dataset.classif.unuseful.vars$df.repeatedVars=internalfun.findVarnames(dataset.df.repeatedVars)

    dataset.status.included <-c(dataset.classif.useful.vars$df.category, dataset.classif.useful.vars$df.num, dataset.classif.useful.vars$df.primarykeys, dataset.classif.useful.vars$df.levels, dataset.classif.useful.vars$df.keys, dataset.classif.useful.vars$df.bool)
    dataset.status.excluded <- c(dataset.classif.filteredbyNAs.vars$df.category, dataset.classif.filteredbyNAs.vars$df.num, dataset.classif.filteredbyNAs.vars$df.level,  dataset.classif.filteredbyNAs.vars$df.keys, dataset.classif.filteredbyNAs.vars$df.bool, dataset.classif.unuseful.vars$df.text, dataset.classif.unuseful.vars$df.NA, dataset.classif.unuseful.vars$df.onevalue, dataset.classif.unuseful.vars$df.repeatedVars)

    dataset.statistics.useful.vars=list("df.keys"=dataset.df.keys,"df.primarykeys"=dataset.df.primarykeys,"df.bool"=dataset.df.bool,"df.levels"=dataset.df.levels,"df.category"=dataset.df.category,"df.num"=dataset.df.num)
    dataset.statistics.unuseful.vars=list("df.text"=dataset.df.text,"df.NA"=dataset.df.NA,"df.onevalue"=dataset.df.onevalue,"df.repeatedVars"=dataset.df.repeatedVars)
    dataset.statistics.filteredbyNAs.vars=list("df.keys"=dataset.df.keys.out,"df.bool"=dataset.df.bool.out,"df.levels"=dataset.df.levels.out,"df.category"=dataset.df.category.out,"df.num"=dataset.df.num.out)
    dataset.statistics=list("useful.vars"=dataset.statistics.useful.vars,"unuseful.vars"=dataset.statistics.unuseful.vars,"filteredbyNAs.vars"=dataset.statistics.filteredbyNAs.vars)
    dataset.var.classif=list("useful.vars"=dataset.classif.useful.vars,"unuseful.vars"=dataset.classif.unuseful.vars,"filteredbyNAs.vars"=dataset.classif.filteredbyNAs.vars)
    dataset.var.status=list("included"=dataset.status.included,"excluded"=dataset.status.excluded)
    statistics[[dataname]]=dataset.statistics
    var.classif[[dataname]]=dataset.var.classif
    var.status[[dataname]]=dataset.var.status
  }
  cat("\nDone!")
  return(list("statistics"=statistics,"var.classif"=var.classif,"var.status"=var.status))
}
