core.UsefulVars<-function(maxNARate,LargeDataExplorer.Explore1,...){
  filter.vars=FALSE
  if(!(is.null(maxNARate))){
    filter.vars=TRUE
    if(!(is.numeric(maxNARate)) || maxNARate<0 || maxNARate>1){
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
    dataset.df.date=Exploration$df.date
    dataset.df.NA=Exploration$df.NA
    dataset.df.onevalue=Exploration$df.onevalue
    dataset.df.repeatedVars=Exploration$df.repeatedVars
    dataset.df.category=Exploration$df.category
    dataset.df.levels=Exploration$df.levels
    dataset.df.bool=Exploration$df.bool
    dataset.df.primarykeys=Exploration$df.primarykeys
    dataset.df.keys=Exploration$df.keys

    res.num.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.num,maxNApercentage)
    res.date.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.date,maxNApercentage)
    res.cat.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.category,maxNApercentage)
    res.bool.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.bool,maxNApercentage)
    res.levels.filtered=internalfun.UsefulVars.filter(filter.vars,dataset.df.levels,maxNApercentage)

    dataset.df.num<-res.num.filtered$filtered.df
    dataset.df.date<-res.date.filtered$filtered.df
    dataset.df.category<-res.cat.filtered$filtered.df
    dataset.df.bool<-res.bool.filtered$filtered.df
    dataset.df.levels<-res.levels.filtered$filtered.df

    dataset.df.num.out<-res.num.filtered$excluded.df
    dataset.df.date.out<-res.date.filtered$excluded.df
    dataset.df.category.out<-res.cat.filtered$excluded.df
    dataset.df.bool.out<-res.bool.filtered$excluded.df
    dataset.df.levels.out<-res.levels.filtered$excluded.df

    dataset.df.text<-internalfun.removeRowNames(dataset.df.text)
    dataset.df.num<-internalfun.removeRowNames(dataset.df.num)
    dataset.df.NA<-internalfun.removeRowNames(dataset.df.NA)
    dataset.df.onevalue<-internalfun.removeRowNames(dataset.df.onevalue)
    dataset.df.repeatedVars<-internalfun.removeRowNames(dataset.df.repeatedVars)

    dataset.df.category<-internalfun.removeRowNames(dataset.df.category)
    dataset.df.date<-internalfun.removeRowNames(dataset.df.date)
    dataset.df.levels<-internalfun.removeRowNames(dataset.df.levels)
    dataset.df.bool<-internalfun.removeRowNames(dataset.df.bool)
    dataset.df.primarykeys<-internalfun.removeRowNames(dataset.df.primarykeys)
    dataset.df.num<-internalfun.removeRowNames(dataset.df.num)
    dataset.df.keys<-internalfun.removeRowNames(dataset.df.keys)

    dataset.df.category.out<-internalfun.removeRowNames(dataset.df.category.out)
    dataset.df.date.out<-internalfun.removeRowNames(dataset.df.date.out)
    dataset.df.levels.out<-internalfun.removeRowNames(dataset.df.levels.out)
    dataset.df.bool.out<-internalfun.removeRowNames(dataset.df.bool.out)
    dataset.df.num.out<-internalfun.removeRowNames(dataset.df.num.out)

    ###################################
    ########Summary for each dataset
    #################################

    dataset.classif.useful.vars=list("df.keys"=internalfun.findVarnames(dataset.df.keys),"df.primarykeys"=internalfun.findVarnames(dataset.df.primarykeys),"df.bool"=internalfun.findVarnames(dataset.df.bool),"df.levels"=internalfun.findVarnames(dataset.df.levels),"df.category"=internalfun.findVarnames(dataset.df.category),"df.num"=internalfun.findVarnames(dataset.df.num),"df.date"=internalfun.findVarnames(dataset.df.date))

    dataset.classif.filteredbyNAs.vars=list("df.bool"=internalfun.findVarnames(dataset.df.bool.out),"df.levels"=internalfun.findVarnames(dataset.df.levels.out),"df.category"=internalfun.findVarnames(dataset.df.category.out),"df.num"=internalfun.findVarnames(dataset.df.num.out),"df.date"=internalfun.findVarnames(dataset.df.date.out))

    dataset.classif.unuseful.vars=list("df.text"=internalfun.findVarnames(dataset.df.text),"df.NA"=internalfun.findVarnames(dataset.df.NA),"df.onevalue"=internalfun.findVarnames(dataset.df.onevalue),"df.repeatedVars"=internalfun.findVarnames(dataset.df.repeatedVars))



    dataset.status.included <-c(dataset.classif.useful.vars$df.category, dataset.classif.useful.vars$df.num,dataset.classif.useful.vars$df.date, dataset.classif.useful.vars$df.primarykeys, dataset.classif.useful.vars$df.levels, dataset.classif.useful.vars$df.keys, dataset.classif.useful.vars$df.bool)
    dataset.status.excluded <- c(dataset.classif.filteredbyNAs.vars$df.category, dataset.classif.filteredbyNAs.vars$df.num,dataset.classif.useful.vars$df.date, dataset.classif.filteredbyNAs.vars$df.level, dataset.classif.filteredbyNAs.vars$df.bool, dataset.classif.unuseful.vars$df.text, dataset.classif.unuseful.vars$df.NA, dataset.classif.unuseful.vars$df.onevalue, dataset.classif.unuseful.vars$df.repeatedVars)

    dataset.statistics.useful.vars=list("df.keys"=dataset.df.keys,"df.primarykeys"=dataset.df.primarykeys,"df.bool"=dataset.df.bool,"df.levels"=dataset.df.levels,"df.category"=dataset.df.category,"df.num"=dataset.df.num,"df.date"=dataset.df.date)
    dataset.statistics.unuseful.vars=list("df.text"=dataset.df.text,"df.NA"=dataset.df.NA,"df.onevalue"=dataset.df.onevalue,"df.repeatedVars"=dataset.df.repeatedVars)
    dataset.statistics.filteredbyNAs.vars=list("df.bool"=dataset.df.bool.out,"df.levels"=dataset.df.levels.out,"df.category"=dataset.df.category.out,"df.num"=dataset.df.num.out,"df.date"=dataset.df.date.out)
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
  df.date=NULL
  cat(paste0("\nProcessing ",ncol(dat1)," variables\nProcessed:"))
  for (i in 1:ncol(dat1)) {
    cat(paste0(i," "))
    nombreCol<-names(dat1)[i]
    vec1<-as.data.frame(dat1)[,nombreCol]
    type=classif.vartype(vec1,nombreCol,keyNamesMatch)
    cat(".")
    if(type==-2){
      df.onevalue=summarizer.err(i,nombreCol,df.onevalue)
    }
    if(type==-1){
      df.NA=summarizer.err(i,nombreCol,df.NA)
    }
    if(type==0){
      df.num=summarizer.num(i,nombreCol,vec1,dataname1,df.num)
    }
    if(type==1){
      df.category=summarizer.factor(i,nombreCol,vec1,dataname1,df.category)
    }
    if(type==2){
      df.levels=summarizer.factor(i,nombreCol,vec1,dataname1,df.levels)
    }
    if(type==3){
      df.bool=summarizer.bool(i,nombreCol,vec1,dataname1,df.bool)
    }
    if(type==4){
      df.text=summarizer.txt(i,nombreCol,vec1,dataname1,df.text)
    }
    if(type==5){
      df.primarykeys=summarizer.err(i,nombreCol,df.primarykeys)
    }
    if(type==6){
      df.keys=summarizer.factor(i,nombreCol,vec1,dataname1,df.keys)
    }
    if(type==7){
      df.date=summarizer.factor(i,nombreCol,vec1,dataname1,df.date)
    }
    cat(".")
  }
  cat("Done!\n")
  cat("Seeking repeated vars...\n")
  cat("Categorical")
  rep.category=internalfun.seekRepeated(df.repeatedVars,FALSE,TRUE,df.category)
  cat(".")
  if(rep.category$hasRepeated==TRUE){
    df.category=rep.category$df.filtered
    df.repeatedVars=rep.category$df.repeated
  }
  cat(".")
  cat("Levels")
  rep.levels=internalfun.seekRepeated(df.repeatedVars,FALSE,TRUE,df.levels)
  cat(".")
  if(rep.levels$hasRepeated==TRUE){
    df.levels=rep.levels$df.filtered
    df.repeatedVars=rep.levels$df.repeated
  }
  cat(".")
  cat("Booleans")
  rep.bool=internalfun.seekRepeated(df.repeatedVars,FALSE,TRUE,df.bool)
  cat(".")
  if(rep.bool$hasRepeated==TRUE){
    df.bool=rep.bool$df.filtered
    df.repeatedVars=rep.bool$df.repeated
  }
  cat(".")
  cat("Numeric")
  rep.num=internalfun.seekRepeated(df.repeatedVars,FALSE,FALSE,df.num)
  cat(".")
  if(rep.num$hasRepeated==TRUE){
    df.num=rep.num$df.filtered
    df.repeatedVars=rep.num$df.repeated
  }
  cat(".")
  cat("Date")
  rep.date=internalfun.seekRepeated(df.repeatedVars,FALSE,TRUE,df.date)
  cat(".")
  if(rep.date$hasRepeated==TRUE){
    df.date=rep.date$df.filtered
    df.repeatedVars=rep.date$df.repeated
  }
  cat(".")
  cat("Multi")
  rep.levelcatkey=internalfun.seekRepeated(df.repeatedVars,TRUE,TRUE,df.keys,df.levels,df.date,df.category)
  cat(".")
  if(rep.levelcatkey$hasRepeated==TRUE){
    df.keys=rep.levelcatkey$df.filtered$dat1
    df.levels=rep.levelcatkey$df.filtered$dat2
    df.date=rep.levelcatkey$df.filtered$dat3
    df.category=rep.levelcatkey$df.filtered$dat4
    df.repeatedVars=rep.levelcatkey$df.repeated
  }
  df.text<-utils.summ.Round(df.text,"txt")
  df.num<-utils.summ.Round(df.num,"num")
  df.category<-utils.summ.Round(df.category,"cat")
  df.levels<-utils.summ.Round(df.levels,"cat")
  df.bool<-utils.summ.Round(df.bool,"bool")
  df.date<-utils.summ.Round(df.date,"cat")
  df.keys<-utils.summ.Round(df.keys,"cat")

  cat(".\n")
  cat("Reordering statistics")
  if(!is.null(df.category)){
    df.category<-df.category[order(df.category$lvls,df.category$sd),]
    rownames(df.category)<-NULL
  }
  cat(".")
  if(!is.null(df.levels)){
    df.levels<-df.levels[order(df.levels$lvls,df.levels$sd),]
    rownames(df.levels)<-NULL
  }
  cat(".")
  if(!is.null(df.num)){
    rownames(df.num)<-NULL
  }
  cat(" Done!\n")
  if(is.null(df.primarykeys)){
    print("The dataset Has No primary Key")
  }else{
    print(paste0("Primary keys: ",paste(internalfun.findVarnames(df.primarykeys),collapse=", ")))
  }
  return(list("dataname"=dataname1,"df.keys"=df.keys,"df.repeatedVars"=df.repeatedVars,"df.primarykeys"=df.primarykeys,"df.bool"=df.bool,"df.levels"=df.levels,"df.category"=df.category,"df.onevalue"=df.onevalue,"df.NA"=df.NA,"df.num"=df.num,"df.text"=df.text,"df.date"=df.date))
}
