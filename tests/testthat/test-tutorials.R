test_that("tutorial paths can be found", {
  tutorial_paths <- tutorial.helpers::return_tutorial_paths(package = "positron.tutorials")
  expect_true(length(tutorial_paths) > 0)
})

test_that("tutorials can be knitted", {
  testthat::skip_on_cran() # Needed because the data directories are not on CRAN.
  
  tutorial_paths <- tutorial.helpers::return_tutorial_paths(package = "positron.tutorials")
  tutorial.helpers::knit_tutorials(tutorial_paths)
})

test_that("tutorials have default components", {
  tutorial_paths <- tutorial.helpers::return_tutorial_paths(package = "positron.tutorials")
  tutorial.helpers::check_tutorial_defaults(tutorial_paths)
})