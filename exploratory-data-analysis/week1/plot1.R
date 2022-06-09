library(dplyr)

data <- read.table("household_power_consumption.txt", header = TRUE, sep =";")


data <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Date = as.Date(Date, format ="%d/%m/%Y")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power))



png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()