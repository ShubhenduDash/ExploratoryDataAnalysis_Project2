library("data.table")
library("ggplot2")
library("dplyr")

# Getting current working directory

path <- getwd()

# Downloading and unzipping data

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Read and prepare data

NEI <- readRDS("summarySCC_PM25.rds")
NEIdp <- tbl_df(NEI)

# Table with Motor Vehicle emissions per year of Baltimore

BaltimoraEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=="24510", type=='ON-ROAD'), year), sum(Emissions)) 

#Renamed columns

colnames(BaltimoraEmissionsVehicle) <- c("Year", "Emissions")

# Getting Plot 5 into png format

png('plot5.png')

g <- ggplot(BaltimoraEmissionsVehicle, aes(Year,Emissions))+scale_x_continuous(breaks = c(1999,2002,2005,2008))
g+geom_point(size=4, color='orange')+geom_line(size=1.5,color='orange')+labs(title="Baltimore City: Emissions of motor vehicle", x="Years",y="Emissions (PM 2.5)")
dev.off()