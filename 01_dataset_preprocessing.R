
# This function's main goal is to clean the wc performance .csv from: https://github.com/JGravier/soccer-elo/blob/main/csv/ranking_soccer_1901-2023.csv
# It does this by only selecting the necessary columns that we need, and then also using RegEx to properly
# extract the proper information from each of the columns

source("00_requirements.R")

clean_wc_performance <- function(filepath) {
  df_performance <- readr::read_csv(filepath, show_col_types = FALSE)
  # head(df_performance, 200)
  
  # Data Cleaning  & Processing
  df_performance_clean <- df_performance[, c("tournament_id", "team_name", "count_matches")]
  
  df_performance_clean <- dplyr::mutate(
    df_performance_clean,
    dplyr::across(where(is.character), trimws),
    dplyr::across(c(count_matches), as.numeric)
  )
  
  # Extract year (e.g., WC-1930 --> 1930)
  df_performance_clean$year <- sub(".*-(\\d{4}).*", "\\1", df_performance_clean$tournament_id)
  df_performance_clean$year <- as.numeric(df_performance_clean$year)
  
  df_performance_clean <- df_performance_clean %>%
    dplyr::filter(
      year >= 1982,
      year %% 4 == 2   # only grab WC years
    )
  
  df_performance_clean <- df_performance_clean[, c("year", "team_name", "count_matches")]
  return(df_performance_clean)
}


library(readr)

# This functions primary goal is to clean the .csv data from: https://github.com/JGravier/soccer-elo/blob/main/csv/ranking_soccer_1901-2023.csv
# This dataset is mostly numeric, therefore, we do not need any regex to filter specific values.
# Instead, we're able to grab the necessary variables for both direct and indirect use (i.e. calculating a new variable)
# Additionally, this function uses the readr library to properly parse any weird negatives.

clean_elo_ratings <- function(filepath) {
  df_elo <- readr::read_csv(filepath, show_col_types = FALSE)
  # head(df_elo, 200)
  
  # Data Cleaning & Processing 
  df_elo_clean <- df_elo[, c(
    "year", "team", "rating", "rank", "one_year_change_rating", "matches_total", "matches_wins", "goals_for")]
  
  df_elo_clean <- df_elo_clean %>%
    dplyr::mutate(
      # Standardize minus sign characters to the ASCII hyphen (did this because of issues extracting the dataset)
      one_year_change_rating = gsub("[−–—]", "-", one_year_change_rating),
      
      # parse_number to extract numeric values so we do not have NA's
      one_year_change_rating = readr::parse_number(one_year_change_rating)
    )
  
  
  df_elo_clean <- dplyr::rename(
    df_elo_clean,
    team_name = team,
    elo_rating = rating,
    elo_rank = rank,
    elo_1yr_change_rating = one_year_change_rating
  )
  
  # Filter only years one year before the WC, starting at 1982
  df_elo_clean <- df_elo_clean %>%
    dplyr::filter(
      year >= 1981,
      year %% 4 == 1     # grabs WC - 1 years (we do this because we only want the data before the WC, not after)
    )
  
  return(df_elo_clean)
}



# This function's primary goal is to combine both the world_cup dataset and also the soccer_rating/elo dataset.
# In doing so, we create one primary dataset that we can use for EDA, and also for our models.

add_wc_matches_to_elo <- function(elo_filepath, wc_perf_filepath) {
  # Clean individual datasets using your existing functions
  df_elo <- clean_elo_ratings(elo_filepath)
  df_wc  <- clean_wc_performance(wc_perf_filepath)
  
  # Rename WC year to world_cup_year for consistency.
  df_wc <- df_wc %>%
    dplyr::rename(world_cup_year = year)
  
  # Add world_cup_year to ELO data
  df_elo <- df_elo %>%
    dplyr::mutate(world_cup_year = year + 1)
  
  # keep all ELO rows, add count_matches where team & WC match
  # Also, in this block we only select the final variables we need form the dataset.
  df_elo_with_matches <- df_elo %>%
    dplyr::inner_join(
      df_wc,
      by = c("world_cup_year", "team_name")
    )  %>%
    dplyr::mutate(
      win_ratio = ifelse(matches_total > 0, matches_wins / matches_total, 0),
      goals_ratio = ifelse(matches_total > 0, goals_for / matches_total, 0)
    ) %>%
    dplyr::select(
       world_cup_year, team_name, elo_rating, elo_rank, elo_1yr_change_rating, win_ratio, 
       goals_ratio, count_matches
    )

  return(df_elo_with_matches)
}