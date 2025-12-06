
source("00_requirements.R")

count_match_prediction <- function(year) {
  library(randomForest)
  library(dplyr)
  
  # Load datasets
  wc_elo <- read.csv("data/primary_dataset_wc_elo.csv")
  
  # Convert columns to appropriate types
  wc_elo <- wc_elo %>%
    mutate(
      world_cup_year = as.factor(world_cup_year),
      team_name = as.factor(team_name),
      elo_rating = as.numeric(elo_rating),
      elo_rank = as.numeric(elo_rank),
      elo_1yr_change_rating = as.numeric(elo_1yr_change_rating),
      win_ratio = as.numeric(win_ratio),
      goals_ratio = as.numeric(goals_ratio),
      count_matches = as.numeric(count_matches)
    )
  
  # Split into training and test sets
  train_data <- wc_elo %>% filter(world_cup_year != year)
  test_data  <- wc_elo %>% filter(world_cup_year == year)
  
  # Train Random Forest model
  rf_model <- randomForest(
    count_matches ~ elo_rating + win_ratio + goals_ratio + elo_rank,
    data = train_data
  )
  
  # Make predictions on test year
  test_data$predicted_count_matches <- round(predict(rf_model, newdata = test_data))
  
  # Compute prediction error
  test_data$error <- test_data$predicted_count_matches - test_data$count_matches
  
  # Compute accuracy metrics
  actual <- test_data$count_matches
  pred   <- test_data$predicted_count_matches
  accuracy_df <- data.frame(
    RMSE = sqrt(mean((pred - actual)^2)),
    MAE  = mean(abs(pred - actual)),
    MAPE = mean(abs((pred - actual) / actual)) * 100
  )
  
  barplot(
    test_data$error,
    names.arg = test_data$team_name,
    las = 2,
    col = "skyblue",
    main = paste("Prediction Error per Team -", year),
    ylab = "Error = Predicted - Actual"
  )
  abline(h = 0, col = "red", lwd = 2)
  
  # Return predictions and accuracy
  return(list(predictions = test_data, accuracy = accuracy_df))
}