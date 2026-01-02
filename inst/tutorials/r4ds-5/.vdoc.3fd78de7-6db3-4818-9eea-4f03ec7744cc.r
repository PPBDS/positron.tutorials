#
#
#
#
#
#
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

library(tidyverse)
library(leaflet)
library(rvest)   
library(ggrepel)     
library(httr2)

knitr::opts_chunk$set(echo = FALSE)
options(tutorial.exercise.timelimit = 60, 
        tutorial.storage = "local") 

convert_earthquake_time <- function(milliseconds) {
   as.POSIXct(milliseconds / 1000, origin = "1970-01-01", tz = "UTC")
 }
categorize_magnitude <- function(mag) {
   case_when(
     mag < 3.0 ~ "Minor",
     mag < 4.0 ~ "Light", 
    mag < 5.0 ~ "Moderate",
     mag < 6.0 ~ "Strong",
     mag < 7.0 ~ "Major",
     TRUE ~ "Great"
   )
 }

earthquake_df <- jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) |>
  filter(longitude >= -125, longitude <= -66, latitude >= 20, latitude <= 50) |>
  mutate(
    hour = hour(datetime),
    day_of_week = wday(datetime, label = TRUE),
    depth_category = case_when(
      depth < 70 ~ "Shallow",
      depth < 300 ~ "Intermediate", 
      depth < 600 ~ "Deep"
    )
  )|>
  select(longitude, latitude, properties_mag, properties_place, datetime, depth, mag_category, depth_category) |>
  mutate(
    tooltip_text = paste0(
      "Magnitude: ", properties_mag, " (", mag_category, ")<br>",
      "Location: ", properties_place, "<br>",
      "Time: ", format(datetime, "%Y-%m-%d %H:%M"), "<br>",
      "Depth: ", round(depth, 1), " km (", depth_category, ")"
    )
  )|>
  filter(
    longitude >= -180, longitude <= 180,
    latitude >= -90, latitude <= 90,
    properties_mag >= 0, properties_mag <= 10
  ) |>
  mutate(
    color = case_when(
      properties_mag >= 6 ~ "red",
      properties_mag >= 5 ~ "orange", 
      properties_mag >= 4 ~ "yellow",
      properties_mag >= 3 ~ "green",
      TRUE ~ "blue"
    )
  ) |>
  arrange(desc(properties_mag))

extract_rating_info <- function(url) {
  read_html(url) |>
    html_element("table") |>
    html_table() |>
    select(
      rank_title_year = `Rank & Title`,
      rating = `IMDb Rating`
    ) |>
    mutate(
      rank_title_year = str_replace_all(rank_title_year, "\n +", " ")
    ) |>
    separate_wider_regex(
      rank_title_year,
      patterns = c(
        rank = "\\d+", "\\. ",
        title = ".+", " +\\(",
        year = "\\d+", "\\)"
      )
    )
}

top_movies <- request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(
    number = parse_number(number),
    across(c(rank, year), as.numeric),
    decade = paste0(floor(year/10)*10, "s"),
    rating_category = case_when(
      rating >= 9.0 ~ "Masterpiece (9.0+)",
      rating >= 8.5 ~ "Excellent (8.5-8.9)", 
      rating >= 8.0 ~ "Great (8.0-8.4)",
      TRUE ~ "Good (<8.0)"
    ),
    popularity = case_when(
      number >= 2000000 ~ "Very Popular (2M+)",
      number >= 1000000 ~ "Popular (1M-2M)",
      number >= 500000 ~ "Moderate (500K-1M)",
      TRUE ~ "Niche (<500K)"
    )
  ) |>
  select(rank, title, year, rating, number) |>
  arrange(rank)

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
#
#
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
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 8)
#
#
#
#
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
	str(max.levels = 2)
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_")   
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_")   |>
  hoist(geometry, coordinates = "coordinates")
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x)))
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
filter(!if_any(c(properties_mag, longitude, latitude), is.na))
#
#
#
#
#
#
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
    rows = 10)
#
#
#
#
#
#
#
 convert_earthquake_time <- function(milliseconds) {
   as.POSIXct(milliseconds / 1000, origin = "1970-01-01", tz = "UTC")
 }
#
#
#
#
#
#
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
    rows = 10)
#
#
#
#
#
#
#
convert_earthquake_time <- function(milliseconds) {
   as.POSIXct(milliseconds / 1000, origin = "1970-01-01", tz = "UTC")
 }
