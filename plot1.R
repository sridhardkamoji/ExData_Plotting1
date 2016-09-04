# change the working dir to dir where the "household_power_consumption.txt" is saved

library(dplyr)      #load the dplyr package 
power_consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)  # read the data from the txt file
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")   #convert dates into date class

  #subsetting the data based on the dates
  
dates <- c("01/02/2007", "02/02/2007")  
dates <- as.Date(dates, "%d/%m/%Y")
power <- subset(power_consumption, Date == dates)
    
power$Global_active_power <- as.numeric(power$Global_active_power)    #convert class of Global_active_power to numeric
power <- tbl_df(power)    # load into dplyr data frame
power <- mutate(power, Global_active_power_KW = Global_active_power / 1000)  #create new column Global_active_power_KW
power$Global_active_power_KW <- as.numeric(power$Global_active_power_KW)    #convert class of Global_active_power_KW to numeric

  #ploting histogram in png device
png(filename = "plot1.png", width = 480, height = 480)    
hist(power$Global_active_power_KW, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

