# Practice for exam               
# There will be no comments for repetitions

# First I need a package to operate with raster data. For this I install the "raster" package, and then make it useable via the function "library"

install.packages("raster")
library(raster)

# Then i need a working directory for our code, data and outputs to go, so we create one eand we set it to be used by this code

setwd("C:/lab_2/")

# I import my first landsat raster image. To do this we use the "brick" function, that imports the image with all raster layers

l2011 <- brick("p224r63_2011.grd")

# Lest's check how the import went

l2011

# These are some of the bands landsat ETM+ images have, depending on the wavelenght registered:
# b1 = blue
# b2 = green
# b3 = red
# b4 = NIR, or Near InfraRed
# Some wavelenghts are useful for specific analysis', like NIR, which is reflected off vegetation.

# Now I look at the actual image: one of the easyest options is to use the "plot"  function

plot(l2011)     

# I assign colors other than the default ones.
# We go from a low reflectance (assigned to black) to higher ones (tending to white), specifyng the threshold for the breaks between different colours

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)  
plot(l2011, col=cl) 

# I can choose to plot a single band selecting it: there are different ways, here are two ways of selecting only the first band or layer (blue)

plot(l2011$B1_sre)

#or

plot(l2011[[1]])

# I switch colours and plot just the first band again

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)

plot(l2011[[1]], col=clb)

# Here is the export of the image both in pdf and png formats.
#Dev.off() is a very useful function that both closes all images open and, if specified, completes an export (such as in this case)

pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off()

png("banda1.png")
plot(l2011$B1_sre, col=clb)
dev.off()

# Let's visualize both the first and second bands together. I have to specify how many images i want to be shown in a matrix, using the "par" function

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)

par(mfrow=c(1,2)) # 1 row, 2 columns. Images will be shown paired horizontally
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

dev.off()

# I now export the multiframe plot

pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# We can use par to visualize all the first 4 bands at the same time

par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb)
# green
plot(l2011$B2_sre, col=clg)
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

dev.off()

# There is a function that plots images using the 3 primary colours (red, green and blue), with any band you decide.
# Here I assign the corresponding band to each colour to obtain an accurate representation of what the naked eye can see

plotRGB(l2011, r=3, g=2, b=1, stretch="lin")

# I can also assign bands not corresponding to the colour, and have different stretch. 
# This means that the reflectances get resampled automatically using the minimal value as 0 and max one as 100 to scale the colours in a linear way to enhance visualization,
# and i can decide it to instead have a different resampling to match a curve that enhances highs furthermore. (stretch = "hist") 
# Absolute values don't change, olnly the realtiveness to other reflectance values
# Here i assign the NIR band to the green graphical output to highlight vegetation, that greatly reflects NIR wavelenghts

plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# Quantity of bits in an image = radiometric resolution 
# Res = 2^n(bits)

par(mfrow=c(1,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin") naked eye representation
plotRGB(l2011, r=3, g=4, b=2, stretch="hist") 

# Importing the image from 1988

l1988 <- brick("p224r63_1988.grd")

# I can now easily visually compare images from two different dates to see how the urbanization impacted the lanscape (with a focus on plants abundance)

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
