library( raster )

# R è CASE SENSITIVE!!!!!!!!!!!!!!!!!!

setwd("C:/lab/") # windows
l2011 <- brick("p224r63_2011.grd")
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) #scelgo una scala di colori adeguata
plot(l2011, col=cl) #visualizzo l'immagine con i colori giusti
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# Colori delle diverse bande
plot(l2011$B1_sre)
#oppure
plot(l2011[[1]])
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011[[1]] , col = clb)

pdf("banda1.pdf") #esporto come pdf
plot(l2011$B1_sre, col=clb)
dev.off()
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)
# multiframe, visualizzazione immagini multiple in  contemporanea
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

dev.off()

par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plottiamo le prime 4 bande separatamente
par(mfrow=c(2,2))
# blu
plot(l2011$B1_sre, col=clb) 
# verde
plot(l2011$B2_sre, col=clg) 
# rosso
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

plotRGB # da recuperare

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
l2006 <- brick("p224r63_2011.grd")
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# + Risoluzione radiometrica= quantità di bit in un'immagine

# DVI Difference Vegetation Index, permette di notare l'evoluzione delle comunità vegetali nel tempo
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
dvi1992 = l1992[[1]] - l1992[[2]]
dvi2006 = l2006[[1]] - l2006[[2]]
dvi_dif = dvi1992 - dvi2006

# NDVI = DVI standardizzato, permette paragoni
# installo rgdal per poter eseguire la funzione brick su jpg
install.packages("rgdal")
l1992 <- brick("defor1_.jpg")
l2006 <- brick("defor2_.jpg")

#calcolo DVI e NDVI ed eseguo i plot in multiframe dei due NDVI per evidenziare le differenze

dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])

dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

par(mfrow=c(2,1))

# lezione da recuperare x2 #

# importo le immagini satellitari utilizzando raster
# utilizzo raster invece di brick perchè necessito solo del primo layer
# potrei utilizzare anche brick specificando di importare solo il primo layer (essendo raster una semplificazione di brick)

en01 <- raster("EN_0001.png")
# info sul topic
# https://www.google.com/search?q=R+colours+names&tbm=isch&ved=2ahUKEwiF-77Z1bX0AhULtKQKHQ3WDWYQ2-cCegQIABAA&oq=R+colours+names&gs_lcp=CgNpbWcQAzIECAAQEzoHCCMQ7wMQJzoICAAQCBAeEBNQiQhYnwxgwg1oAHAAeACAAUqIAZYDkgEBNpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=vKKgYYWtOovokgWNrLewBg&bih=526&biw=1056#imgrc=OtMzJfyT_OwIiM

# eseguo il plottaggio usando una palette personalizzata, sia per il mese di gennaio che per dicembre 
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col=cl)
en13 <- raster("EN_0013.png")
plot(en13, col=cl)
# eseguo nuovamente il plot affiancando le immagini
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

# importo tutte le immagini
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

# Utilizzo della funzione source per importare codici da fonti esterne usando file sul dispositivo: 
# da una sola riga di codice posso ottenere passaggi anche alquanto complessi

# plotto tutte le immagini
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)

# utilizzo la funzione stack per unire i file delle immagini sotto un unico insieme
EN <- stack(EN01, EN02, EN03, EN04, EN05, EN06, EN07, EN08, EN09, EN10, EN11, EN12, EN13)
# plot the stack altogether
plot(EN, col=cl)

# metodo alternativo decisamente più rapido 
rlist <- list.files(pattern="EN") # lapply(X,FUN)
rimp <- lapply(rlist, raster) # stack
en <- stack(rimp)
# plot everything
plot(en, col=cl)
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")
# installo e richiamo il pacchetto RStoolbox
install.packages("RStoolbox")
library(RStoolbox)

#lezione da recuperare

install.packages("ggplot2")

l92 <- brick("defor1_.jpg")
l06 <- brick("defor2_.jpg")
par(mfrow=c(2,1))
plotRGB(l06, 1, 2, 3, stretch="lin")
plotRGB(l92, 1, 2, 3, stretch="lin")
dev.off()
library(ggplot2)
ggRGB(l92, 1, 2, 3, stretch="lin")
ggRGB(l06, 1, 2, 3, stretch="lin")

install.packages("patchwork")
library(patchwork)

P1 <- ggRGB(l92, 1, 2, 3, stretch="lin")
P2 <- ggRGB(l06, 1, 2, 3, stretch="lin")
P1+P2
P1/P2 #ommioooooddioooooooooooooo
l92c <- unsuperClass(l92, nClasses=2)
plot(l92c$map)  #abbinamento cromatico delle classi da specificare 
l06c <- unsuperClass(l06, nClasses=2)
plot(l06c$map)
freq(l92$map) #calcolo con freq il numero di pixels appartenenti ad ogni classe 
freq(l06$map)




