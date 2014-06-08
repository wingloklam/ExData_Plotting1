##Originally ran on 10.6.8 Mac and R version 3.1.0

##Download data, unzip the file and read it into a table
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="./Electric.zip",method="curl")
unzip("./Electric.zip")
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE)

##Convert "Date" into date character and subset
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
powersub<-subset(data,data$Date=="2007/02/01")
powersub2<-subset(data,data$Date=="2007/02/02")
powerset<-rbind(powersub,powersub2)

##Convert "Global_active_power" into numeric and create DateTime
powerset$Global_active_power<-as.numeric(powerset$Global_active_power)
require("lubridate")
powerset$DateTime <- ymd_hms(paste(powerset$Date,powerset$Time,sep="_"))

##Plot and save line graph
png("plot2.png",width=480,height=480)
plot(powerset$DateTime,powerset$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()