
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./electrodata.zip")
unzip("electrodata.zip")

#Read into R only the needed subset of the data (there is a difference between 2888 rows and 2m rows)

needed_data= read.table("./household_power_consumption.txt", header=TRUE, sep=';',
                        skip= 66636, nrows=2880, 
                        col.names = colnames(read.table("./household_power_consumption.txt", 
                                                        sep=";", nrow = 1, header = TRUE)))
#Converting Date column to date format
needed_data$Date = as.Date(needed_data$Date, '%d/%m/%Y')

needed_data$exactdate = paste(needed_data$Date, needed_data$Time) #concatenation

needed_data$exactdate = as.POSIXct(needed_data$exactdate) 

#the 3rd plot
png("Plot3.png", width=480, height = 480)
with(needed_data, {
  plot(exactdate, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(exactdate, Sub_metering_2,col='Red')
  lines(exactdate, Sub_metering_3,col='Blue')
})
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

dev.off()