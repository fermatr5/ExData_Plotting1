##Load data
setwd("C:/Users/rboll/Desktop")
rawData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Reformat date and take dates between 2007-02-01 and 2007-02-02
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")
data <- subset(rawData, subset=(Date >= "2007-2-1" & Date <= "2007-2-2"))
rm(rawData)

## Delete missing data which are ?
data <- data[complete.cases(data),]

## Combine Date and Time columns and rename, delete those columns
dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")
data <- data[ ,!(names(data) %in% c("Date","Time"))]

## Add DateTime column and reformat
data <- cbind(dateTime, data)
data$dateTime <- as.POSIXct(dateTime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .4)
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Create png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()