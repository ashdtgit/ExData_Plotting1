### This is the code for creating plot 1. Steps 1-3 are setting up the data, Step 4 plots.

##Step 1: This portion creates a data directory, downloads the zip file into a temp file, unzips the zip file into the data directory and reads the contents into a dataframe

#load dependencies (not needed?)
library(dplyr)

#clear enviroment
rm(list=ls())

#setup folders
basedir <- getwd()
if (!file.exists("data"))
{
        dir.create("data")
}

#download and unzip into data directory
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl,temp)
unzip(temp,exdir="./data")
unlink(temp)

#read from text file into dataframe
power_full <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

##Step 2: Create a new variable datetime, that is a POSIXct combination of Date and Time

#combine the dates and times into a single variable, then convert into POSIXct (POSIXct is needed for the plots later)
power_full$datetime <- paste(power_full$Date, power_full$Time)
power_full$datetime <- as.POSIXct(strptime(power_full$datetime, format="%d/%m/%Y %H:%M:%S"))

##Step 3: select only the required dates
power_select <- subset(power_full, power_full$Date=="1/2/2007"|power_full$Date=="2/2/2007")

##Step 4: Create the actual histogram plot as a png
png("plot1.png",width=480,height=480)
hist(power_select$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatt)")
dev.off()
