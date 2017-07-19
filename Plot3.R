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


### Q3 ### 

balEMI <- subset(EcontentMI, content$fips=="24510")

aggBalEMI <- aggregate(Emissions ~ year+type, balEMI, sum)

ggplot(data=aggBalEMI, aes(x=year, y=Emissions, group=type, color=type)) + geom_line() + 
  geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (tons)") 

dev.copy(png, filename="plot3.png", width=480, height=480)
dev.off ()
