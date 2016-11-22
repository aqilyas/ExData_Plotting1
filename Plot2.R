
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

#the 2nd plot
png("Plot2.png", width=480, height=480)

plot(needed_data$exactdate, needed_data$Global_active_power, type='l', xlab="", 
     ylab = "Global Active power (killowatts)")
dev.off()
