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
png(filename = "plot2.png",
    width = 480,
    height = 480)
# Plot data
plot(x = data$Date,
     y = data$Global_active_power,
     type = "n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(x = data$Date,
      y = data$Global_active_power)
# Close (and save) PNG device
dev.off()

# Reset locale
Sys.setlocale("LC_TIME", original.locale)
