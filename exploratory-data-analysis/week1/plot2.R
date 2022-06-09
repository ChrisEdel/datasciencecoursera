library(dplyr)

data <- read.table("household_power_consumption.txt", header = TRUE, sep =";")


data <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(DateTime = strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S")) %>%
  mutate(Date = as.Date(Date, format ="%d/%m/%Y")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power))



png("plot2.png", width=480, height=480)
with(data, plot(DateTime, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))
dev.off()