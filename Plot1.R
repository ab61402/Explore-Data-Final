### Q1 ###

library(plyr)

### Load Data ###
fileName <- "Data.zip"
if(!file.exists(fileName)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, fileName)
  unzip(fileName)
}

### Read Data ###
content <- readRDS(file = "summarySCC_PM25.rds")
code <- readRDS(file = "Source_Classification_Code.rds")

print(unique(content$year))

aggregateEmi <- aggregate(Emissions ~ year, content, sum)

barplot(aggregateEmi$Emissions/10^6, names.arg = aggregateEmi$year, 
        xlab = "Year", ylab = "Emissions")

dev.copy(png, filename="plot1.png", width=480, height=480)
dev.off ()
