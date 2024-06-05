# Wk1proj
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
jan2d <- df %>% subset(datetime >= ymd("2007-02-01") & datetime < ymd("2007-02-03")) %>% select(-Date, -Time)



# plot3


png("plot3.png", width =480, height =480)

plot(jan2d$datetime, jan2d$Sub_metering_1, pch=NA, xlab=NA,
                  xaxt='n',
                  ylab="Energy sub metering")
lines(jan2d$datetime, jan2d$Sub_metering_1, lwd=1)
lines(jan2d$datetime, jan2d$Sub_metering_2, lwd=1, col="red")
lines(jan2d$datetime, jan2d$Sub_metering_3, lwd=1, col="blue")
axis(1, at=seq(from=jan2d$datetime[1],length.out=3,by="day"), 
     labels=weekdays(as.Date(jan2d$datetime[1]) + 0:2, abbreviate=T))


legend <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
col <- c("black","red","blue")
legend("topright", legend=legend, lty=1, col=col)

dev.off()

