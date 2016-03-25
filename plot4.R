
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

#create a new column with dates including times 
data[,length(data)+1] <- paste(data[,1],data[,2])

t <- strptime(x=data[,10],format = "%d/%m/%Y %H:%M:%S")
t <- as.data.frame(t)
data[,10] <- t

#---------fourth graph
par(mfrow=c(2,2))

#first panel
plot(x=data[10],y=Global_active_power, type="l", ylab ="Global Active Power",xlab="")
#second panel
plot(x=data[,10],y=as.numeric(Voltage),xlab = "datetime",ylab = "Voltage",type="l")
#third panel
plot(x=data[,10],y=Sub_metering_1,type="l",col="black",xlab="", ylab="Energy sub metering")
lines(x=data[,10],y=Sub_metering_2,type="l",col="red",xlab="")
lines(x=data[,10],y=Sub_metering_3,type="l",col="blue",xlab="")
legend("topright",c("Sm 1         ","Sm 2","Sm 3"),lty = c(1,1,1), col = c("black","red","blue"), bty ="n")
#fourth panel
plot(x=data[,10],y=Global_reactive_power,xlab = "datetime",type="l")
#save
png(filename = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
