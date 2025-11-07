### Histogram - Points Distribution: Advanced vs. Not Advanced 
hist(df_group_standings_clean$points[df_group_standings_clean$advanced == 1], 
     col = rgb(0, 1, 0, 0.5), 
     main = "Points Distribution: Advanced vs Non-Advanced",
     xlab = "Points", 
     xlim = c(0, max(df_group_standings_clean$points)),
     ylim = c(0, max(table(df_group_standings_clean$points)))
)
hist(df_group_standings_clean$points[df_group_standings_clean$advanced == 0], 
     col = rgb(1, 0, 0, 0.5), 
     add = TRUE
)


### Scatterplot - Goals For vs. Goals Against 
goals_for_against <- plot(df_group_standings_clean$goals_for, df_group_standings_clean$goals_against,
                          col = ifelse(df_group_standings_clean$advanced == TRUE, "green", "red"),
                          pch = 19,
                          main = "Goals For vs Goals Against",
                          xlab = "Goals For",
                          ylab = "Goals Against")
abline(lm(goals_against ~ goals_for, data = df_group_standings_clean), 
       col = "blue")


### Logistic Regression (Best prediction factors)
played <- as.factor(df_group_standings_clean$played)
wins <- as.factor(df_group_standings_clean$wins)
draws <- as.factor(df_group_standings_clean$draws)
losses <- as.factor(df_group_standings_clean$losses)
goals_for <- as.factor(df_group_standings_clean$goals_for)
goals_against <- as.factor(df_group_standings_clean$goals_against)
goal_difference <- as.factor(df_group_standings_clean$goal_difference)
points <- as.factor(df_group_standings_clean$points)
advanced <- as.factor(df_group_standings_clean$advanced)

group_standing_model1 <- glm(advanced ~ played + wins + draws + losses + goals_for + goal_difference + goals_against + points, data = df_group_standings_clean)
summary(group_standing_model1)

reduced_group_standing_model1 <- step(group_standing_model1, direction = "backward")



### Logistic Regression 2
group_standing_model2 <- glm(advanced ~ goals_for + goal_difference + goals_against + points, data = df_group_standings_clean)
summary(group_standing_model2)

reduced_group_standing_model2 <- step(group_standing_model2, direction = "backward")





