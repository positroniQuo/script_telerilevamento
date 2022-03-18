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
# multiframe
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

dev.off()

par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
