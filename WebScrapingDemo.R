# libraries
library(rvest)

# Webpage to web scrape
pg <- 'https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population'

# Read the webpage content
webpage <- read_html(pg)

# Extract the main table
populationTable <- webpage %>% html_nodes('table.wikitable') %>% .[[1]] %>% html_table(fill = TRUE)

# Rename columns for clarity and select relevant columns
colnames(populationTable) <- c("Rank", "Country", "Population", "Percentage_of_World", "Date", "Source")

# Create a dataframe with specific columns
populationData <- populationTable[, c("Country", "Population", "Percentage_of_World")]

# Clean up the dataframe
populationData <- populationData[complete.cases(populationData), ]  # Remove rows with missing values
populationData <- populationData[-1, ]  # Remove the header row if duplicated in data

# Convert Population and Percentage_of_World to numeric for accurate representation
populationData$Population <- as.numeric(gsub(",", "", populationData$Population))
populationData$Percentage_of_World <- as.numeric(gsub("%", "", populationData$Percentage_of_World))

# Preview the cleaned dataframe
head(populationData)

# Check the structure of the final dataframe
str(populationData)
