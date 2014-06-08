##This code will create a plot of global active power by day

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

#change Global Active Power column to numeric
mynewfile$Global_active_power=
        as.numeric(as.character(mynewfile$Global_active_power))

#open png device
png("plot2.png",width = 480, height = 480,units = "px", bg="white")

##create plot of Global Active Power to days of week
plot(mynewfile$Time,mynewfile$Global_active_power,
     ylab="Global Active Power (kilowatts)",type="l",xlab="")

##close png device
dev.off()