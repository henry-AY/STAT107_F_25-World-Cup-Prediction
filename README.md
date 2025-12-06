# STAT107 World Cup Prediction Project

> Authors: Jigar Patel, Henry Yost, Davinia Muthalaly, Refugio Zepeda

## Data
[JGravier Soccer Elo Dataset](https://github.com/JGravier/soccer-elo/blob/main/csv/ranking_soccer_1901-2023.csv)

[Jfjelstul World Cup Qualified Teams Dataset](https://github.com/jfjelstul/worldcup/blob/master/data-csv/qualified_teams.csv)

## Files
```
      00_requirements.R
      01_dataset_preprocessing.R
```
The first file is the requirements file. This is absolutely necessary to run, otherwise the code will not work. The second file is our data cleaning and processing code, this file manages taking in the messy and unstructured datasets, and converts them into a clean, single dataframe. It does this by extracting only from WC years, using RegEx, and also joining both datasets.
```
      02_EDA.Rmd
      02_01_EDA_graphs.R
```
The Rmd file is the main R-Markdown file we used for EDA. This was to separate it from our final report, so that we could experiment with different kinds of EDA, and determine which graphs worked best to explain our data and help answer our question. Additionally, the `.Rmd` file calls the functions inside `02_01_EDA_graphs.R`, which has multiple functions with all of the EDA plots. We separated it like this, so we have a modular structure, and have very little code inside the markdown files themselves. In our EDA, we went through the process of understanding more about our data, its structure, and also potentially strong predictive variables for teams that have a higher number of matches played.
```
      03_project_models.Rmd
      03_01_random_forest_function.R
```
The Rmd file is the main R-Markdown file we used for the linear and random forest models. We separated it, so that we could experiment with multiple different versions, and then the `.R` script file would contain the final function and model we planned on using for our analysis. We used both linear models and random forest, because of the way they interact with data. Most importantly, linear models expect a linear relationship, and this was powerful in figuring out which variables can be strong predictive variables for our main question. Additionally, the random forest model is powerful in the context of our data, as it is able to handle non-linear relationships.
```
      04_model_bias.R
```
The model bias script file produces a simple scatterplot that shows the predictions of the random forest model. It plots the actual match count, and the predicted match count against each other, and also plots a "perfect prediction" line. The values that fall near or on the line mean they were accurately predicted. It is a simple model that is effective in showing outliers.
```
      FinalReport.Rmd
```
Lastly, this file is the culmination of all of our research and analysis into a single effective document that explains our process and process.

## Installation & Usage

### 1. Fork & Clone Repo

If you haven’t already, start by forking this repository to your own GitHub account so you can make edits or run the code independently.

Then clone your fork to your local machine by using the HTTPS:
```bash
git clone https://github.com/<your-username>/STAT107-WorldCup-Prediction-Project.git
```

### 2. Set Up Your R Environment
Make sure you have R (≥ 4.0) and RStudio installed and launch RStudio.

Navigate to the folder in Finder/File Storage, and open the `FinalReport.Rmd` Then install the required packages by running the following in your R console:
```bash
# Install required libraries
source("00_requirements.R")
```

Additionally, you can knit the `FinalReport.Rmd` and it will install the requirements.

### 3. Run the EDA and model R-Markdown files

Run the `02_EDA.Rmd` and `03_project_models.Rmd` files, which will generate the necessary graphs and models.

These scripts perform:
* Exploratory Data Analysis (EDA)
* Visualizations and relationships between variables

### 5. Final Report
Finally, to view the compiled progress report, open `FinalReport.Rmd` in RStudio and knit it to generate `FinalReport.pdf`.
This report combines all results, figures, and interpretations into a single, clean document.
