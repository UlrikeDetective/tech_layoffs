library(readxl)

F01 <- read_xlsx("/forbes (1).xlsx")

F01

# Function to convert revenue to whole numbers
convert <- function(x) {
  # Remove the dollar sign, commas, and any spaces
  x <- gsub("\\$", "", x)
  x <- gsub(",", "", x)  # Remove commas
  x <- gsub(" ", "", x)
  
  # Convert values ending in 'B' (billions)
  x_b <- grepl("B$", x)
  x[x_b] <- as.numeric(gsub("B", "", x[x_b])) * 1e9
  
  # Convert values ending in 'M' (millions)
  x_m <- grepl("M$", x)
  x[x_m] <- as.numeric(gsub("M", "", x[x_m])) * 1e6
  
  return(as.numeric(x))
}

# Apply the function to the columns
F01$revenue_USD <- convert(F01$revenue)
F01$profits_USD <- convert(F01$profits)
F01$assets_USD <- convert(F01$assets)
F01$marketValue_USD <- convert(F01$marketValue)

# View the updated dataframe
print(F01)


# Delete the columns revenue, profits, assets, and marketValue
F01 <- subset(F01, select = -c(revenue, profits, assets, marketValue))

# Alternatively, you can use NULL to remove the columns
# F01$revenue <- NULL
# F01$profits <- NULL
# F01$assets <- NULL
# F01$marketValue <- NULL

# View the updated dataframe

options(scipen = 999)
write.csv(F01, "/path_to_file/Forbes_companies_2024.csv", row.names = FALSE)
