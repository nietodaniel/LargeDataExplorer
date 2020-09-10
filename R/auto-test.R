autotest.listOk<-function(nameInList,list,listname){
  if(nameInList %in% names(list)==FALSE){
    stop(paste0("[Not Exists] ",listname,": ",nameInList,"\n","Names: ",paste(names(list),collapse=", ")))
  }
}

autotest.list.not<-function(nameInList,list,listname){
  if(nameInList %in% names(list)==TRUE){
    stop(paste0("[Exists] ",listname,": ",nameInList,"\n","Names: ",paste(names(list),collapse=", ")))
  }
}

autotest.list.Ok.iterative<-function(names,list){
  listname=deparse(substitute(list))
  for(name in names){
    autotest.listOk(name,list,listname)
  }
}

autotest.list.not.iterative<-function(names,list){
  listname=deparse(substitute(list))
  for(name in names){
    autotest.list.not(name,list,listname)
  }
}




autotest.exports.filestructure<-function(res){
  autotest.list.Ok.iterative(c("statistics","var.classif","var.status"),res)

  autotest.list.Ok.iterative(c("included","excluded"),res$var.status)

  autotest.list.Ok.iterative(c("useful.vars","unuseful.vars","filteredbyNAs.vars"),res$var.classif)
  autotest.list.Ok.iterative(c("useful.vars","unuseful.vars","filteredbyNAs.vars"),res$var.classif)

  autotest.list.Ok.iterative(c("useful.vars","unuseful.vars","filteredbyNAs.vars"),res$statistics)
  autotest.list.Ok.iterative(c("useful.vars","unuseful.vars","filteredbyNAs.vars"),res$statistics)

  autotest.list.Ok.iterative(c("df.num","df.levels","df.bool","df.category","df.primarykeys","df.keys"),res$var.classif$useful.vars)
  autotest.list.not.iterative(c("df.text","df.NA","df.onevalue","df.repeatedVars"),res$var.classif$useful.vars)

  autotest.list.Ok.iterative(c("df.num","df.levels","df.bool","df.category"),res$var.classif$filteredbyNAs.vars)
  autotest.list.not.iterative(c("df.text","df.NA","df.onevalue","df.repeatedVars","df.keys","df.primarykeys"),res$var.classif$filteredbyNAs.vars)

  autotest.list.Ok.iterative(c("df.text","df.NA","df.onevalue","df.repeatedVars"),res$var.classif$unuseful.vars)
  autotest.list.not.iterative(c("df.num","df.levels","df.bool","df.category","df.primarykeys","df.keys"),res$var.classif$unuseful.vars)

  ###for statistics
  autotest.list.Ok.iterative(c("df.num","df.levels","df.bool","df.category","df.primarykeys","df.keys"),res$statistics$useful.vars)
  autotest.list.not.iterative(c("df.text","df.NA","df.onevalue","df.repeatedVars"),res$statistics$useful.vars)

  autotest.list.Ok.iterative(c("df.num","df.levels","df.bool","df.category"),res$statistics$filteredbyNAs.vars)
  autotest.list.not.iterative(c("df.text","df.NA","df.onevalue","df.repeatedVars","df.primarykeys","df.keys"),res$statistics$filteredbyNAs.vars)

  autotest.list.Ok.iterative(c("df.text","df.NA","df.onevalue","df.repeatedVars"),res$statistics$unuseful.vars)
  autotest.list.not.iterative(c("df.num","df.levels","df.bool","df.category","df.primarykeys","df.keys"),res$statistics$unuseful.vars)

}
