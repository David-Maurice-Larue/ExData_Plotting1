# Preliminaries: Set working directory,activate the readr (read rectangle) library, dplyr,lubridate
setwd("C:/Users/david/Documents/R/datasciencecoursera/datascience-course4-week1-project")
library(readr)
library(dplyr)
library(lubridate)

# Prepare DataFrameCallback function f for read_delim_chanked. This subsets the data on two specific dates
f <- function(x, pos) subset(x, Date == "1/2/2007"|Date == "2/2/2007")

# fast readr of the large file
hpc<-read_delim_chunked("household_power_consumption.txt",DataFrameCallback$new(f),col_names=TRUE,delim=";",na=c("","?"),col_types="ccnnnnnnn")

# build a column of type Date
hpcd=mutate(hpc,Date.Time=dmy_hms(paste(Date,Time)))

# open the png device for writing graphics to a png file
png("plot4.png")

# build the graphic
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(hpcd, {
  plot(Date.Time,
       Global_active_power,
       type="l",
       xlab="",
       ylab="Global Active Power (kilowatts)")
  plot(type='l',
       Date.Time,
       Sub_metering_1,
       xlab="", 
       col="black",
       ylab="Energy sub metering")
  lines(Date.Time,
        Sub_metering_2,col="red")
  lines(Date.Time,
        Sub_metering_3,col="blue")
  legend("topright",
         legend=c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
         col=c("black","red","blue"),
         lty=c(1,1,1),lwd=2)
  plot(Date.Time,
       Voltage,
       type="l",
       xlab="datetime",
       ylab="Voltage")
  plot(Date.Time,
       Global_reactive_power,
       type="l",
       xlab="",
       ylab="Global_reactive_power")
})

# close and write the png device
dev.off()
