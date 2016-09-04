library(dplyr)    #load the dplyr package
  
    #read the data from the working dir
power_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
power <- tbl_df(power_consumption)

power <- mutate(power, date_time = paste(power$Date, power$Time, sep = " "))  #create new column date_time integrating date and time columns

   #subsetting the data according to the required dates
   
dates <- c("01/02/2007", "02/02/2007")
dates <- as.Date(dates, "%m/%d/%Y")     #convert the class to date class
power$Date <- as.Date(power$Date, "%d/%m/%Y")    #convert the class of Date (which is char) column to class = date
power <- subset(power, Date == dates)     #subset the data
power$date_time <- strptime(power$date_time, "%d/%m/%Y %H:%M:%S") # convert the class of date_time column to posixct and posixlt 
     
      #converting the class of columns into numeric
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
power$Voltage <- as.numeric(power$Voltage)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)

      #plot the graphs into png device
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))     #split the device into 2 rows and 2 columns

plot(power$date_time, power$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power")

plot(power$date_time, power$Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")

plot(power$date_time, power$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
  lines(power$date_time, power$Sub_metering_2, col = "red")
  lines(power$date_time, power$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "blue", "red"))
  
plot(power$date_time, power$Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
