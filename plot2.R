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
jul2d <- df %>% subset(datetime >= ymd("2007-07-01") & datetime < ymd("2007-07-03")) %>% select(-Date, -Time)


# plot2


png("plot2.png", width =480, height =480)

with (jul2d, plot(datetime,Global_active_power, 
                  pch = NA, 
                  xlab =NA,
                  xaxt ='n',
                  ylab = "Global Active Power (kilowatts)"))
lines(jul2d$datetime, jul2d$Global_active_power, lwd = 1)
axis(1, at=seq(from=jul2d$datetime[1],length.out=3,by="day"), 
     labels=weekdays(as.Date(jul2d$datetime[1]) + 0:2, abbreviate=T))

dev.off()
