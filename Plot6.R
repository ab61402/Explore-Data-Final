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


#### Q6 #####

motorSCC <- code[grepl('vehicle', code$SCC.Level.Two, ignore.case=T), ]
motorEMI <- merge(x=content, y=motorSCC, by="SCC")
motorBalEMI <- subset(motorEMI, motorEMI$fips=="24510" )
motorLAEMI <-  subset(motorEMI, motorEMI$fips=="06037")
motorBalEMI$city <- "Baltimore"
motorLAEMI$city <- "Los Angeles"
motorBalAndLAEMI <- rbind(motorBalEMI, motorLAEMI)

aggMotorBalAndLAEMI <- aggregate(Emissions ~ year+city, motorBalAndLAEMI, sum)

ggplot(aggMotorBalAndLAEMI, aes(year, Emissions, color = city)) + geom_line() +
  xlab("Year") + ylab(expression("Total PM2.5 Emissions")) + ggtitle("Total Emissions from motor vehicle in Baltimore and Los Angeles")

dev.copy(png, filename="plot6.png", width=480, height=480)
dev.off ()
