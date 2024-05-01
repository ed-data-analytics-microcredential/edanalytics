# Load necessary libraries
library(rmarkdown)
library(rsconnect)

# Deploy to Shinyapps.io
deployApp("./module-0-getting-started/0-1", appName = "0-1-getting-started", account = "ed-analytics")

deployApp("./module-1-overview/1-1", appName = "1-1-foundational-skills", account = "ed-analytics")
deployApp("./module-1-overview/1-2", appName = "1-2-nuts-and-bolts", account = "ed-analytics")

deployApp("./module-2-wrangling/2-1", appName = "2-1-data-wrangling", account = "ed-analytics")
deployApp("./module-2-wrangling/2-2", appName = "2-2-tidy-data", account = "ed-analytics")

deployApp("./module-3-descriptive-stats/3-1", appName = "3-1-stats-terms", account = "ed-analytics")
#deployApp("./module-3-descriptive-stats/3-2", appName = "3-2-statistics", account = "ed-analytics")

