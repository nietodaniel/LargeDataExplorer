test_that("Explore iris work", {
  RESULT=FALSE
  dat <- (iris)

  Explore <- LDE.Explore(dat)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore key-iris work", {
  RESULT=FALSE
  dat <- (iris)

  keyNamesMatch<-c("ID","KEY")

  Explore <- LDE.Explore(dat,keyNamesMatch)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore na-iris work", {
  RESULT=FALSE
  dat <- (iris)

  maxNARate <- 0.2
  Explore <- LDE.Explore(dat,NULL,maxNARate)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore na-key-iris work", {
  RESULT=FALSE
  dat <- (iris)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  Explore <- LDE.Explore(dat,keyNamesMatch,maxNARate)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

#####################
#####################

test_that("Explore multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  Explore <- LDE.Explore(dat)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore key-multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  keyNamesMatch<-c("ID","KEY")

  Explore <- LDE.Explore(dat,keyNamesMatch)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore NA-multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  maxNARate <- 0.2
  Explore <- LDE.Explore(dat,NULL,maxNARate)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore NA-KEY-multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  Explore <- LDE.Explore(dat,keyNamesMatch,maxNARate)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

#####################
#####################

test_that("Explore full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  Explore <- LDE.Explore(dat)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore key-full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  keyNamesMatch<-c("ID","KEY")

  Explore <- LDE.Explore(dat,keyNamesMatch)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore NA-full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  maxNARate <- 0.2
  Explore <- LDE.Explore(dat,NULL,maxNARate)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Explore NA-KEY-full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  Explore <- LDE.Explore(dat,keyNamesMatch,maxNARate)

  autotest.exports.filestructure(Explore)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

#####################
#####################
test_that("Auto multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  Auto <- LDE.AutoProcess(dat)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto key-multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  keyNamesMatch<-c("ID","KEY")

  Auto <- LDE.AutoProcess(dat,keyNamesMatch)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto na-multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  maxNARate <- 0.2

  Auto <- LDE.AutoProcess(dat,NULL,maxNARate)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto na-key-multas works", {
  RESULT=FALSE
  dat <- (secop1.multas)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  Auto <- LDE.AutoProcess(dat,keyNamesMatch,maxNARate)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

#####################
#####################
test_that("Auto full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  Auto <- LDE.AutoProcess(dat)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto key-full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  keyNamesMatch<-c("ID","KEY")

  Auto <- LDE.AutoProcess(dat,keyNamesMatch)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto na-full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  maxNARate <- 0.2

  Auto <- LDE.AutoProcess(dat,NULL,maxNARate)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto na-key-full works", {
  RESULT=FALSE
  dat <- (secop1.full)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  Auto <- LDE.AutoProcess(dat,keyNamesMatch,maxNARate)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

#####################
#####################
test_that("Auto iris works", {
  RESULT=FALSE
  dat <- (iris)

  Auto <- LDE.AutoProcess(dat)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto key-iris works", {
  RESULT=FALSE
  dat <- (iris)

  keyNamesMatch<-c("ID","KEY")

  Auto <- LDE.AutoProcess(dat,keyNamesMatch)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto na-iris works", {
  RESULT=FALSE
  dat <- (iris)

  maxNARate <- 0.2

  Auto <- LDE.AutoProcess(dat,NULL,maxNARate)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("Auto na-key-iris works", {
  RESULT=FALSE
  dat <- (iris)

  maxNARate <- 0.2
  keyNamesMatch<-c("ID","KEY")

  Auto <- LDE.AutoProcess(dat,keyNamesMatch,maxNARate)

  #Obtention of the cleaned dataset
  dat.clean<-Auto$df.filtered

  autotest.exports.filestructure(Auto)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})
