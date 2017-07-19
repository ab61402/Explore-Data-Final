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


### Q5 ###
motorSCC <- code[grepl('vehicle', code$SCC.Level.Two, ignore.case=T), ]
motorEMI <- merge(x=content, y=motorSCC, by="SCC")
motorBalEMI <- subset(motorEMI, motorEMI$fips=="24510")

aggMotorBalEMI <- aggregate(Emissions ~ year, motorBalEMI, sum)

ggplot(data = aggMotorBalEMI, aes(x=year, y=Emissions)) + geom_line() + geom_text(aes(label=Emissions))+ 
  geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (thousands of tons)" ) + 
  ggtitle("Baltimore Emissions from Motorcycle")

dev.copy(png, filename="plot5.png", width=480, height=480)
dev.off ()

