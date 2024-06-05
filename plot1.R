# wk1proj
library(lubridate)
library(dplyr)


# read file
df <- read.csv("household_power_consumption.txt", sep=";")


# redefine column classes

df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df <- mutate(df, datetime = strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"))


# subset
jul2d <- df %>% subset(datetime >= ymd("2007-07-01") 
                       & datetime < ymd("2007-07-03")) %>% select(-Date, -Time)


# plot1
# find range
summary(jul2d$Global_active_power)

png("plot1.png", width =480, height =480)

with (jul2d, hist(Global_active_power, col="red", breaks = 35,
                  xlab = "Global Active Power (kilowatts)", 
                  main="Global Active Power"))
dev.off()
