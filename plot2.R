library(dplyr)  #load dplyr package
  #read the data from the working dir
power_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
power <- tbl_df(power_consumption)
power <- mutate(power, date_time = paste(power$Date, power$Time, sep = " "))  #create new column date_time integrating date and time columns

  #subsetting the data according to the required dates
dates <- c("01/02/2007", "02/02/2007")
dates <- as.Date(dates, "%m/%d/%Y")   #convert the class to date class
power$Date <- as.Date(power$Date, "%d/%m/%Y")   #convert the class of Date (which is char) column to class = date
power <- subset(power, Date == dates)     #subset the data

power$date_time <- strptime(power$date_time, "%d/%m/%Y %H:%M:%S")   # convert the class of date_time column to posixct and posixlt 
power$Global_active_power <- as.numeric(power$Global_active_power)  # convert the class to numeric

  #plot the graph into png device
png(filename = "plot2.png", width = 480, height = 480)
plot(power$date_time, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
