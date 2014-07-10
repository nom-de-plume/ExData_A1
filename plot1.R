# Exploratory Data Analysis - Course Project 1
#   This is my work for the first assignment

# download and/or extract file if it does not exist
if (!file.exists('household_power_consumption.txt')) {
	unzip('exdata_data_household_power_consumption.zip');
}

# from here on we assume that household_power_consumption.txt exists 

# load data