categorize_magnitude <- function(mag) {
   case_when(
     mag < 3.0 ~ "Minor",
     mag < 4.0 ~ "Light", 
    mag < 5.0 ~ "Moderate",
     mag < 6.0 ~ "Strong",
     mag < 7.0 ~ "Major",
     TRUE ~ "Great"
   )
 }
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
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
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) 
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) |>
filter(longitude >= -125, longitude <= -66, latitude >= 20, latitude <= 50) |>
mutate(
  hour = hour(datetime),
  day_of_week = wday(datetime, label = TRUE),
  depth_category = case_when(
    depth < 70 ~ "Shallow",
    depth < 300 ~ "Intermediate",
    depth < 600 ~ "Deep"
  )
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) |>
filter(longitude >= -125, longitude <= -66, latitude >= 20, latitude <= 50) |>
mutate(
  hour = hour(datetime),
  day_of_week = wday(datetime, label = TRUE),
  depth_category = case_when(
    depth < 70 ~ "Shallow",
    depth < 300 ~ "Intermediate",
    depth < 600 ~ "Deep"
  )
) |>
	select(longitude, latitude, properties_mag, properties_place, datetime, depth, mag_category, depth_category) |>
mutate(
  tooltip_text = paste0(
    "Magnitude: ", properties_mag, " (", mag_category, ")<br>",
    "Location: ", properties_place, "<br>",
    "Time: ", format(datetime, "%Y-%m-%d %H:%M"), "<br>",
    "Depth: ", round(depth, 1), " km (", depth_category, ")"
  )
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) |>
filter(longitude >= -125, longitude <= -66, latitude >= 20, latitude <= 50) |>
mutate(
  hour = hour(datetime),
  day_of_week = wday(datetime, label = TRUE),
  depth_category = case_when(
    depth < 70 ~ "Shallow",
    depth < 300 ~ "Intermediate",
    depth < 600 ~ "Deep"
  )
) |>
	select(longitude, latitude, properties_mag, properties_place, datetime, depth, mag_category, depth_category) |>
	mutate(
		tooltip_text = paste0(
		"Magnitude: ", properties_mag, " (", mag_category, ")<br>",
		"Location: ", properties_place, "<br>",
		"Time: ", format(datetime, "%Y-%m-%d %H:%M"), "<br>",
		"Depth: ", round(depth, 1), " km (", depth_category, ")"
	)
	)|>
	filter(
  		longitude >= -180, longitude <= 180,
  		latitude >= -90, latitude <= 90,
  		properties_mag >= 0, properties_mag <= 10
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
	rows = 5)
#
#
#
#
#
#
#
jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) |>
filter(longitude >= -125, longitude <= -66, latitude >= 20, latitude <= 50) |>
mutate(
  hour = hour(datetime),
  day_of_week = wday(datetime, label = TRUE),
  depth_category = case_when(
    depth < 70 ~ "Shallow",
    depth < 300 ~ "Intermediate",
    depth < 600 ~ "Deep"
  )
) |>
	select(longitude, latitude, properties_mag, properties_place, datetime, depth, mag_category, depth_category) |>
	mutate(
		tooltip_text = paste0(
		"Magnitude: ", properties_mag, " (", mag_category, ")<br>",
		"Location: ", properties_place, "<br>",
		"Time: ", format(datetime, "%Y-%m-%d %H:%M"), "<br>",
		"Depth: ", round(depth, 1), " km (", depth_category, ")"
	)
	)|>
	filter(
  		longitude >= -180, longitude <= 180,
  		latitude >= -90, latitude <= 90,
  		properties_mag >= 0, properties_mag <= 10
	) |>
mutate(
  color = case_when(
    properties_mag >= 6 ~ "red",
    properties_mag >= 5 ~ "orange",
    properties_mag >= 4 ~ "yellow",
    properties_mag >= 3 ~ "green",
    TRUE ~ "blue"
  )
) |>
arrange(desc(properties_mag))
#
#
#
#
#
#
#
#
#
#
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
question_text(NULL,
    answer(NULL, correct = TRUE),
    allow_retry = TRUE,
    try_again_button = "Edit Answer",
    incorrect = NULL,
    rows = 8)
#
#
#
#
#
#
#
earthquake_df <- jsonlite::read_json("data/earthquakes.geojson") |>
  pluck("features") |> 
  tibble(data = _) |> 
  unnest_wider(data) |> 
  unnest_wider(properties, names_sep = "_") |> 
  hoist(geometry, coordinates = "coordinates") |> 
  unnest_wider(coordinates, names_sep = "_") |> 
  rename(
    longitude = coordinates_1,
    latitude  = coordinates_2,
    depth     = coordinates_3
  )|>
 	mutate(across(where(is.character), ~ifelse(.x == "null", NA, .x))) |>
 	filter(!if_any(c(properties_mag, longitude, latitude), is.na))|>
		mutate(
  			datetime = convert_earthquake_time(as.numeric(properties_time)),
  			mag_category = categorize_magnitude(as.numeric(properties_mag))
		)|>
