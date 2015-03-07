

household_power_consumption <- read.csv("./household_power_consumption.txt", colClasses="character", sep=";")

library(lubridate)
library(dplyr)

house<- household_power_consumption
house$Date<- as.Date((house$Date),"%d/%m/%Y")

house_1<- filter(house, Date=="2007-02-01")
house_2<- filter(house, Date=="2007-02-02")
household<- rbind(house_1,house_2)

household$Global_active_power<- as.numeric(household$Global_active_power)
household$Global_reactive_power<- as.numeric(household$Global_reactive_power)
household$Global_intensity<- as.numeric(household$Global_intensity)
household$Voltage<- as.numeric(household$Voltage)
household$Sub_metering_1<- as.numeric(household$Sub_metering_1)
household$Sub_metering_2<- as.numeric(household$Sub_metering_2)
household$Sub_metering_3<- as.numeric(household$Sub_metering_3)

household$Date.Time= as.POSIXct(paste(as.Date(household$Date, format = "%m-%d-%Y"), 
                                                            household$Time), format = "%Y-%m-%d %H:%M")
head(household)

with( household, plot(Date.Time,Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(subset(household), points(Date.Time, Sub_metering_2, type ="l", col= "red"))
with(subset(household), points(Date.Time, Sub_metering_3, type ="l", col= "blue"))     
legend("topright", cex= 0.5, c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1) , 
       lwd=c(2.5,2.5), col=c("black","blue","red"))


dev.copy(png, file="./plot3.png", width=480, height=480)
dev.off()


       
