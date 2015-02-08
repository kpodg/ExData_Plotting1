############################################################################
#       Exploratory Data Analysis: Project 1                               #
#                                                                          #
#       With UC Irvine Machine Learning Repository:                        #
#               Individual household electric power consumption Data Set   #
#                                                                          #
#       Lichman, M. (2013). UCI Machine Learning Repository                #
#       [http://archive.ics.uci.edu/ml].                                   #
#       Irvine, CA: University of California, School of Information and    #
#       Computer Science.                                                  #
#                                                                          #
############################################################################

#
# This script assumes the downloaded dataset is already uncompressed.
# Only data from 2007-02-01 and 2007-02-02 will be imported and used.

# Get working directory
wd <- getwd()

# Get the dataset for import
# This will change the working diretory to where the file is located.
fname <- file.choose()

# Reset working directory
setwd(wd)

## Import data
# Get data column titles
header <- read.table(fname, sep=';', header=FALSE, nrows=1, stringsAsFactors=FALSE)

# Read in the dates as strings
dates <- read.table(fname, sep=';',
                    colClasses=c('character', rep('NULL',8)), header=TRUE)

# Find record indicies for 2007-02-01 and 2007-02-02
# expressed in dataset as 1/2/2007 and 2/2/2007
daterange <- c('1/2/2007', '2/2/2007')
sampleRecords <- which(dates[,1] %in% daterange)

# Remove unneeded variable dates
rm(dates)

# Calculate number rows to skip and number of rows to import
skip <- sampleRecords[1]-1
nrows <- length(sampleRecords)

# Import data
sample <- read.table(fname, sep=';', header=FALSE, na.strings='?',
                     skip=skip, nrows=nrows, stringsAsFactors=FALSE)

# Skipping rows removes column titles
# Add back column titles
colnames(sample) <- header


## Plot 4
# Create datetime column by combining Date and Time values
sample$datetime <- strptime(paste(sample$Date, sample$Time), '%d/%m/%Y %H:%M:%S')

# Plot to screen
# 2 by 2 grid
# Plot margins in screen are different from plot margins output to PNG
par(mfrow=c(2,2), mar=c(4.5,4,2,1.5))

# plot 1,1
with(sample, plot(datetime, Global_active_power, type='s',
                  xlab='', ylab='Global Active Power', main=''))
# plot 1,2
with(sample, plot(datetime, Voltage, type='s',
                  xlab='datetime', ylab='Voltage', main=''))
# plot 2,1
with(sample, {
        plot(datetime, Sub_metering_1, type='s', xlab='',
             ylab='Energy sub metering')
        
        lines(datetime, Sub_metering_2, type='s', col='red')
        lines(datetime, Sub_metering_3, type='s', col='blue')
})
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1,1), col=c('black', 'red', 'blue'), bty='n', cex=0.5)

# plot 2,2
with(sample, plot(datetime, Global_reactive_power, type='s',
                  xlab='datetime', ylab='Global_reactive_power', main=''))

# Output PNG plot: plot4.png
png('plot4.png', width = 480, height = 480, units = "px")
par(mfrow=c(2,2), mar=c(5,4,3,1.5))
with(sample, {
        plot(datetime, Global_active_power, type='s',
                  xlab='', ylab='Global Active Power', main='')

        plot(datetime, Voltage, type='s',
                  xlab='datetime', ylab='Voltage', main='')

        plot(datetime, Sub_metering_1, type='s', xlab='',
             ylab='Energy sub metering')        
        lines(datetime, Sub_metering_2, type='s', col='red')
        lines(datetime, Sub_metering_3, type='s', col='blue')
        legend('topright',
               c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
               lty=c(1,1), col=c('black', 'red', 'blue'), bty='n', cex=1)
        
        plot(datetime, Global_reactive_power, type='s',
                xlab='datetime', ylab='Global_reactive_power', main='')
        })
dev.off()