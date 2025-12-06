
# EDA Functions for World Cup goals and Elo

# Loading shared libraries
source("00_requirements.R")


# Loading merged dataset

load_wc_elo <- function(path = "data/primary_dataset_wc_elo.csv") {
  df <- readr::read_csv(path, show_col_types = FALSE)
  return(df)
}


# 1) Goals vs Elo rating (Measures if team strength predicts score)

plot_goals_vs_elo <- function(df) {
  ggplot(df, aes(x = elo_rating, y = goals_ratio)) +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "lm", se = FALSE, color = "blue") +
    labs(
      title = "Goals Scored vs Elo Rating",
      subtitle = "Elo rating taken from national ranking soccer dataset",
      x = "Elo Rating",
      y = "Goals Per Match"
    )
}


# 2) Goals vs Matches Played (Do teams who advance further naturally score more goals?)

plot_goals_vs_matches <- function(df) {
  ggplot(df, aes(x = count_matches, y = goals_ratio)) +
    geom_jitter(alpha = 0.5, width = 0.15) +
    geom_smooth(method = "lm", se = FALSE, color = "red") +
    labs(
      title = "Goals Scored vs Matches Played",
      subtitle = "Match count comes from qualified_teams dataset",
      x = "Matches Played",
      y = "Goals Per Match"
    )
}


# 3) Goals Over Time + Top Scoring Teams (Shows long-term scoring trends)

plot_goals_over_time <- function(df, n_teams = 5) {
  top <- df |>
    dplyr::group_by(team_name) |>
    dplyr::summarise(mean_goals = mean(goals_ratio, na.rm = TRUE)) |>
    dplyr::slice_max(mean_goals, n = n_teams) |>
    dplyr::pull(team_name)
  
  df_top <- df |>
    dplyr::filter(team_name %in% top)
  
  ggplot(df_top, aes(x = world_cup_year, y = goals_ratio, color = team_name)) +
    geom_line() +
    geom_point() +
    labs(
      title = "Goals Per Match Over Time for Top-Scoring Teams",
      x = "World Cup Year",
      y = "Goals Per Match",
      color = "Team"
    )
}


# 4) Correlation Heatmap (Which variables can actually help predict goals?)

plot_corr_heatmap <- function(df) {
  numeric_df <- df |>
    dplyr::select(
      elo_rating, elo_rank, elo_1yr_change_rating,
      win_ratio, goals_ratio, count_matches
    )
  
  cormat <- stats::cor(numeric_df, use = "pairwise.complete.obs")
  
  corrplot::corrplot(
    cormat,
    method = "color",
    tl.col = "black",
    addCoef.col = "black",
    number.cex = 0.7
  )
}