library(gtools)
library(raster)      # Lettura immagini raster
library(patchwork)   # Composizione grafici
library(ggplot2)     # Grafici
library(RStoolbox)   # Strumenti per la manipolazione di immagini telerilevate
library(viridis)     # Visualizzazione
library(rasterdiv)   

setwd("D:/lst_data")

alllst <- list.files(pattern="LE07_L2SP")
salllst <- as.data.frame(do.call(rbind,strsplit(alllst,"_")))
lst <- alllst[with(salllst, order(V4))]
lst <- matrix(lst, nrow = 22, ncol = 6, byrow=TRUE)
lstlst <- paste0('lst', sprintf("%02d", as.numeric(0:21)))
for (i in seq_along(lstlst)) {assign(lstlst[[i]], stack(lst[i,]))}

