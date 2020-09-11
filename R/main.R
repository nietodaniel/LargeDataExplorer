main.ExploreFull<-function(dat,dataname,keyNamesMatch,maxNARate){
  if(ncol(dat)<2 || ncol(dat)<2){
    stop(paste0(dataname," is not a data.frame"))
  }
  if(!(is.null(maxNARate))){
    if(!(is.numeric(maxNARate)) || maxNARate<0 || maxNARate>1){
      stop("maxNARate must be a value between 0 and 1")
    }
  }
  dat=data.frame(dat)
  if(sum(is.na(dat))==0 && sum(which(dat==""))){
    print("There are no NAs, may be you should use dat[dat==\"\"]<-NA to convert empty strings to NAs")
  }
  tmp.Explore<-core.ExploreDataset(dat,dataname,keyNamesMatch)
  tmp.UsefulVars<-core.UsefulVars(maxNARate,tmp.Explore)
  return(list("statistics"=tmp.UsefulVars$statistics[[dataname]],"var.classif"=tmp.UsefulVars$var.classif[[dataname]],"var.status"=tmp.UsefulVars$var.status[[dataname]]))
}

main.AutoProcess<-function(dat,dataname,keyNamesMatch,maxNARate){
  res=main.ExploreFull(dat,dataname,keyNamesMatch,maxNARate)
  dat=data.frame(dat)
  included.vars<-res$var.status$included
  dat.filtered<-subset(dat,select=included.vars)
  ### Unuseful variable removal and type transformation
  for (varname in res$var.classif$useful.vars$df.primarykeys) {
    dat.filtered[,varname]=as.character(dat.filtered[,varname])
  }
  for (varname in res$var.classif$useful.vars$df.date) {
    dat.filtered[,varname]=as.character(dat.filtered[,varname])
  }
  for (varname in res$var.classif$useful.vars$df.keys) {
    dat.filtered[,varname]=as.character(dat.filtered[,varname])
  }
  for (varname in res$var.classif$useful.vars$df.category) {
    dat.filtered[,varname]=as.factor(dat.filtered[,varname])
  }
  for (varname in res$var.classif$useful.vars$df.num) {
    dat.filtered[,varname]=utils.ConvertNumeric(dat.filtered[,varname],varname)
  }
  for (varname in res$var.classif$useful.vars$df.levels) {
    dat.filtered[,varname]=as.factor(as.numeric(dat.filtered[,varname]))
  }
  i_bool=0
  for (varname in res$var.classif$useful.vars$df.bool) {
    i_bool=i_bool+1
    modelvl=res$statistics$useful.vars$df.bool$modelvl[i_bool]
    newvalues=as.factor(as.numeric(ifelse((dat[,varname]==modelvl)==TRUE,1,0)))
    newname=gsub(' ','_',modelvl)
    newname=paste0(newname,"_is",newname)
    dat.filtered[,varname]=newvalues
    var_index=which( colnames(dat.filtered)==varname )
    names(dat.filtered)[var_index]=newname
    old.bool.vector<-res$statistics$useful.vars$df.bool[i_bool,]
    #Changing name in statistics
    new.bool.stat.values<-summarizer.bool.base(var_index,varname,newvalues,dataname)
    res$statistics$useful.vars$df.bool[i_bool,]=new.bool.stat.values
  }

  return(list("df.filtered"=dat.filtered,"statistics"=res$statistics,"var.classif"=res$var.classif,"var.status"=res$var.status))
}
