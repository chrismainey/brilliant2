test_that("CI upper is higher than CI lower", {
  expect_gt(my_CI_upper(100,10),my_CI_lower(100,10))
})

test_that("returns are numeric", {
  expect_type(my_CI_lower(100,10),type = "double")
  expect_type(my_CI_upper(100,10),type = "double")

})
