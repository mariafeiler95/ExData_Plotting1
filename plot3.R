## Note that plot 3 will always be "incorrect" because the professor translated the dates as dmy and not mdy. 
## See https://www.coursera.org/learn/exploratory-data-analysis/discussions/weeks/1/threads/di5xjOy8EeWkUAr_DMJ5Lw
## where the instructor explains the situation. THe black line will not have any "points" due to this error.

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

## Create and save plot3.png
png("plot3.png",
    width = 480,
    height = 480
)
with(plotdata, {
        plot(Sub_metering_1~Datetime, 
             type="l",
             col = "black",
             ylab="Global Active Power (kilowatts)", 
             xlab="",
             ylim = c(0,40))
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

# Maria E. Feiler 2020