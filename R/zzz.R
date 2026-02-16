# The data files used by several tutorials (r4ds-1 through r4ds-5,
# tidycensus-1) are too large to include in the CRAN package. However, when a
# tutorial is run via learnr::run_tutorial(), the working directory is set to
# the directory containing the tutorial.Rmd file. Code like
# open_dataset("data/game.parquet") works because it resolves relative to that
# directory. So the data files must exist in each tutorial's data/ subdirectory
# within the installed package.
#
# When installing from GitHub, the data files are included in inst/tutorials/
# and get installed normally. But the CRAN version ships without them. The
# .onAttach() hook below checks for missing data files on package load and
# downloads them from GitHub directly into the installed package directory. This
# is safe because if a user has permission to install the package, they have
# permission to write into its directory. The manifest below must be updated
# whenever data files are added or removed from any tutorial.

#' @importFrom utils download.file
NULL

data_manifest <- list(
  "r4ds-1" = c("music_1.csv", "music_fake.csv", "music.csv"),
  "r4ds-2" = c("cheeses.xlsx", "wine.xlsx"),
  "r4ds-3" = c("nameby_year.duckdb", "nycflights13.duckdb"),
  "r4ds-4" = c("fifa.parquet", "game.parquet", "line_score.parquet"),
  "r4ds-5" = c("earthquakes.geojson"),
  "tidycensus-1" = c("age_ca.rds", "edu_ca.rds", "income_tx.rds")
)

.onAttach <- function(libname, pkgname) {
  
  base_url <- "https://raw.githubusercontent.com/PPBDS/positron.tutorials/main/inst/tutorials"
  files_downloaded <- character(0)
  
  for (tut in names(data_manifest)) {
    
    local_tut_dir <- system.file("tutorials", tut, package = pkgname)
    
    # Skip tutorials not in the installed version
    if (!nzchar(local_tut_dir)) next
    
    local_data_dir <- file.path(local_tut_dir, "data")
    
    # Check which files are missing
    if (dir.exists(local_data_dir)) {
      local_files <- list.files(local_data_dir)
      missing <- setdiff(data_manifest[[tut]], local_files)
    } else {
      missing <- data_manifest[[tut]]
    }
    
    if (length(missing) == 0) next
    
    # Create data directory if needed
    if (!dir.exists(local_data_dir)) {
      dir.create(local_data_dir, recursive = TRUE)
    }
    
    # Download missing files
    for (f in missing) {
      dest <- file.path(local_data_dir, f)
      result <- tryCatch({
        download.file(
          paste0(base_url, "/", tut, "/data/", f),
          dest,
          mode = "wb",
          quiet = TRUE
        )
        TRUE
      }, error = function(e) FALSE)
      
      if (result) {
        files_downloaded <- c(files_downloaded, file.path(tut, "data", f))
      }
    }
  }
  
  # Only print if we downloaded something
  if (length(files_downloaded) > 0) {
    packageStartupMessage(
      "positron.tutorials: Downloaded ", length(files_downloaded), " data file(s):\n",
      paste0("  ", files_downloaded, collapse = "\n")
    )
  }
}
