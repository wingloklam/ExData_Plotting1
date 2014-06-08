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

##Plot and save
png("plot3.png",width=480,height=480)

##Creates work space
plot(powerset$DateTime,powerset$Global_active_power,type="n",ylab="Energy sub metering",xlab="")
##Plots first black line
plot(powerset$DateTime, powerset$Sub_metering_1,col="black", type="l",ylab="Energy sub metering",xlab="")
##Adds red line
lines(powerset$DateTime,powerset$Sub_metering_2, type="l",col="red")
##Addds blue line
lines(powerset$DateTime,powerset$Sub_metering_3, type="l",col="blue")
##Adds legend
legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(1.5,1.5,1.5),col=c("black","red","blue"),pt.cex=2,cex=1)
dev.off()