mutate(across(c(properties_mag, depth), as.numeric)) |>
  filter(datetime >= Sys.Date() - 7) |>
  filter(longitude >= -125, longitude <= -66, latitude >= 20, latitude <= 50) |>
  mutate(
    hour = hour(datetime),
    day_of_week = wday(datetime, label = TRUE),
    depth_category = case_when(
      depth < 70 ~ "Shallow",
      depth < 300 ~ "Intermediate", 
      depth < 600 ~ "Deep"
    )
  )|>
  select(longitude, latitude, properties_mag, properties_place, datetime, depth, mag_category, depth_category) |>
  mutate(
    tooltip_text = paste0(
      "Magnitude: ", properties_mag, " (", mag_category, ")<br>",
      "Location: ", properties_place, "<br>",
      "Time: ", format(datetime, "%Y-%m-%d %H:%M"), "<br>",
      "Depth: ", round(depth, 1), " km (", depth_category, ")"
    )
  )|>
  filter(
    longitude >= -180, longitude <= 180,
    latitude >= -90, latitude <= 90,
    properties_mag >= 0, properties_mag <= 10
  ) |>
  mutate(
    color = case_when(
      properties_mag >= 6 ~ "red",
      properties_mag >= 5 ~ "orange", 
      properties_mag >= 4 ~ "yellow",
      properties_mag >= 3 ~ "green",
      TRUE ~ "blue"
    )
  ) |>
  arrange(desc(properties_mag))
#
#
#
#
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
    rows = 8)
#
#
#
#
#
#
#
#
earthquake_df
#
#
#
#
#
#
#
#
#
#
#
#
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
	rows = 12)
#
#
#
#
#
#
#
leaflet(earthquake_df) |>
  addTiles() |>
  addCircleMarkers(
    lng = ~longitude,
    lat = ~latitude,
    radius = ~properties_mag * 2,
    color = ~color,
    popup = ~tooltip_text,
    fillOpacity = 0.7,
    stroke = TRUE,
    weight = 1
  ) |>
  addLegend(
    position = "bottomright",
    colors = c("red", "orange", "yellow", "green", "blue"),
    labels = c("Major (6.0+)", "Strong (5.0-5.9)", "Moderate (4.0-4.9)", 
              "Light (3.0-3.9)", "Minor (<3.0)"),
    title = "Earthquake Magnitude"
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
#
#
#
#
#
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
#
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
	rows = 10)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table()
#
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " ")
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " ")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
extract_rating_info <- function(url) {
  read_html(url) |>
    html_element("table") |>
    html_table() |>
    select(
      rank_title_year = `Rank & Title`,
      rating = `IMDb Rating`
    ) |>
    mutate(
      rank_title_year = str_replace_all(rank_title_year, "\n +", " ")
    ) |>
    separate_wider_regex(
      rank_title_year,
      patterns = c(
        rank = "\\d+", "\\. ",
        title = ".+", " +\\(",
        year = "\\d+", "\\)"
      )
    )
}
#
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
extract_rating_info("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/")
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_elements("td strong") |>
  html_attr("title")
