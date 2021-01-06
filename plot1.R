# Download the data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, destfile = temp, method = "curl")
# Load the data into R
household <- read.csv2(file = unz(temp,"household_power_consumption.txt"), 
                       na.strings = "?", colClasses = "character")
unlink(temp)
# Filter days we need
timeFilter <- as.Date(c("2007-02-01", "2007-02-02"))
library(dplyr)
# Tidy up the data set
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

# Open PNG device; create "plot1.png" in the working directory
png("plot1.R", width = 480, height = 480)
# Send plot 1 to the file device
hist(household$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
# Turn off the PNG file device
dev.off()


      
      
      
      
      
