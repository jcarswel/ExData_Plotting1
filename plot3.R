##This code will create a plot of energy sub metering by day

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

##create plot for Energy Sub Metering to days of week
#change Sub_metering variables to numeric
mynewfile$Sub_metering_1 = as.numeric(as.character(mynewfile$Sub_metering_1))
mynewfile$Sub_metering_2 = as.numeric(as.character(mynewfile$Sub_metering_2))
mynewfile$Sub_metering_3 = as.numeric(as.character(mynewfile$Sub_metering_3))

#open png device
png("plot3.png",width = 480, height = 480, units = "px", 
    ylab="Global Active Power",xlab="", bg="white")

with(mynewfile, {
        
        ##setup variables for plot
        x<-mynewfile$Time
        y1<-mynewfile$Sub_metering_1
        y2<-mynewfile$Sub_metering_2
        y3<-mynewfile$Sub_metering_3
        
        #create blank plot
        plot(x,y1,type="n")
        #add each Sub_metering variable
        lines(x,y2,col="red")
        lines(x,y1)
        lines(x,y3,col="blue")
        
        ##add legend
        legend("topright",pch="_____",col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        })
##close png device
dev.off()