#
#
#
#
#
#
#
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
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(
    number = parse_number(number)
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(
    number = parse_number(number),
    across(c(rank, year), as.numeric),
    decade = paste0(floor(year/10)*10, "s")
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
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(
    number = parse_number(number),
    across(c(rank, year), as.numeric),
    decade = paste0(floor(year/10)*10, "s"),
    rating_category = case_when(
      rating >= 9.0 ~ "Masterpiece (9.0+)",
      rating >= 8.5 ~ "Excellent (8.5-8.9)", 
      rating >= 8.0 ~ "Great (8.0-8.4)",
      TRUE ~ "Good (<8.0)"
    ),
    popularity = case_when(
      number >= 2000000 ~ "Very Popular (2M+)",
      number >= 1000000 ~ "Popular (1M-2M)",
      number >= 500000 ~ "Moderate (500K-1M)",
      TRUE ~ "Niche (<500K)"
    )
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
#
#
#
#
question_text(NULL,
	answer(NULL, correct = TRUE),
	allow_retry = TRUE,
	try_again_button = "Edit Answer",
	incorrect = NULL,
	rows = 5)
#
#
#
#
#
#
#
request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(
    number = parse_number(number),
    across(c(rank, year), as.numeric),
    decade = paste0(floor(year/10)*10, "s"),
    rating_category = case_when(
      rating >= 9.0 ~ "Masterpiece (9.0+)",
      rating >= 8.5 ~ "Excellent (8.5-8.9)", 
      rating >= 8.0 ~ "Great (8.0-8.4)",
      TRUE ~ "Good (<8.0)"
    ),
    popularity = case_when(
      number >= 2000000 ~ "Very Popular (2M+)",
      number >= 1000000 ~ "Popular (1M-2M)",
      number >= 500000 ~ "Moderate (500K-1M)",
      TRUE ~ "Niche (<500K)"
    )
  ) |>
  select(rank, title, year, rating, number) |>
  arrange(rank)
#
#
#
#
#
#
#
#
#
#
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
question_text(NULL,
    answer(NULL, correct = TRUE),
    allow_retry = TRUE,
    try_again_button = "Edit Answer",
    incorrect = NULL,
    rows = 8)
#
#
#
#
#
#
#
top_movies <- request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
  html_element("table") |>
  html_table() |>
  select(
    rank_title_year = `Rank & Title`,
    rating = `IMDb Rating`
  ) |>
  mutate(
    rank_title_year = str_replace_all(rank_title_year, "\n +", " "),
    rating_details = request("https://web.archive.org/web/20220201012049/https://www.imdb.com/chart/top/") |> 
  req_perform() |> 
  resp_body_html() |> 
      html_elements("td strong") |>
      html_attr("title")
  ) |>
  separate_wider_regex(
    rank_title_year,
    patterns = c(
      rank = "\\d+", "\\. ",
      title = ".+", " +\\(",
      year = "\\d+", "\\)"
    )
  ) |>
  separate_wider_regex(
    rating_details,
    patterns = c(
      "[0-9.]+ based on ",
      number = "[0-9,]+",
      " user ratings"
    )
  ) |>
  mutate(
    number = parse_number(number),
    across(c(rank, year), as.numeric),
    decade = paste0(floor(year/10)*10, "s"),
    rating_category = case_when(
      rating >= 9.0 ~ "Masterpiece (9.0+)",
      rating >= 8.5 ~ "Excellent (8.5-8.9)", 
      rating >= 8.0 ~ "Great (8.0-8.4)",
      TRUE ~ "Good (<8.0)"
    ),
    popularity = case_when(
      number >= 2000000 ~ "Very Popular (2M+)",
      number >= 1000000 ~ "Popular (1M-2M)",
      number >= 500000 ~ "Moderate (500K-1M)",
      TRUE ~ "Niche (<500K)"
    )
  ) |>
  select(rank, title, year, rating, number) |>
  arrange(rank)
#
#
#
#
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
    rows = 8)
#
#
#
#
#
#
#
top_movies
#
#
#
#
#
#
#
#
#
#
#
#
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
	rows = 12)
#
#
#
#
#
#
#
#
#
top_movies |>
filter(year >= 1990, year <= 2010) |>
 ggplot(aes(x = year, y = rating)) +
  geom_point(aes(size = number/1000), 
             alpha = 0.8, stroke = 0.5) +
  geom_smooth(method = "loess", se = TRUE, color = "navy", 
              linewidth = 1.2, alpha = 0.3) +
  geom_text_repel(aes(label = ifelse(rating >= 9.0, 
                                    str_wrap(title, 15), "")), 
                 size = 3, max.overlaps = 8, 
                 box.padding = 0.5, point.padding = 0.3) +
  scale_size_continuous(name = "Votes\n(thousands)", 
                       range = c(2, 12), 
                       breaks = c(500, 1000, 1500, 2000, 2500),
                       labels = c("500", "1,000", "1,500", "2,000", "2,500")) +
  scale_x_continuous(breaks = seq(1990, 2010, 2)) +
  scale_y_continuous(breaks = seq(8.0, 9.2, 0.2), limits = c(7.9, 9.3)) +
  labs(
    title = "IMDb Top 250: The Golden Age (1990-2010)",
    subtitle = "Masterpiece films labeled • Size shows popularity • Color indicates rating tier",
    x = "Release Year",
    y = "IMDb Rating",
    caption = "Data from IMDb Top 250 (archived February 2022) | Only movies ranking in Top 250"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "navy"),
    plot.subtitle = element_text(size = 12, color = "gray40"),
    plot.caption = element_text(size = 9, color = "gray50"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "right",
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.5),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white"),
    strip.text = element_text(size = 11, face = "bold")
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
#
#
#
#
#
#
#
#
#
#
#
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
	rows = 30)
#
#
#
#
#
#
#
#
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
	rows = 1)
#
#
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
