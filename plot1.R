#load data set
#assumes the data has been downloaded and unpacked to the folder Project 1 in the working directory
data <- read.csv("Project week 1/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

#subset the relevant data (dates 2007-02-01 and 2007-02-02)
#convert first column of data to dates
dates <- as.data.frame(strptime(data[,1], format = "%d/%m/%Y")) #very large! 103 Mb
startDate <- strptime("01/02/2007", format = "%d/%m/%Y")
endDate <- strptime("02/02/2007", format = "%d/%m/%Y")

#get all dates larger or equal to start date
relevant <- dates[,1] >=startDate
#subset data
data <- data[relevant,]
dates <- dates[relevant,]
dates <- as.data.frame(dates)
#cut off older dates
relevant <- dates[,1] <= endDate
data <- data[relevant,]
#cleanup unsed variables
rm(list=c("relevant","dates","startDate","endDate"))

# data is ready, now do the graphs 
attach(data) #make working with data columns more convenient


#----------first graph
hist(as.numeric(Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
#save as png
png(filename = "plot1.png", width = 480, height = 480, units = "px")
dev.off()