# you never know


##############vecchio#################
# reversing the color palette on the SWI as higher values are theorized to decrease risk of fires

plot(swi_100, col = rev(alpha(noir, 0.4)), legend=FALSE)

extent(fires)
fires_er <- rasterize(fires, raster(extent(er), ncol=500, nrow=500))




plot(mean_t, col = alpha(viridis(5, option = "turbo"), 0.2), add = T, legend=FALSE)

plot(fc_er, col = alpha(noir, 0.4), legend=FALSE, xlab = "lon", ylab = "lat", add = T)
plot(er, legend=FALSE, add = T)
# fires are represented in a shp containing the area that burnt down for each.
# these areas are very small compared to the regional extention, so to better
# visualize them I calculated the centroids of every polygon representing a fire
# and plotted it so that its dimentions would be dependant on its area.
# Therefore, bigger circles on the plot represent bigger fires.
# The centroids are calculated taking each element of the 103 contained in the
# "fires" SpatialPolygonsDataFrame, making it a simple feature, getting the centroid
# coordinates and making it a spatial element again for plotting.



# the tamperature goes last since it has slightly different extent and different resolution
# from the other datasets, so it won't interphere. Also for showcase purposes it has been 
# shown in a viridis scale ranging from blue to red


grid(NULL, NULL)


###########################################

list_ <- list(fc_er, stemp_er, swi_100)
extent(swi_100)
er_new <- resample(er, fc, method="ngb")
list_c <- lapply(crop(list_,extent(er)))

swi_er <- mask(swi_c, er)
extent(er)
extent(swi_c)
swi_c <- crop(swi_c, c(9.20000, 
                       12.80000 ,
                       43.80000, 
                      45.20000 ))
resample(swi_c, er, method = 'ngb')

plot(fc_er, legend=FALSE)
image(swi_100, col = rev(alpha(noir, 0.4)), legend=FALSE, add = T)

###########################################


# original par() call
par(mfrow=c(1,1))

# first plot
plot(er,
     legend=FALSE)

#second plot and par() call
par(mfrow=c(1,1), new=TRUE)

plot(swi_100, col = rev(alpha(noir, 0.4)), legend=FALSE, ext = extent(er))

#third plot and par() call
par(mfrow=c(1,1), cex=3, mar=c(3,3,3,7), bg=bgcol, col=txtcol, new=TRUE)
plot(r0,
     maxpixels=ncell(r0),
     col="#9e9ac8",
     xaxt='n',
     yaxt='n',
     ext=map_extent, #PRENAFILTERING fix
     bty='n',
     legend=FALSE)

er_prova <- rasterize(er, raster(extent(er), ncol=500, nrow=500))
swi_100
er
image(er_prova)
extent(er_prova)
list_ <- list(fc_er, stemp_er, swi_100)
rs <- paste( 'fc', 'stemp', 'swi')
for (i in seq_along (list_)) {assign (list_[i], resample( list_[[i]] , raster(extent(er), ncol=500, nrow=500)))}
rs[1]
rs[[1]]
rs[i] <- for (i in 1:length(list_)) { 
  resample( list_[[i]] ,raster(extent(er), ncol=500, nrow=500))}
resample( list_[[1]] ,raster(extent(er), ncol=500, nrow=500))
extent(list_[[3]])
list_[[]]
swi_prova <- resample(swi_er, raster(extent(er), ncol=500, nrow=500))
fc_prova <- resample(fc_er, raster(extent(er), ncol=500, nrow=500))
list_[1]
list_[3]
seq_along (list_)
image(swi_prova, add= T)
image(fc_prova, add= T)
extent(swi_prova)
1:length(list_)
1:3
box=extent(er)
yxscale=(box@ymax-box@ymin)/(box@xmax-box@xmin-1)
xsize=5 # in inches
ysize=xsize*yxscale
par(pin=c(xsize,ysize)) # to have a plot extenting to the limits of 

plot(er, bg='red')


library(patchwork)
remove.packages("patchwork")
install.packages('basemaps')
library(patchwork)
library(basemaps)
gg_raster(swi_100)
gg_raster(swi_100, r_type = "gradient")+
  scale_fill_viridis(option = "mako") +
  labs(fill = 'Water Content %') +
  ggtitle("SWI Emilia Romagna") +
  theme(legend.position = c(.26, .32),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(5, 5, 5, 5))


ggplot() +
  geom_raster(swi_100, mapping=aes(x=x,y=y,fill=X2020.07.02)) +
  scale_fill_viridis(option = "mako") +
  labs(fill = 'Water Content %') +
  ggtitle("SWI Emilia Romagna") +
  theme(legend.position = c(.26, .32),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(5, 5, 5, 5))

###########################################
