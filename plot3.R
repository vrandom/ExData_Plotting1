library(dplyr)

# Read the data only up to a small point so it doesn't take too long
data <- read.csv("data/household_power_consumption.txt",
                 colClasses = c(rep("character", 2), rep("numeric", 7)),
                 sep = ";",
                 nrows = 100000,
                 na.strings = "?")
# Convert the date-time variables to POSIXct (no special reason)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")
data$Date <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Set locale temporarily to English for time conversions
original.locale = Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English_United States.1252")

# Start PNG device
png(filename = "plot3.png",
    width = 480,
    height = 480)
# Plot data
plot(x = data$Date,
     y = data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
points(x = data$Date,
       y = data$Sub_metering_2,
       type = "l",
       col = "red")
points(x = data$Date,
       y = data$Sub_metering_3,
       type = "l",
       col = "blue")
# Plot legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = "solid")
# Close (and save) PNG device
dev.off()

# Reset locale
Sys.setlocale("LC_TIME", original.locale)
