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

