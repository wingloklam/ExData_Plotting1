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

##Convert "Global_active_power to numeric
powerset$Global_active_power<-as.numeric(powerset$Global_active_power)

##Graph and save red histogram
png("plot1.png",width=480,height=480)
hist(powerset$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
