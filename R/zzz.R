# R/zzz.R
.onAttach <- function(libname, pkgname) {
  tutorials_path <- system.file("tutorials", package = "positron.tutorials")
  
  # Count tutorials with data directories
  tutorials_with_data <- 0
  
  if (dir.exists(tutorials_path)) {
    tutorial_dirs <- list.dirs(tutorials_path, full.names = FALSE, recursive = FALSE)
    
    for (tutorial in tutorial_dirs) {
      data_dir <- file.path(tutorials_path, tutorial, "data")
      if (dir.exists(data_dir)) {
        tutorials_with_data <- tutorials_with_data + 1
      }
    }
  }
  
  # Only show message if fewer than 3 tutorials have data
  if (tutorials_with_data < 3) {
    packageStartupMessage(
      "It looks like you don't have the data necessary for running the tutorials in this package. ",
      "To get that data, run `setup_tutorial_data()` from the Console. ",
      "Then, restart R. If the tutorials don't work after you do this, ",
      "then your best bet is to install the development version of the package by running ",
      "`pak::pak(\"PPBDS/positron.tutorials\")` at the Console and then restart R."
    )
  }
}
