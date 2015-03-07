

setwd("C:/Users/Sergio Simioni/Desktop/Data_Science/Exploratory_data_analysis/")

household_power_consumption <- read.csv("./household_power_consumption.txt", colClasses="character", sep=";")


library(lubridate)
library(dplyr)


house<- household_power_consumption
house$Date<- as.Date((house$Date),"%d/%m/%Y")

head(house)

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




par(mfrow = c(2,2), mar = c( 4,5,3,1))
with( household, { 
  plot(Date.Time, Global_active_power,type="l", ylab="Global Active Power ( kilowatts)", xlab="")
  
  plot(Date.Time, Voltage, type="l", ylab="Voltage", xlab="datetime")
  
  
  with( household, plot(Date.Time,Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
  with(subset(household), points(Date.Time, Sub_metering_2, type ="l", col= "red"))
  with(subset(household), points(Date.Time, Sub_metering_3, type ="l", col= "blue"))     
  legend("topright",cex=0.7,  c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), 
         lwd=c(2.5,2.5), col=c("black","blue","red"))
  
  plot(Date.Time, Global_reactive_power, type="l", ylab="Global Reactive Power", xlab="datetime")
})

dev.copy(png, file="./plot4.png", width=550,height=550)
dev.off()     
       