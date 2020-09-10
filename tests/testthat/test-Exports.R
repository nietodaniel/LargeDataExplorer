test_that("Explore works-full", {
  RESULT=FALSE
  df <- data.frame(secop1.multas)
  keyNamesMatch<-c("ID","KEY")

  #Basic Exploring of the data.frame
  Explore.1.df <- LDE.Explore(df)

  #Using only substrings to identify variables names as keys
  Explore.2.df <- LDE.Explore(df,keyNamesMatch)

  #View which variables are of each type and its characteristics
  length(Explore.2.df$dataname) #View dataname
  length(Explore.2.df$df.text) #Variables of text type
  length(Explore.2.df$df.num) #Variables of numeric type
  length(Explore.2.df$df.NA) #Empty variables
  length(Explore.2.df$df.univalue) #Variables with only one value
  length(Explore.2.df$df.category) #Variables of categorical (text) type
  length(Explore.2.df$df.levels) #Variables of categorical (numeric) type
  length(Explore.2.df$df.bool) #Variables of bool type
  length(Explore.2.df$df.primarykeys) #Variables which could be primary keys
  length(Explore.2.df$df.keys) #Variables which could be keys
  length(Explore.2.df$df.repeatedVars) #Variables with repeated information
  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore works-multas", {
  RESULT=FALSE
  df <- data.frame(secop1.multas)
  keyNamesMatch<-c("ID","KEY")

  #Basic Exploring of the data.frame
  Explore.1.df <- LDE.Explore(df)

  #Using only substrings to identify variables names as keys
  Explore.2.df <- LDE.Explore(df,keyNamesMatch)

  #View which variables are of each type and its characteristics
  length(Explore.2.df$dataname) #View dataname
  length(Explore.2.df$df.text) #Variables of text type
  length(Explore.2.df$df.num) #Variables of numeric type
  length(Explore.2.df$df.NA) #Empty variables
  length(Explore.2.df$df.univalue) #Variables with only one value
  length(Explore.2.df$df.category) #Variables of categorical (text) type
  length(Explore.2.df$df.levels) #Variables of categorical (numeric) type
  length(Explore.2.df$df.bool) #Variables of bool type
  length(Explore.2.df$df.primarykeys) #Variables which could be primary keys
  length(Explore.2.df$df.keys) #Variables which could be keys
  length(Explore.2.df$df.repeatedVars) #Variables with repeated information
  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto works-multas", {
  RESULT=FALSE
  dat <- data.frame(secop1.multas)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  #Basic AutoProcess of the data.frame
  Auto.1.dat <- LDE.AutoProcess(dat)

  #Using a Max Rate of NA per variable
  Auto.2.dat <- LDE.AutoProcess(dat,maxNARate)

  #Using substrings to identify variables names as keys, but without NAs filtering
  Auto.3.dat <- LDE.AutoProcess(dat,NULL,keyNamesMatch)

  #Using Max Rate of NAs and substrings to identify variables names as keys
  Auto.4.dat <- LDE.AutoProcess(dat,maxNARate,keyNamesMatch)

  #Obtention of the cleaned dataset
  dat.clean<-Auto.4.dat$df.filtered

  #See if variables were included or excluded
  length(Auto.4.dat$var.status$included) #included vars
  length(Auto.4.dat$var.status$excluded) #excluded vars

  #See how the included variables were classified E.g.:
  length(Auto.4.dat$var.classif$included.vars$df.num) #numeric variables
  length(Auto.4.dat$var.classif$included.vars$df.bool) #boolean variables

  #See how the excluded variables were classified E.g.:
  length(Auto.4.dat$var.classif$removed.vars$not.useful) #see variables excluded for not being useful
  length(Auto.4.dat$var.classif$removed.vars$filtered.byNAs) #see variables excluded by NA threshold
  length(Auto.4.dat$var.classif$removed.vars$not.useful$df.NA) #see variables excluded for not being useful because they were NAs
  length(Auto.4.dat$var.classif$removed.vars$filtered.byNAs$df.num) #see variables excluded by NA threshold that were numeric

  #See statistics of variables by exclusion reason
  length(Auto.4.dat$statistics$useful.vars) #of usefulvars
  length(Auto.4.dat$statistics$filteredbyNAs.vars) #of variables filtered out by NAs
  length(Auto.4.dat$statistics$unuseful.vars) #of unusefulvars

  #See statistics of variables by exclusion reason and type E.g.:
  length(Auto.4.dat$statistics$useful.vars$df.levels) #of usefulvars that were levels
  length(Auto.4.dat$statistics$filteredbyNAs.vars$df.num) #of variables filtered that were numeric
  length(Auto.4.dat$statistics$unuseful.vars$df.NA) #of unusefulvars that were NAs
  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})


