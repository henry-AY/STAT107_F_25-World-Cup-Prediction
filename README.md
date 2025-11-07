> Authors: Jigar Patel, Henry Yost, Davinia Muthalaly, Refugio Zepeda

STAT107 World Cup Prediction Project

      source("00_requirements.R")
      source("clean_group_standings.R")

This was our data cleaning and processing code, as well as the libraries we used. We used the read_csv() to view our 
data set in R and then proceeded to clean the data set of any white spaces and clean the text of anything that would
interfere with our analysis. We also cleaned up the tournament_id column so that it shows only a four-digit year. 

      source("PreliminaryEDA.R") 

This source file calls all the analysis and data visualization code we wrote using the dataset. It 
states all relationships we found from our dataset, and through logistic regression, we found predictable variables 
for teams that advance and don't advance.

      FinalReport.Rmd
      FinalReport.pdf

This file has all of our source calls and plots visible in one place for a cleaned and finished half way report. We have
our different analyses, abstract, and description of what our code was showing and the things we wanted to explore further 
that could help answer our main question. 





