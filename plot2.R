# UCI individual household electric power consumption Datset
# downloaded from url https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Library "sqldf" needed for sql query 
# Other library autoladed: gsubfn, RSQLite, DBI, tcltk
require(sqldf)

# Inputfile variable set to local dataset
if(file.exists("household_power_consumption.txt")) {
        fileUrl <- "household_power_consumption.txt"
}else {
        stop("File 'household_power_consumption.txt' not found!!!")
}

# Form sql query to extract only "1/2/2007" to "2/2/2007" rows
extract <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"

# Load data using sql query
ucidata <- read.csv.sql(fileUrl, sql=extract, sep=";")

# Create new column that combines Date and Time and convert to POSIXct date format
ucidata$DT <- as.POSIXct(strptime(paste(ucidata$Date, ucidata$Time), "%d/%m/%Y %H:%M:%S"))

# Plot2 - line plot for DateTime and Global active power
plot(ucidata$DT, ucidata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Save plot2 to png file
dev.copy(png, width = 480, height = 480, file = "plot2.png")
dev.off()