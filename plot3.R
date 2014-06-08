csvFile <- "ElectricPowerData.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fName <- "household_power_consumption.zip"
fFile <- "household_power_consumption.txt"

if(!file.exists(csvFile)) {
        download.file(fileUrl,destfile=fName)
        unZipFile <- unz(fName,fFile)
        tbl <- read.table(unZipFile, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
        tbl <- tbl[(tbl$Date == "1/2/2007") | (tbl$Date == "2/2/2007"),]
        tbl$DateTime <- strptime(paste(tbl$Date, tbl$Time), "%d/%m/%Y %H:%M:%S")
        write.csv(tbl, csvFile)
}

elecData <- read.csv(csvFile)
elecData$DateTime <- strptime(elecData$DateTime, "%Y-%m-%d %H:%M:%S")

png(filename = "plot3.png", width = 480, height = 480, units = "px")
lgnd <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
with(elecData,plot(DateTime,Sub_metering_1,"l",ylab="Energy sub metering",xlab=""))
with(elecData,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(elecData,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=lgnd)
dev.off()