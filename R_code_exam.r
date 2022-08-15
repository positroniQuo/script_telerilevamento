# Author: Filippo Arceci

# This code processes images taken from sentinel2A/B of the in.cal system (sources of data: EarthExplorer, Copernicus) an abandoned quarry repurposed to be a natural reserve,
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

library(gtools)
library(raster)      # Lettura immagini raster
library(patchwork)   # Composizione grafici
library(ggplot2)     # Grafici
library(RStoolbox)   # Strumenti per la manipolazione di immagini telerilevate
library(viridis)     # Visualizzazione
  
library(rgdal)

setwd("D:/sntl_data")

all_sntl <- list.files(pattern="T32TQP")
# importing files as they have been downloaded, from the working directory [alllst - all landsat]

sntl <- matrix(all_sntl, nrow = 8, ncol = 4, byrow=TRUE)
# making the unsorted data a matrix helps with elaboration:
# rows are for years (1=2015, 2=2016...)
# columns are for bands (1=B2, 2=B3, 3=B4, 4=B8)

lst_sntl <- paste0 ('lst', sprintf ("%02d", as.numeric(15:22))) 
# the last step to obtain the sorted bands for each year is to make a matrix of fitting names to assign them to [lstNN - landsat (years 00s-21s)]

for (i in seq_along (lst_sntl)) {assign (lst_sntl[[i]], stack (sntl[i,]))}
# the ordered data is assigned to the corresponding object stacked, so now it is usable for plotting
# (for example "sntl16" will contain a stack of bands 2, 3, 4, and 8 from july 2016)
