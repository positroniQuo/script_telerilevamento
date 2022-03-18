library( raster )
setwd("C:/lab/") # windows
l2011 <- brick("p224r63_2011.grd")
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) #scelgo una scala di colori adeguata
plot(l2011, col=cl) #visualizzo l'immagine con i colori giusti
 # b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# Colori delle diverse bande
