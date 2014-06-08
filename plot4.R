##This script will create 4 plots--1) histogram of global active power
## 2) plot of global active power by day 3) Energy sub metering by day
## 4) plot of global reactive power by day

##load file
mydata<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

##change Date to date format
mydata$Date<-as.Date(mydata$Date,format="%d/%m/%Y")

#filter data to the 2 required days
mynewfile<-mydata[mydata$Date>="2007-02-01"&mydata$Date<="2007-02-02",]

##format time and paste with date
x=paste(as.character(mynewfile$Date),as.character(mynewfile$Time),sep=" ")
y=strptime(x,format = "%Y-%m-%d %H:%M")
mynewfile$Time=y

#change Global Active Power variable to numeric
mynewfile$Global_active_power=
        as.numeric(as.character(mynewfile$Global_active_power))

#change Voltage variable to numeric
mynewfile$Voltage = as.numeric(as.character(mynewfile$Voltage))

#change Sub_metering variables to numeric
mynewfile$Sub_metering_1 = as.numeric(as.character(mynewfile$Sub_metering_1))
mynewfile$Sub_metering_2 = as.numeric(as.character(mynewfile$Sub_metering_2))
mynewfile$Sub_metering_3 = as.numeric(as.character(mynewfile$Sub_metering_3))

##change global_reactive_power variable to numeric
mynewfile$Global_reactive_power = as.numeric(as.character(mynewfile$Global_reactive_power))

#open png device
png("plot4.png",width = 480, height = 480,units = "px", bg="white")

##divide plot into 4 blocks
par(mfrow=c(2,2))
with(mynewfile, {
        ##create plot of Global Active Power to days of week
        plot(mynewfile$Time,mynewfile$Global_active_power,
             ylab="Global Active Power",type="l",xlab="")
        
        ##create plot for Voltage to days of week
        plot(mynewfile$Time,mynewfile$Voltage,ylab="Voltage",type="l",
             xlab="datetime")

        ##create plot for Energy Sub Metering to days of week
        ##setup variables for plot
        x<-mynewfile$Time
        y1<-mynewfile$Sub_metering_1
        y2<-mynewfile$Sub_metering_2
        y3<-mynewfile$Sub_metering_3
        
        #create blank plot
        plot(x,y1,ylab="Energy sub metering", type="n",xlab="")
        #add each Sub_metering variable
        lines(x,y2,col="red")
        lines(x,y1)
        lines(x,y3,col="blue")
        
        ##add legend
        legend("topright",pch="_____",col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               bty="n")
        
        ##create plot for Global reactive power to days of week
        plot(mynewfile$Time,mynewfile$Global_reactive_power,
             ylab="Global_reactive_power",type="l",xlab="datetime")
        
        
        })

##close png device
dev.off()