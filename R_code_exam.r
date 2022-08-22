# Author: Filippo Arceci

# This code processes images taken from sentinel2A/B of the In.Cal.System (sources of data: EarthExplorer, Copernicus) an abandoned quarry repurposed to be a natural reserve,
# water storage and floodplain area near Rimini, next to the Marecchia river(link: https://albopretorio.comune.rimini.it/web/trasparenza/papca-ap?p_
# p_id=jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=downloadAllegato&p_p_cacheability
# =cacheLevelPage&p_p_col_id=column-1&p_p_col_count=1&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_downloadSigned=false&_jcitygovalbopubblicazioni_
# WAR_jcitygovalbiportlet_id=26621&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_action=mostraDettaglio&_jcitygovalbopubblicazioni_WAR_jcitygovalbiportlet_
# fromAction=recuperaDettaglio).
# It is also a part of the Natura2000 network, and a very important wet area fot migratory birds and local fauna ( link: https://www.comune.rimini.it/servizi/ambiente/aree-naturali-protette).
# However, direct observations showed a complete drought of the area in recent times, which nullifies the above mentioned functions of the area.
# To have a better idea of what may have happened, it could be useful to analyse recent data (2015-2022) to see if water have been decreasing stably,
# and, if so, how vegetation responded to the drought (with the NDVI index)
# Since july is the dryest month of the year locally (link: https://it.climate-data.org/europa/italia/emilia-romagna/rimini-1176/), 
# it will be the month from which images will be analysed.
# Data include all the 10 mts resolution bands avaiable: RGB and NIR.
# There will be the least repetitions possible in the code comments, unless needed to understand difficult passages.

# NAMES OF THE USED BANDS

"T32TQP_20150704T101006_B02.jp2"     "T32TQP_20150704T101006_B03.jp2"     "T32TQP_20150704T101006_B04.jp2"    
[4] "T32TQP_20150704T101006_B08.jp2"     "T32TQP_20160718T101032_B02.jp2"     "T32TQP_20160718T101032_B03.jp2"    
[7] "T32TQP_20160718T101032_B04.jp2"     "T32TQP_20160718T101032_B08.jp2"     "T32TQP_20170720T100031_B02.jp2"    
[10] "T32TQP_20170720T100031_B03.jp2"     "T32TQP_20170720T100031_B04.jp2"     "T32TQP_20170720T100031_B08.jp2"    
[13] "T32TQP_20180720T100029_B02_10m.jp2" "T32TQP_20180720T100029_B03_10m.jp2" "T32TQP_20180720T100029_B04_10m.jp2"
[16] "T32TQP_20180720T100029_B08_10m.jp2" "T32TQP_20190720T100031_B02.jp2"     "T32TQP_20190720T100031_B03.jp2"    
[19] "T32TQP_20190720T100031_B04.jp2"     "T32TQP_20190720T100031_B08.jp2"     "T32TQP_20200727T101031_B02_10m.jp2"
[22] "T32TQP_20200727T101031_B03_10m.jp2" "T32TQP_20200727T101031_B04_10m.jp2" "T32TQP_20200727T101031_B08_10m.jp2"
[25] "T32TQP_20210707T100559_B02_10m.jp2" "T32TQP_20210707T100559_B03_10m.jp2" "T32TQP_20210707T100559_B04_10m.jp2"
[28] "T32TQP_20210707T100559_B08_10m.jp2" "T32TQP_20220714T100041_B02.jp2"     "T32TQP_20220714T100041_B03.jp2"    
[31] "T32TQP_20220714T100041_B04.jp2"     "T32TQP_20220714T100041_B08.jp2"    

# SUMMARY

# 1 # IMPORT AND DATA PREPARATION
## 2 ## LAND COVER
### 3 ### VEGETATION RESPONSE



# 1 # IMPORT AND DATA PREPARATION



library(raster)   
library(viridis)
library(ggplot2)
library(RStoolbox)
library(patchwork)

setwd("D:/sntl_data")

all_sntl <- list.files(pattern="T32TQP")
# importing files as they have been downloaded, from the working directory [allsntl = all Sentinel]

sntl <- lapply(all_sntl, raster)
# the data comes in .jp2 format, so I can use the "raster" function on it to process and plot the images with 
# other "raster" package functions

sntl <- matrix(sntl, nrow = 8, ncol = 4, byrow=TRUE)
# making the unsorted data a matrix helps with elaboration:
# rows are for years (1=2015, 2=2016...)
# columns are for bands (1=B2, 2=B3, 3=B4, 4=B8)
