test_that("secop1 works", {
  RESULT=FALSE

  dim(secop1.full)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

test_that("secop1.multas works", {
  RESULT=FALSE

  dim(secop1.multas)

  RESULT=TRUE
  expect_equal(RESULT, TRUE)
})

