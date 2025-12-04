#Cleaning qualifed teams csv
clean_wc_performance <- function(filepath) {
  ## Reading in Dataset
  df_performance <- readr::read_csv(filepath, show_col_types = FALSE)
  head(df_performance, 200)
  
  ## Data Cleaning / Processing
  df_performance_clean <- df_performance[, c("tournament_id", 
                                             "team_name", 
                                             "count_matches")]
  
  df_performance_clean <- dplyr::mutate(
    df_performance_clean,
    dplyr::across(where(is.character), trimws),
    dplyr::across(c(count_matches), as.numeric)
  )
  
  ## Extract year (e.g., WC-1930 → 1930)
  df_performance_clean$year <- sub(".*-(\\d{4}).*", "\\1", df_performance_clean$tournament_id)
  df_performance_clean$year <- as.numeric(df_performance_clean$year)
  
  ## 🟦 Filter: Keep only WCs from 1982 onward, every 4 years
  df_performance_clean <- df_performance_clean %>%
    dplyr::filter(
      year >= 1982,
      year %% 4 == 2   # 1982, 1986, 1990, ...
    )
  
  ## Keep final columns
  df_performance_clean <- df_performance_clean[, c("year", "team_name", "count_matches")]
  
  return(df_performance_clean)
}

#Cleaning ranking Soccer csv
clean_elo_ratings <- function(filepath) {
  ## Reading in Dataset
  df_elo <- readr::read_csv(filepath, show_col_types = FALSE)
  head(df_elo, 200)
  
  ## Data Cleaning / Processing 
  df_elo_clean <- df_elo[, c("year", 
                             "team", 
                             "rating", 
                             "rank", 
                             "one_year_change_rating")]
  
  df_elo_clean <- dplyr::mutate(
    df_elo_clean,
    dplyr::across(where(is.character), trimws),
    dplyr::across(c(year, rating, rank, one_year_change_rating), as.numeric)
  )
  
  df_elo_clean <- dplyr::rename(
    df_elo_clean,
    team_name = team,
    elo_rating = rating,
    elo_rank = rank,
    elo_1yr_change_rating = one_year_change_rating
  )
  
  ## 🟦 Filter only years one year before the WC, starting at 1982
  df_elo_clean <- df_elo_clean %>%
    dplyr::filter(
      year >= 1981,
      year %% 4 == 1     # keeps 1981, 1985, 1989, ...
    )
  
  return(df_elo_clean)
}

#Combining both data sets into one
add_wc_matches_to_elo <- function(elo_filepath, wc_perf_filepath) {
  ## Clean individual datasets using your existing functions
  df_elo <- clean_elo_ratings(elo_filepath)
  df_wc  <- clean_wc_performance(wc_perf_filepath)
  
  ## Rename WC year to world_cup_year
  df_wc <- df_wc %>%
    dplyr::rename(world_cup_year = year)
  
  ## Add world_cup_year to ELO data (one year after ELO year)
  df_elo <- df_elo %>%
    dplyr::mutate(world_cup_year = year + 1)
  
  ## Join: keep all ELO rows, add count_matches where team & WC match
  df_elo_with_matches <- df_elo %>%
    dplyr::left_join(
      df_wc,
      by = c("world_cup_year", "team_name")
    )  %>%
    dplyr::mutate(
      elo_1yr_change_rating = ifelse(is.na(elo_1yr_change_rating), 0, elo_1yr_change_rating), 
      count_matches = ifelse(is.na(count_matches), 0, count_matches)
    )
  
  return(df_elo_with_matches)
}

