library(dplyr)

data <- read.table("household_power_consumption.txt", header = TRUE, sep =";")


data <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(DateTime = strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S")) %>%
  mutate(Date = as.Date(Date, format ="%d/%m/%Y")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Voltage = as.numeric(Voltage))



png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(data, plot(DateTime, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(data, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering"))
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()