test_that("Auto works-full", {
  RESULT=FALSE
  dat <- data.frame(secop1.full)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  #Basic AutoProcess of the data.frame
  Auto.1.dat <- LDE.AutoProcess(dat)

  #Using a Max Rate of NA per variable
  Auto.2.dat <- LDE.AutoProcess(dat,maxNARate)

  #Using substrings to identify variables names as keys, but without NAs filtering
  Auto.3.dat <- LDE.AutoProcess(dat,NULL,keyNamesMatch)

  #Using Max Rate of NAs and substrings to identify variables names as keys
  Auto.4.dat <- LDE.AutoProcess(dat,maxNARate,keyNamesMatch)

  #Obtention of the cleaned dataset
  dat.clean<-Auto.4.dat$df.filtered

  #See if variables were included or excluded
  length(Auto.4.dat$var.status$included) #included vars
  length(Auto.4.dat$var.status$excluded) #excluded vars

  #See how the included variables were classified E.g.:
  length(Auto.4.dat$var.classif$included.vars$df.num) #numeric variables
  length(Auto.4.dat$var.classif$included.vars$df.bool) #boolean variables

  #See how the excluded variables were classified E.g.:
  length(Auto.4.dat$var.classif$removed.vars$not.useful) #see variables excluded for not being useful
  length(Auto.4.dat$var.classif$removed.vars$filtered.byNAs) #see variables excluded by NA threshold
  length(Auto.4.dat$var.classif$removed.vars$not.useful$df.NA) #see variables excluded for not being useful because they were NAs
  length(Auto.4.dat$var.classif$removed.vars$filtered.byNAs$df.num) #see variables excluded by NA threshold that were numeric

  #See statistics of variables by exclusion reason
  length(Auto.4.dat$statistics$useful.vars) #of usefulvars
  length(Auto.4.dat$statistics$filteredbyNAs.vars) #of variables filtered out by NAs
  length(Auto.4.dat$statistics$unuseful.vars) #of unusefulvars

  #See statistics of variables by exclusion reason and type E.g.:
  length(Auto.4.dat$statistics$useful.vars$df.levels) #of usefulvars that were levels
  length(Auto.4.dat$statistics$filteredbyNAs.vars$df.num) #of variables filtered that were numeric
  length(Auto.4.dat$statistics$unuseful.vars$df.NA) #of unusefulvars that were NAs
  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Useful var works", {
  RESULT=FALSE
  df.secop1.full <- data.frame(secop1.full)
  df.secop1.multas <- data.frame(secop1.multas)
  Explore.1.full <- LDE.Explore(df.secop1.full)
  Explore.1.multas <- LDE.Explore(df.secop1.multas)
  maxNARate <- 0.2

  #Basic variable filtering of a single dataset exploration
  UsefulVars.1.iris <- LDE.UsefulVars(NULL,Explore.1.full)

  #Basic variable filtering of a multiple datasets explortaions
  UsefulVars.1.multi <- LDE.UsefulVars(NULL,Explore.1.full,Explore.1.multas)

  #Variable filtering, including NA threshold, using multiple datasets explortaions
  UsefulVars.2.multi <- LDE.UsefulVars(maxNARate,Explore.1.full,Explore.1.multas)

  #Iris dataset: See if variables were included or excluded
  length(UsefulVars.2.multi$var.status$df.secop1.full$included) #included vars
  length(UsefulVars.2.multi$var.status$df.secop1.full$excluded) #excluded vars

  #Iris dataset: See how the included variables were classified E.g.:
  length(UsefulVars.2.multi$var.classif$df.secop1.full$included.vars$df.num) #numeric variables
  length(UsefulVars.2.multi$var.classif$df.secop1.full$included.vars$df.bool) #boolean variables

  #Iris dataset: See how the excluded variables were classified E.g.:
  length(UsefulVars.2.multi$var.classif$df.secop1.full$removed.vars$not.useful) #see variables excluded for not being useful
  length(UsefulVars.2.multi$var.classif$df.secop1.full$removed.vars$filtered.byNAs) #see variables excluded by NA threshold
  length(UsefulVars.2.multi$var.classif$df.secop1.full$removed.vars$not.useful$df.NA) #see variables excluded for not being useful because they were NAs
  length(UsefulVars.2.multi$var.classif$df.secop1.full$removed.vars$filtered.byNAs$df.num) #see variables excluded by NA threshold that were numeric

  #Iris dataset: See statistics of variables by exclusion reason
  length(UsefulVars.2.multi$statistics$df.secop1.full$useful.vars) #of usefulvars
  length(UsefulVars.2.multi$statistics$df.secop1.full$filteredbyNAs.vars) #of variables filtered out by NAs
  length(UsefulVars.2.multi$statistics$df.secop1.full$unuseful.vars) #of unusefulvars

  #Iris dataset: See statistics of variables by exclusion reason and type E.g.:
  length(UsefulVars.2.multi$statistics$df.secop1.full$useful.vars$df.levels) #of usefulvars that were levels
  length(UsefulVars.2.multi$statistics$df.secop1.full$filteredbyNAs.vars$df.num) #of variables filtered that were numeric
  length(UsefulVars.2.multi$statistics$df.secop1.full$unuseful.vars$df.NA) #of unusefulvars that were NAs
  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})
