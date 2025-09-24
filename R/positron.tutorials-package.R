#' Positron Tutorials
#'
#' A comprehensive collection of interactive tutorials covering Positron and modern 
#' development workflows, R for Data Science essentials, and US Census data analysis.
#' This package makes extensive use of the tools in the tutorial.helpers package.
#'
#' @description
#' The positron.tutorials package provides interactive tutorials in three main categories:
#' Positron and modern development tools, R for Data Science fundamentals, and
#' US Census data analysis. The R for Data Science tutorials are based on 
#' \href{https://r4ds.hadley.nz/}{\emph{R for Data Science (2e)}} by Hadley Wickham, 
#' Mine Çetinkaya-Rundel, and Garrett Grolemund. The Census tutorial draws from 
#' \href{https://walker-data.com/census-r/}{\emph{Analyzing US Census Data: Methods, Maps, and Models in R}} 
#' by Kyle Walker.
#'
#' @section Positron and Development Tools Tutorials:
#' The package includes seven tutorials focused on Positron and modern R development:
#' \itemize{
#'   \item \strong{Positron and Code} (01-code): Introduction to Positron and writing R code in simple scripts
#'   \item \strong{Positron and Quarto} (02-quarto): Advanced R coding tricks in Positron and Quarto document creation
#'   \item \strong{Terminal} (03-terminal): Command line fundamentals
#'   \item \strong{Positron and GitHub Introduction} (04-github-1): Git and GitHub basics within Positron
#'   \item \strong{Positron and GitHub Advanced} (05-github-2): Advanced Git/GitHub workflows and GitHub Pages
#'   \item \strong{Quarto Websites Introduction} (06-websites-1): Basic website construction using Quarto projects
#'   \item \strong{Quarto Websites Advanced} (07-websites-2): Advanced Quarto websites with modular data analysis
#' }
#'
#' @section R for Data Science Tutorials:
#' The package includes five r4ds tutorials (r4ds-1 through r4ds-5) that cover:
#' \itemize{
#'   \item Data import and visualization
#'   \item Data transformations and tidying
#'   \item Working with databases, strings, and regular expressions
#'   \item Factors, dates, times, and joins
#'   \item Web scraping, functions, and iterations
#' }
#'
#' @section Census Data Tutorial:
#' The tidycensus-1 tutorial covers working with US Census data using the
#' tidycensus package.
#'
#' @section Running Tutorials:
#' To run a tutorial, use:
#' \code{learnr::run_tutorial(name = "short_tutorial_name", package = "positron.tutorials")}
#'
#' Available tutorial names include: 01-code, 02-quarto, 03-terminal, 04-github-1, 
#' 05-github-2, 06-websites-1, 07-websites-2, r4ds-1, r4ds-2, r4ds-3, r4ds-4, 
#' r4ds-5, and tidycensus-1.
#'
#' @keywords internal
"_PACKAGE"