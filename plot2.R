############################################################################
#       Exploratory Data Analysis: Project 1 Plot 2                        #
#                                                                          #
#       UC Irvine Machine Learning Repository:                             #
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


## Plot 2
# Create datetime column by combining Date and Time values
sample$datetime <- strptime(paste(sample$Date, sample$Time), '%d/%m/%Y %H:%M:%S')

# Plot to screen
with(sample, plot(datetime, Global_active_power, type='s',
                  xlab='', ylab='Global Active Power (kilowatts)', main=''))

# Output PNG plot: plot2.png
png('plot2.png', width = 480, height = 480, units = "px")
with(sample, plot(datetime, Global_active_power, type='s',
                  xlab='', ylab='Global Active Power (kilowatts)', main=''))
dev.off()