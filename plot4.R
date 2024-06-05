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
jul2d <- df %>% subset(datetime >= ymd("2007-07-01") & datetime < ymd("2007-07-03")) %>% select(-Date, -Time)



# plot4


png("plot4.png", width =480, height =480)

par(mfrow=c(2,2))

# topleft pane
with (jul2d, plot(datetime,Global_active_power, 
                  pch = NA, 
                  xlab =NA,
                  xaxt ='n',
                  ylab = "Global Active Power"))
lines(jul2d$datetime, jul2d$Global_active_power, lwd = 1)
axis(1, at=seq(from=jul2d$datetime[1],length.out=3,by="day"), 
     labels=weekdays(as.Date(jul2d$datetime[1]) + 0:2, abbreviate=T))

# topright pane
with (jul2d, plot(datetime,Voltage, 
                  pch = NA, 
                  xaxt ='n'))
lines(jul2d$datetime, jul2d$Voltage, lwd = 1)
axis(1, at=seq(from=jul2d$datetime[1],length.out=3,by="day"), 
     labels=weekdays(as.Date(jul2d$datetime[1]) + 0:2, abbreviate=T))

# bottomleft pane
plot(jul2d$datetime, jul2d$Sub_metering_1,
                  pch=NA, 
                  xlab=NA,
                  xaxt='n', ylim=c(0,125),
                  ylab="Energy sub metering")
lines(jul2d$datetime, jul2d$Sub_metering_1, lwd=1)
lines(jul2d$datetime, jul2d$Sub_metering_2, lwd=1, col="red")
lines(jul2d$datetime, jul2d$Sub_metering_3, lwd=1, col="blue")
axis(1, at=seq(from=jul2d$datetime[1],length.out=3,by="day"), 
     labels=weekdays(as.Date(jul2d$datetime[1]) + 0:2, abbreviate=T))

legend <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
col <- c("black","red","blue")
legend("topright", legend=legend, lty=1, bty="n",col=col)

# bottomright pane
with (jul2d, plot(datetime,Global_reactive_power, pch = NA, xaxt ='n'))
lines(jul2d$datetime, jul2d$Global_reactive_power, lwd = 1)
axis(1, at=seq(from=jul2d$datetime[1],length.out=3,by="day"), 
     labels=weekdays(as.Date(jul2d$datetime[1]) + 0:2, abbreviate=T))


dev.off()
