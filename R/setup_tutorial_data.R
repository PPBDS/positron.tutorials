# R/setup_tutorial_data.R

#' Setup tutorial data by downloading from GitHub
#' 
#' Downloads data directories from GitHub repository for installed tutorials
#' 
#' @param verbose Logical. If TRUE, provides detailed progress information. Default is FALSE.
#' @return Invisible NULL. Called for side effects.
#' @importFrom utils download.file unzip
#' @export

setup_tutorial_data <- function(verbose = FALSE) {
  
  # Step 1: Figure out all installed tutorials
  tutorials_path <- system.file("tutorials", package = "positron.tutorials")
  
  if (!dir.exists(tutorials_path)) {
    stop("No tutorials directory found in installed package")
  }
  
  installed_tutorials <- list.dirs(tutorials_path, full.names = FALSE, recursive = FALSE)
  
  if (length(installed_tutorials) == 0) {
    stop("No tutorials found in installed package")
  }
  
  if (verbose) {
    message("Found ", length(installed_tutorials), " installed tutorials:")
    for (tut in installed_tutorials) {
      message("  - ", tut)
    }
  }
  
  # Step 2: Download the entire repository as ZIP first
  temp_dir <- tempdir()
  temp_repo_zip <- file.path(temp_dir, "repo.zip")
  
  if (verbose) message("\nDownloading repository archive...")
  
  download_url <- "https://github.com/PPBDS/positron.tutorials/archive/refs/heads/main.zip"
  
  tryCatch({
    download.file(download_url, temp_repo_zip, mode = "wb", quiet = !verbose)
  }, error = function(e) {
    stop("Failed to download repository: ", e$message)
  })
  
  if (verbose) message("Extracting data directories...")
  
  # Get list of all files in the ZIP
  zip_contents <- utils::unzip(temp_repo_zip, list = TRUE)
  
  successfully_updated <- character(0)
  tutorials_with_data <- character(0)
  
  # Step 3: Process each installed tutorial
  for (tutorial in installed_tutorials) {
    if (verbose) message("\nProcessing tutorial: ", tutorial)
    
    local_data_dir <- file.path(tutorials_path, tutorial, "data")
    
    # Find files in this tutorial's data directory in the ZIP
    pattern <- paste0("positron.tutorials-main/inst/tutorials/", tutorial, "/data/")
    data_files <- zip_contents$Name[grepl(pattern, zip_contents$Name, fixed = TRUE)]
    
    # Filter out the directory entry itself, keep only actual files
    data_files <- data_files[!endsWith(data_files, "/")]
    
    if (length(data_files) > 0) {
      tutorials_with_data <- c(tutorials_with_data, tutorial)
      
      if (verbose) message("  Found ", length(data_files), " data files on GitHub")
      
      # Check if data directory exists locally
      if (dir.exists(local_data_dir)) {
        if (verbose) message("  Replacing existing data directory")
        unlink(local_data_dir, recursive = TRUE)
      } else {
        if (verbose) message("  Creating new data directory")
      }
      
      # Extract the data files
      utils::unzip(temp_repo_zip, files = data_files, exdir = temp_dir, junkpaths = FALSE)
      
      # Move to the correct location
      extracted_data_dir <- file.path(temp_dir, "positron.tutorials-main", "inst", "tutorials", tutorial, "data")
      
      if (dir.exists(extracted_data_dir)) {
        # Create the local data directory
        dir.create(local_data_dir, recursive = TRUE, showWarnings = FALSE)
        
        # Copy all files from extracted directory to local
        files_to_copy <- list.files(extracted_data_dir, full.names = TRUE)
        
        for (file in files_to_copy) {
          file.copy(file, local_data_dir, recursive = TRUE)
        }
        
        successfully_updated <- c(successfully_updated, tutorial)
        if (verbose) message("  Successfully updated data for ", tutorial)
      } else {
        if (verbose) message("  Warning: Could not extract data files")
      }
      
    } else {
      if (verbose) message("  No data directory found on GitHub")
    }
  }
  
  # Clean up temporary files
  unlink(temp_repo_zip)
  unlink(file.path(temp_dir, "positron.tutorials-main"), recursive = TRUE)
  
  # Summary
  if (verbose || length(successfully_updated) > 0) {
    message("\n=== Summary ===")
    message("Installed tutorials: ", length(installed_tutorials))
    message("Tutorials with data on GitHub: ", length(tutorials_with_data))
    message("Successfully updated: ", length(successfully_updated))
    
    if (length(successfully_updated) > 0) {
      message("\nUpdated tutorials:")
      for (tut in successfully_updated) {
        local_data_dir <- file.path(tutorials_path, tut, "data")
        n_files <- length(list.files(local_data_dir))
        message("  - ", tut, " (", n_files, " files)")
      }
    }
  }
  
  invisible(NULL)
}