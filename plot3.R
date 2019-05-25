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
png("plot3.png")

# build the graphic
with(hpcd,plot(
  type='l',
  Date.Time,
  Sub_metering_1,xlab="", 
  col="black",
  ylab="Energy sub metering"))
with(hpcd,
     lines(Date.Time,Sub_metering_2,
           col="red"))
with(hpcd,
     lines(Date.Time,
           Sub_metering_3,
           col="blue"))
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("red","blue","black"),
       lty=c(1,1,1),
       lwd=2)

# close and write the png device
dev.off()
