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
png(filename = "plot4.png",
    width = 480,
    height = 480)

# Set mfrow to c(2, 2) for 2x2 plotting
par(mfrow = c(2, 2))

# Could set lwd for finer detail, but some systems don't support it

# Top-left plot
plot(x = data$Date,
     y = data$Global_active_power,
     type = "n",
     xlab = "",
     ylab = "Global Active Power")
lines(x = data$Date,
      y = data$Global_active_power)

# Top-right plot
plot(x = data$Date,
     y = data$Voltage,
     type = "n",
     xlab = "datetime",
     ylab = "Voltage")
lines(x = data$Date,
      y = data$Voltage)

# Bottom-left plot
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
legend("topright",
       bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = "solid")

# Bottom-right plot
plot(x = data$Date,
     y = data$Global_reactive_power,
     type = "n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(x = data$Date,
      y = data$Global_reactive_power)

# Close (and save) PNG device
dev.off()

# Reset locale
Sys.setlocale("LC_TIME", original.locale)
