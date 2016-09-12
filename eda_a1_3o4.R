fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, "./powercons.zip")
zippy <- "./powercons.zip"
unzip(zippy)
powercons <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)

test <- powercons
str(test)

test$Date <- as.Date((test$Date), "%d/%m/%Y")
test$Time2 <- strptime(as.character(test$Time), "%H:%M:%S")
test <- transform(test, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
test$Global_active_power <- as.numeric(test$Global_active_power)
test$Global_reactive_power <- as.numeric(test$Global_reactive_power)
test$Voltage <- as.numeric(test$Voltage)
test$Global_intensity <- as.numeric(test$Global_intensity)
test$Sub_metering_1 <- as.numeric(test$Sub_metering_1)
test$Sub_metering_2 <- as.numeric(test$Sub_metering_2)
test$Sub_metering_3 <- as.numeric(test$Sub_metering_3)


str(test)
head(test)

startdate <-as.Date('2007-02-01')
enddate <-as.Date('2007-02-02')

shorttime <- subset(test, Date==startdate | Date==enddate)

str(shorttime)


#plot3

plot(shorttime$timestamp,shorttime$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy Sub Metering")
lines(shorttime$timestamp,shorttime$Sub_metering_2, type="l", col="red")
lines(shorttime$timestamp,shorttime$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()
