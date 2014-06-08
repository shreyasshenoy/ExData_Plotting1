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

png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(elecData,plot(DateTime,Global_intensity,"l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()