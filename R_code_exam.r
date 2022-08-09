# Author: Filippo Arceci

# This code processes landsat 7 ETM+ (landsat 2 - collection 2) images of the in.cal system, an abandoned quarry repurposed to be a natural reserve,
# water storage and floodplain area near Rimini, next to the Marecchia river(link: https://albopretorio.comune.rimini.it/web/trasparenza/papca-ap?p_
# p_id=jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=downloadAllegato&p_p_cacheability
# =cacheLevelPage&p_p_col_id=column-1&p_p_col_count=1&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_downloadSigned=false&_jcitygovalbopubblicazioni_
# WAR_jcitygovalbiportlet_id=26621&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_action=mostraDettaglio&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_
# fromAction=recuperaDettaglio).
# It is also a part of the Natura2000 network, and a very important wet area fot migratory birds and local fauna ( link: https://www.comune.rimini.it/servizi/ambiente/aree-naturali-protette).
# However, direct observations showed a complete drought of the area in recent times, which nullifies the above mentioned functions of the area.
# To have a better idea of what may have happened, it could be useful to analyse recent data (00s-21s) and search for patterns.
# Since july is the dryest month of the year locally (link: https://it.climate-data.org/europa/italia/emilia-romagna/rimini-1176/)
# the first 6 bands of landsat images taken in july have been downloaded and included in this analysis.


library(gtools)
library(raster)      
library(patchwork)   
library(ggplot2)     
library(RStoolbox)   
library(viridis)    
library(rasterdiv)   

setwd("D:/lst_data")

alllst <- list.files(pattern="LE07_L2SP")
# importing files as they have been downloaded, from the working directory [alllst - all landsat]
# files are not sorted correctly by date, so we will need to sort them manually

salllst <- as.data.frame (do.call (rbind,strsplit (alllst,"_"))) 
# making a call for splitting the files' names into smaller sections using the "_" character,
# to use the sequences as references to order the file names [salllst - split all landsat]

lst <- alllst[with (salllst, order (V4))]
# assigning to a new variable the chronologically sorted data [lst - landsat]
# the 4th segment [V4] of landsat data file names contains the date in which the photo is taken

lst <- matrix(lst, nrow = 22, ncol = 6, byrow=TRUE) 
# making the dataset a matrix for further managing of the data: 
# 22 rows (years 00s to 21s) and 6 columns (for each year the bands from 1st to 6th have been downloaded)

lstlst <- paste0 ('lst', sprintf ("%02d", as.numeric(0:21))) 
# the last step to obtain the sorted bands for each year is to make a matrix of fitting names [lstNN - landsat (years 00s-21s)]
                                                             
for (i in seq_along (lstlst)) {assign (lstlst[[i]], stack (lst[i,]))}
# the ordered data is assigned to the corresponding object stacked, so now it is usable for plotting
# (for example "lst16" will contain a stack of the first 6 bands from the july 2016 photo)

plotRGB(lst02, r=3, g=2, b=1, stretch="lin")
