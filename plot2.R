
plot2 <- function() {
    ## This function plots a line graph of the Global Active Power by day
    

    ## This plot2 function leverages the read.csv2.sql function in the 'sqldf' function
    ## Check to see that sqldf is installed and loaded
    if(!require(sqldf)){
        install.packages("sqldf")
        library(sqldf)
    }


    ## Plot2 relies on large dataset from the internet
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
    
    ## create the line graph
    png(file="plot2.png", bg = "transparent", width=480, height=480, units="px")
    plot(power$DateTime,power$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
    dev.off()

}