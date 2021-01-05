### Prepare the data set

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, destfile = temp, method = "curl")
household <- read.csv2(file = unz(temp,"household_power_consumption.txt"), 
                       na.strings = "?", colClasses = "character")
unlink(temp)

timeFilter <- as.Date(c("2007-02-01", "2007-02-02"))

library(dplyr)
household <- mutate(household, DateTime = strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S")) %>% 
  select(DateTime,Global_active_power:Sub_metering_3) %>%
  filter(as.Date(DateTime) %in% timeFilter) %>%
  mutate(Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Voltage = as.numeric(Voltage),
         Global_intensity = as.numeric(Global_intensity),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3))

### Construct Plot 4

par(mfrow = c(2,2))
###### Top left
plot(household$DateTime,household$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "") 
###### Top right
plot(household$DateTime,household$Voltage, xlab = "datetime", ylab = "Voltage", type = "l") 
###### Bottom left
plot(household$DateTime,household$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering") 
lines(household$DateTime,household$Sub_metering_2, col = "red")
lines(household$DateTime,household$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"),bty = "n")
##### Bottom right
plot(household$DateTime, household$Global_reactive_power, type = "l", xlab = "datetime", ylab ="Global_reactive_power")     
