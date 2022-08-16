# Author: Filippo Arceci

# This code processes images taken from sentinel2A/B of the In.Cal.System (sources of data: EarthExplorer, Copernicus) an abandoned quarry repurposed to be a natural reserve,
# water storage and floodplain area near Rimini, next to the Marecchia river(link: https://albopretorio.comune.rimini.it/web/trasparenza/papca-ap?p_
# p_id=jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=downloadAllegato&p_p_cacheability
# =cacheLevelPage&p_p_col_id=column-1&p_p_col_count=1&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_downloadSigned=false&_jcitygovalbopubblicazioni_
# WAR_jcitygovalbiportlet_id=26621&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_action=mostraDettaglio&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_
# fromAction=recuperaDettaglio).
# It is also a part of the Natura2000 network, and a very important wet area fot migratory birds and local fauna ( link: https://www.comune.rimini.it/servizi/ambiente/aree-naturali-protette).
# However, direct observations showed a complete drought of the area in recent times, which nullifies the above mentioned functions of the area.
# To have a better idea of what may have happened, it could be useful to analyse recent data (2015-2022) and search for patterns of change.
# Since july is the dryest month of the year locally (link: https://it.climate-data.org/europa/italia/emilia-romagna/rimini-1176/), 
# it will be the month from which images will be analysed.
# Data include all the 10 mts resolution bands avaiable: RGB and NIR.

# packages will be loaded one by one when needed in the corresponding section

# SUMMARY
# 1 # import and data preparation

# 1 # import and data preparation

library(raster)           

setwd("D:/sntl_data")

all_sntl <- list.files(pattern="T32TQP")
# importing files as they have been downloaded, from the working directory [allsntl = all Sentinel]

sntl <- lapply(all_sntl, raster)
# the data comes in .jp2 format, so i can use the "raster" function on it to process and plot the images with 
# other "raster" package functions

sntl <- matrix(sntl, nrow = 8, ncol = 4, byrow=TRUE)
# making the unsorted data a matrix helps with elaboration:
# rows are for years (1=2015, 2=2016...)
# columns are for bands (1=B2, 2=B3, 3=B4, 4=B8)

lst_sntl <- paste0 ('sntl', sprintf ("%02d", as.numeric(15:22))) 
# the last step to obtain the sorted bands for each year is to make a matrix of fitting names to assign them to
# "sprintf" function combines desired charachters with any variable so every name will be associated with the corresponding year
# [sntlNN = Sentinel (years '15-'22)]

for (i in seq_along (lst_sntl)) {assign (lst_sntl[[i]], stack (sntl[i,]))}
# the ordered data is assigned to the corresponding object stacked, so now it is usable for plotting
# (for example "sntl16" will contain a stack of bands 2, 3, 4, and 8 from july 2016)

plotRGB(sntl16, r=3, g=2, b=1, stretch="lin")
# plot test on a random image from the dataset. Everything seems fine.
# the image will also be used for freehand tracing of the cutting guide

mask <- drawExtent(show=T, col = "red")
# cutting the images to only include the study area requires freehand drawing of a rectangle to sample
# a smaller portion of the images downloaded to fit only the study area, with the "drawExtent() function.
# First, I create a "mask" object,  whose dimentions will be used as a reference for cutting all the layers
# later. Since the image is very big compared to the study area the cycle of drawing and cutting will be
# repeated more than once to get more and more precise cuts, until it fits just right.

lst_sntl_c <- paste0("sntl_c",sprintf ("%02d", as.numeric(15:22)))
# creating new names for the cut images to be assigned at [lst_sntl_c = list of Sentinel-cut]

lst_sntl <- c(sntl15, sntl16, sntl17, sntl18, sntl19, sntl20, sntl21, sntl22)
# let's regroup the individual stacks into a list to cut and then reassign them at the new variables

for (i in seq_along (lst_sntl_c)) {assign (lst_sntl_c[i], crop(lst_sntl[[i]],mask))}
# a simple loop to do the previously stated actions: cutting every stack using "mask" dimentions and assign it to the new variable.
# this procedure is repeated until the resulting images include only the In.Cal.System

plotRGB(sntl_c16, r=3, g=2, b=1, stretch="lin")
# controlling the results:
# everything shows correctly, and thought resolution is still on the coarse side
# the resulting picture is clear enough visually.
# images importing and first processing ends here 

