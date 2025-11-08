> Authors: Jigar Patel, Henry Yost, Davinia Muthalaly, Refugio Zepeda

# Files

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

# Installation & Usage

### 1. Fork & Clone Repo

If you haven’t already, start by forking this repository to your own GitHub account so you can make edits or run the code independently.

Then clone your fork to your local machine:
```bash
git clone https://github.com/<your-username>/STAT107-WorldCup-Prediction-Project.git
cd STAT107-WorldCup-Prediction-Project
```

### 2. Set Up Your R Environment
Make sure you have R (≥ 4.0) and RStudio installed and launch RStudio.

Then install the required packages by running the following in your R console:
```bash
# Install required libraries
source("00_requirements.R")
```

### 3. Run Exploratory Data Analysis on `group_standings.csv`

Run the `EDA_groupstandings.rmd` and `PreliminaryEDA.R` files, which will generate the necessary graphs.

These scripts perform:
* Exploratory Data Analysis (EDA)
* Visualizations and relationships between variables

### 5. Final Report
Finally, to view the compiled progress report, open `FinalReport.Rmd` in RStudio and knit it to generate `FinalReport.pdf`.
This report combines all results, figures, and interpretations into a single, clean document.
