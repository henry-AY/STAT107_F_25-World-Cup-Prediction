> Authors: Jigar Patel, Henry Yost, Davinia Muthalaly, Refugio Zepeda

STAT107 World Cup Prediction Project

      source("00_libraries.R")
      source("10_DataCleaning.R")
This was our data cleaning and processing code as well as the libraries we used. We used the read_csv() to view our 
data set in R and then proceeded to clean the data set of any white spaces and clean the text of anything that would
interfere with our analysis. We also cleaned up the tournament_id column so that it shows only a four digit year. 


      source("11_PreliminaryEDA.R") 
This source call to the .R file calls all of the analysis and data visualizations code we wrote using the data set. It 
states all relationships we found from our dataset and through logistic regression, we found predictable variables 
for teams that advance and dotn advance.

      FinalReport.Rmd
This file has all of our source calls and plots visible in one place for a cleaned and finished half way report. We have
our different analyses, abstract, and description on waht our code was showing and the things we wanted to further explore 
that could help answer our main question. 





