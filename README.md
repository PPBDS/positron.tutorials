
<!-- README.md is generated from README.Rmd. Edit ONLY this file if you need to make a change in README.md. But, after you edit it, you run `rmarkdown::render("README.Rmd")` in order to create the new README.md, which is the thing which is actually used. Must be a better way of doing this! -->

# Positron Tutorials

<!-- badges: start -->

[![R build
status](https://github.com/PPBDS/positron.tutorials/workflows/R-CMD-check/badge.svg)](https://github.com/PPBDS/positron.tutorials/actions)
<!-- badges: end -->

## About this package

**positron.tutorials** is a collection of tutorials for working with
Positron. Covers scripts, Quarto documents, git, Github, and Quarto
websites. Makes extensive use of the tools in the
**[tutorial.helpers](https://ppbds.github.io/tutorial.helpers/)**
package.

## Installation

To install the package from CRAN:

``` r
install.packages("positron.tutorials")
```

However, the CRAN package does not include the data necessary for
running the tutorials. The best solution is to install the development
version from [GitHub](https://github.com/) with:

``` r
remotes::install_github("PPBDS/positron.tutorials")
```

However, if you want to use the CRAN version, then, when you first load
the library, you will be prompted to run `setup_tutorial_data()` at the
Console in order to download the necessary data.

## Tutorials

There are many tutorials in the package. To run a tutorial, use
`learnr::run_tutorial()`, providing the short name of the tutorial and
the package name.

    learnr::run_tutorial(name = "01-code", 
                         package = "positron.tutorials")

### Positron Tutorials

The core tutorials introduce students to the Positron integrated
development environment.

- *Positron and Code* (“01-code”). Introduce students to Positron and to
  writing R code in simple scripts.

- *Positron and Quarto* (“02-quarto”). Demonstrate more tricks for
  working with R code using Positron, and also explain Quarto documents.

- *Terminal* (“03-terminal”). Teach the command line.

- *Positron and GitHub Introduction* (“04-github-1”). Explain the basics
  of Git and GitHub, mostly in the context of Positron.

- *Positron and GitHub Advanced* (“05-github-2”). Provide more practice
  in working with Git/GitHub, including more details on the use of
  GitHub Pages.

- *Quarto Websites Introduction* (“06-websites-1”). Demonstrate the
  basics of website construction using Quarto projects.

- *Quarto Websites Advanced* (“07-websites-2”). Practice Quarto
  websites, with a focus on splitting data analysis tasks into separate
  files.

### R for Data Science

These tutorials cover material from [*R for Data Science
(2e)*](https://r4ds.hadley.nz/) (R4DS) by Hadley Wickham, Mine
Çetinkaya-Rundel, and Garrett Grolemund. There are five related
tutorials in the package: `r4ds-1`, `r4ds-2`, `r4ds-3`, `r4ds-4`, and
`r4ds-5`. Different tutorials cover different chapters from the book as
follows.

#### r4ds-1

Data import  
Data visualization  
Data transformations  
Data tidying

#### r4ds-2

Spreadsheets  
Layers  
Exploratory data analysis  
Communication

#### r4ds-3

Databases  
Logical vectors  
Numbers  
Strings  
Regular expressions

#### r4ds-4

Arrow  
Factors  
Dates and times  
Missing values  
Joins

#### r4ds-5

Hierarchical-data  
Web scraping  
Functions  
Iterations

The organization of the tutorials is not the same as the organization of
R4DS. Instead, each tutorial begins by sourcing data from a different
sort of storage technology and then working with that data.

### Analyzing US Census Data

We have one tutorial, `tidycensus-1`, covering material from [*Analyzing
US Census Data: Methods, Maps, and Models in
R*](https://walker-data.com/census-r/index.html) by Kyle Walker.
