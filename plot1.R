# Exploratory Data Analysis - Course Project 1 - plot1
#   This is my work for the first assignment (plot 1)

#Should move loading data to another function/script as it is common to all plots

#load necessary libraries
library(sqldf)

#static variables
doLoadData <- FALSE #choose whether to load the data from the file (just shortcut if data is already loaded)

urlFileName <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFileName <- "./exdata_data_household_power_consumption.zip"
csvFileName <- "./household_power_consumption.txt"

begDate <- '1/2/2007' ##dd/mm/yyyy
endDate <- '2/2/2007' 

# download and/or extract file if it does not exist
if (!file.exists(zipFileName)) {
	download.file(urlFileName, zipFileName, 'curl')
}

if (!file.exists(csvFileName)) {
	unzip(zipFileName);
}

# from here on we assume that household_power_consumption.txt exists 

# load data

#not working - review later...
#mySql <- paste("SELECT * FROM file WHERE Date>='",begDate,"' AND Date<='",endDate,"'",sep="")
#dfData <- read.csv2.sql(csvFileName ,mySql, colClasses = c("Date", "character", "numeric",                        
#              "numeric", "numeric", "numeric",
#		"numeric", "numeric", "numeric"))

# load data using character date
mySql <- paste("SELECT * FROM file WHERE Date='",begDate,"' OR Date='",endDate,"'",sep="")
if (doLoadData) {
	dfData <- read.csv2.sql(csvFileName ,mySql)

	#Convert Column classes
	dfData$Date <- as.Date(dfData$Date)
	dfData$Time <- strptime(dfData$Time, '%T')

	#need to concatenate time and date
	dfData$DateTime <- as.POSIXct(paste(dfData$Date, dfData$Time), format="%d/%m/%Y %T")
}

#Do the actual histogram plot and export to png
png(file = 'plot1.png', 
		width = 480, 
		height = 480,
		bg = 'transparent')

hist(dfData$Global_active_power, 
		col = 'red',
		main = 'Global Active Power',
		xlab = 'Global Active Power (kilowatts)')

dev.off()