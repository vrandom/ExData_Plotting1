library(dplyr)

# Read the data only up to a small point so it doesn't take too long
data <- read.csv("data/household_power_consumption.txt",
                 colClasses = c(rep("character", 2), rep("numeric", 7)),
                 sep = ";",
                 nrows = 100000,
                 na.strings = "?")
# Convert the date-time variables to POSIXct (no special reason)
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# Start PNG device
png(filename = "plot1.png",
    width = 480,
    height = 480)
# Plot data
hist(data$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
# Close (and save) PNG device
dev.off()
