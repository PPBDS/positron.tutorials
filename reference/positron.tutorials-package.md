# Positron Tutorials

The positron.tutorials package provides interactive tutorials in three
main categories: Positron and modern development tools, R for Data
Science fundamentals, and US Census data analysis. The R for Data
Science tutorials are based on [*R for Data Science
(2e)*](https://r4ds.hadley.nz/) by Hadley Wickham, Mine
Çetinkaya-Rundel, and Garrett Grolemund. The Census tutorial draws from
[*Analyzing US Census Data: Methods, Maps, and Models in
R*](https://walker-data.com/census-r/) by Kyle Walker.

## Details

A comprehensive collection of interactive tutorials covering Positron
and modern development workflows, R for Data Science essentials, and US
Census data analysis. This package makes extensive use of the tools in
the tutorial.helpers package.

## Positron and Development Tools Tutorials

The package includes seven tutorials focused on Positron and modern R
development:

- **Positron and Code** (01-code): Introduction to Positron and writing
  R code in simple scripts

- **Positron and Quarto** (02-quarto): Advanced R coding tricks in
  Positron and Quarto document creation

- **Terminal** (03-terminal): Command line fundamentals

- **Positron and GitHub Introduction** (04-github-1): Git and GitHub
  basics within Positron

- **Positron and GitHub Advanced** (05-github-2): Advanced Git/GitHub
  workflows and GitHub Pages

- **Quarto Websites Introduction** (06-websites-1): Basic website
  construction using Quarto projects

- **Quarto Websites Advanced** (07-websites-2): Advanced Quarto websites
  with modular data analysis

## R for Data Science Tutorials

The package includes five r4ds tutorials (r4ds-1 through r4ds-5) that
cover:

- Data import and visualization

- Data transformations and tidying

- Working with databases, strings, and regular expressions

- Factors, dates, times, and joins

- Web scraping, functions, and iterations

## Census Data Tutorial

The tidycensus-1 tutorial covers working with US Census data using the
tidycensus package.

## Running Tutorials

To run a tutorial, use:
`learnr::run_tutorial(name = "short_tutorial_name", package = "positron.tutorials")`

Available tutorial names include: 01-code, 02-quarto, 03-terminal,
04-github-1, 05-github-2, 06-websites-1, 07-websites-2, r4ds-1, r4ds-2,
r4ds-3, r4ds-4, r4ds-5, and tidycensus-1.

## See also

Useful links:

- <https://ppbds.github.io/positron.tutorials/>

- <https://github.com/PPBDS/positron.tutorials>

- Report bugs at <https://github.com/PPBDS/positron.tutorials/issues>

## Author

**Maintainer**: David Kane <dave.kane@gmail.com>
([ORCID](https://orcid.org/0000-0002-6660-3934)) \[copyright holder\]
