library(dplyr)  #load the dplyr package
  
    #read the data from the working dir
power_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE) 
power <- tbl_df(power_consumption)

power <- mutate(power, date_time = paste(power$Date, power$Time, sep = " "))  #create new column date_time integrating date and time columns

   #subsetting the data according to the required dates
   
dates <- c("01/02/2007", "02/02/2007")
dates <- as.Date(dates, "%m/%d/%Y")  #convert the class to date class
power$Date <- as.Date(power$Date, "%d/%m/%Y")   #convert the class of Date (which is char) column to class = date
power <- subset(power, Date == dates)     #subset the data
power$date_time <- strptime(power$date_time, "%d/%m/%Y %H:%M:%S")        # convert the class of date_time column to posixct and posixlt 
     
      #converting the class of columns into numeric
      
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

  #plot the graph into png Device
  
png(filename = "plot3.png", height = 480, width = 480)
with(power, plot(date_time, Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering"))
lines(power$date_time, power$Sub_metering_2, col = "red")
lines(power$date_time, power$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "blue", "red"))
dev.off() 
