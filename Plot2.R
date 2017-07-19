
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



#### Q2 ###### 

balEMI <- subset(content, EMI$fips=="24510")

aggBalEMI <- aggregate(Emissions ~ year, balEMI, sum)

barplot(aggBalEMI$Emissions, names.arg = aggBalEMI$year, 
        xlab = "Year", ylab = "Emissions")


dev.copy(png, filename="plot2.png", width=480, height=480)
dev.off ()

