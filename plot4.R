
plot4 <- function() {
    ## This function plots a 4 separate graphs
    

    ## This plot4 function leverages the read.csv2.sql function in the 'sqldf' function
    ## Check to see that sqldf is installed and loaded
    if(!require(sqldf)){
        install.packages("sqldf")
        library(sqldf)
    }


    ## Plot4 relies on large dataset from the internet
    ## Check to see ff the file has already been downloaded to the working directory already
    ## if so, move on, if not, warn the user that the download is going to occur and execute
    if(!file.exists("./household_power_consumption.txt")){
        print("Dataset not found. Downloading from internet. This may take a while.")
        desturl<- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        download.file(desturl,"./household_power_consumption.zip")
        unzip("./household_power_consumption.zip")
    }
    
    ## Set vars for loading the data
    targetFile <- "./household_power_consumption.txt"
    sqlStatement <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
    
    ## load the data
    power <- read.csv2.sql(targetFile,sqlStatement,sep=";", na.strings="?")
    power$DateTime <- as.POSIXct(strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")) 
    
    ## create the graph
    png(file="plot4.png", bg = "transparent",width=480, height=480, units="px")
        par(mfcol=c(2,2))
        #graph 1 of 4
        plot(power$DateTime,power$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
        
        
        #graph 2 of 4
        plot(power$DateTime,power$Sub_metering_1,xlab="",ylab="Energy sub metering", type = "n")
        lines(power$DateTime,power$Sub_metering_1, col="black")
        lines(power$DateTime,power$Sub_metering_2, col="red")
        lines(power$DateTime,power$Sub_metering_3, col="blue")
        legend("topright",bty="n",lwd=1,lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        #graph 3 of 4
        plot(power$DateTime, power$Voltage,type="l", xlab="datetime", ylab="Voltage")
        
        #graph 4 of 4
        plot(power$DateTime, power$Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")
    
    dev.off()

}