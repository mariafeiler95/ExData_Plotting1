## Get data into working directory, named household_power_consumption.txt
filename <- "Coursera_JHDS4_Week1.zip"
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename)
}
if (!file.exists("Courera_JHDS4_Week1.zip")) { 
        unzip(filename) 
}

## Reads data from file into dataframe and gets data from 2007-02-01 and 2007-02-02.
housepower <- read.csv("household_power_consumption.txt", 
                       header = TRUE,
                       sep = ";")
plotdata <- subset(housepower, Date == "2/1/2007" | Date == "2/2/2007")

## Combine Date and Time columns 
plotdata$Date <- as.Date(plotdata$Date, format="%m/%d/%Y")
datetime <- paste(as.Date(plotdata$Date), plotdata$Time)
plotdata$Datetime <- as.POSIXct(datetime)
plotdata <- plotdata[ , !names(plotdata) %in% c("Date", "Time")] 
plotdata <- plotdata[,c(ncol(plotdata),1:(ncol(plotdata)-1))]

## Turn data into numerics
plotdata$Global_active_power <- as.numeric(as.character(plotdata$Global_active_power))
plotdata$Global_reactive_power <- as.numeric(as.character(plotdata$Global_reactive_power))
plotdata$Voltage <- as.numeric(as.character(plotdata$Voltage))
plotdata$Global_intensity <- as.numeric(as.character(plotdata$Global_intensity))
plotdata$Sub_metering_1 <- as.numeric(as.character(plotdata$Sub_metering_1))
plotdata$Sub_metering_2 <- as.numeric(as.character(plotdata$Sub_metering_2))
plotdata$Sub_metering_3 <- as.numeric(as.character(plotdata$Sub_metering_3))

## Create and save plot2.png
gap <- plotdata$Global_active_power
dateTime <- plotdata$Datetime
png("plot2.png",
    width = 480,
    height = 480
)
plot(plotdata$Global_active_power ~ plotdata$Datetime,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)
dev.off()

# Maria E. Feiler 2020