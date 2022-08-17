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

sntl <- c(sntl15, sntl16, sntl17, sntl18, sntl19, sntl20, sntl21, sntl22)
# let's regroup the individual stacks into a list to cut and then reassign them at the new variables

for (i in seq_along (lst_sntl_c)) {assign (lst_sntl_c[i], crop(sntl[[i]],mask))}
# a simple loop to do the previously stated actions: cutting every stack using "mask" dimentions and assign it to the new variable.
# this procedure is repeated until the resulting images include only the In.Cal.System

plotRGB(sntl_c16, r=3, g=2, b=1, stretch="lin")
# controlling the results:
# everything shows correctly, and thought resolution is still on the coarse side
# the resulting picture is clear enough visually.
# images importing and first processing ends here 



## 2 ## land cover



library(viridis)
library(graphics)
library(patchwork)
library(RStoolbox)

jpeg("comparison.jpeg")

par(mfrow=c(2,1))

plotRGB(sntl_c15, r=3, g=2, b=1, stretch="hist")
plotRGB(sntl_c22, r=3, g=2, b=1, stretch="hist")

dev.off()
# to begin, let's have a look at the first image (2015) paired with the last (2022) plotted in visible colours 
# we can already see a drastic change in the complete disappearing of the lakes to the right
# to have a better idea of how the surrounding environment have shifted in cover over time 
# I will be dividing the images into groups of values using the unsuperclass function

sntl_c <- c(sntl_c15, sntl_c16, sntl_c17, sntl_c18, sntl_c19, sntl_c20, sntl_c21, sntl_c22)
# sntl_c is a list containing all the cut images that i can call at need to process all at once

lst_class <- paste0 ('class', sprintf ("%02d", as.numeric(15:22))) 
# other names for the classified images to be assigned at [lst_class = list of classified, classNN = classified (years 2015-2022)] 

for (i in seq_along (lst_class)) {assign (lst_class[[i]], unsuperClass(sntl_c[[i]], nSamples = 100, nClasses = 5, nStarts =50))}
# this loop assigns to every "lst_class" entity its classified raster counterpart

class <- c(class15, class16, class17, class18 ,class19, class20 , class21, class22)
# let's group the resulting images into another list.
# please note that every object is made of 3 components: $call, $model and $map
# this makes the list 24 objects long, but we can easily call for the same components
# because they repeat every 3 items.
# this means that, for example, "class[[2]]" corresponds to "class15$model" whereas "class[[5]]" corresponds to "class16$model"


for (i in 1:8) {plot(class[[i*3]], col=viridis(5))}
# printing every resulting image there seems to be an issue:
# every image has different colours for similar entities.
# this is because "unsuperClass" randomly assigns centroids on which the splits are based, in no particular order,
# and when plotting the 5 classes are assigned increasingly at the fixed colour pattern

for (i in 1:8) {print(freq(class[[i*3]]))}
# it is not possible to directly influence "unsuperClass" to order its classes, but to increase consistency there
# is a way to indirectly order them from lowest frequency of occurrence to highest

is.sorted = Negate(is.unsorted)
# I'll need this later.
# "is.sorted" equals the opposite of "is.unsorted"
# that means that for decreasingly ordered arguments the output will be "false"
# and for increasing ones it will be "true"

for( i in 1:8) {while(is.unsorted(freq(class[[i*3]])[,2])) 
{assign (lst_class[[i]], unsuperClass(sntl_c[[i]], nSamples = 100, nClasses = 5, nStarts =50)) ;
  class <- c(class15, class16, class17, class18 ,class19, class20 , class21, class22);
  print(i)}}
# since "unsuperClass" is random, repeating the process indefinitely will eventually lead to an increasingly occurring 
# set of classes for the classified raster.
# using the "while" function i can specify a condition i want to become false, so that while it remains true a loop is launched.
# so in this case I specify that for i in 1:8 times (once per image), while the current i-th image has unordered frequencies of classes
# a loop of re-splitting images, reassigning them to their variable anew and resampling the "class" group from which the conditions are tested
# is launched, also printing the i-th number as a way to monitor the process and know when a variable is ordered, and the loop jumps to another

for (i in 1:8) {plot(class[[i*3]], col=viridis(5))}
# now more images share colours with one another, and we know that the yellow (5th) band will always be the most abundant,
# and the dark purple (1st) will be the least abundant one
