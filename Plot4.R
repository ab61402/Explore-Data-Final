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



#### Q4 ####
coalSCC <- code[grepl('Coal', code$Short.Name, fixed=T), ]
coalEMI <- merge(x=content, y=coalSCC, by="SCC")

aggCoalEMI <- aggregate(Emissions ~ year, coalEMI, sum)

ggplot(data = aggCoalEMI, aes(x=year, y=Emissions)) + geom_line() + geom_text(aes(label=Emissions))+ 
  geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (thousands of tons)" ) + 
  ggtitle("Total United States PM2.5 Coal Emissions")

### The answer is YES
dev.copy(png, filename="plot4.png", width=480, height=480)
dev.off ()
