#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
library(learnr)
library(tutorial.helpers)
library(tidycensus)
library(tidyverse)
library(knitr)


# income_tx <- get_acs(
#   geography = "county",
#   variables = "B19013_001",
#   state = "TX",
#   year = 2020,
#   geometry = TRUE
# )
# write_rds(income_tx, "data/income_tx.rds")

income_tx <- read_rds("data/income_tx.rds")


# edu_ca <- get_acs(
#   geography = "county",
#   variables = c("B15003_001", "B15003_022", "B15003_023", "B15003_024", "B15003_025"),
#   state = "CA",
#   year = 2020,
#   geometry = TRUE,
#   summary_var = "B15003_001"
# )
#  write_rds(edu_ca, "data/edu_ca.rds")

edu_ca <- read_rds("data/edu_ca.rds")


# age_ca <- get_acs(
#   geography = "county",
#   variables = c(median_age = "B01002_001", population = "B01003_001"),
#   state = "CA",
#   year = 2020,
#   geometry = FALSE
# )
# write_rds(age_ca, "data/age_ca.rds")

age_ca <- read_rds("data/age_ca.rds")

knitr::opts_chunk$set(echo = FALSE)
options(tutorial.exercise.timelimit = 600, 
        tutorial.storage = "local") 	
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
```
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| message: false
ggplot(income_tx) +
  geom_sf(aes(fill = estimate), color = "white", size = 0.2) +
  scale_fill_viridis_c(option = "plasma", name = "Median Income") +
  labs(
    title = "Median Household Income by County, Texas (2020)",
    caption = "Data source: ACS 5-year estimates"
  ) +
  theme_minimal()
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 15)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| message: false
edu_ca <- edu_ca %>%
  group_by(GEOID) %>%
  summarize(
    percent = 100 * sum(estimate[variable != "B15003_001"]) / unique(summary_est)
  )

ggplot(edu_ca) +
  geom_sf(aes(fill = percent)) +
  scale_fill_viridis_c(option = "C") +
  labs(title = "Adult Percentage with at least a Bachelor's in CA (2020)",
       fill = "% with Degree") +
  theme_minimal()
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 15)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 6)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| message: false
age_ca_wide <- age_ca %>%
  select(NAME, variable, estimate) %>%
  pivot_wider(names_from = variable, values_from = estimate)

largest_ca <- age_ca_wide %>%
  arrange(desc(population)) %>%
  slice_head(n = 15)

ggplot(largest_ca, aes(x = reorder(NAME, median_age), y = median_age)) +
  geom_col(fill = "#4daf4a") +
  coord_flip() +
  labs(
    title = "2020 California Counties Median Age",
    x = "County",
    y = "Median Age",
    caption = "Source: ACS 5-Year Estimates via tidycensus"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.y = element_text(size = 10)
  )
#
#
#
#
#
#
#
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 15)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
