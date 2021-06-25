#Past distribution of M. cabrerae
#FMestre
#26-06-2021

#Load packages
library(biomod2)
library(maptools)
library(raster)
library(plyr)
library(fuzzySim)

save.image(file='cabrerae_past.RData')

#projecting to the Younger Dryas

bio4_YD <- raster("xxx.tif")
bio8_YD <- raster("xxx.tif")
bio12_YD <- raster("xxx.tif")
bio18_YD <- raster("xxx.tif")
#Stack
YD <- stack(bio4_YD,bio8_YD,bio12_YD,bio18_YD)



mc_YD <-BIOMOD_Projection(modeling.output=mc_model,
                              new.env= YD,
                              proj.name="YD",
                              selected.models = "all",
                              binary.meth = "TSS",
                              filtered.meth = "TSS",
                              compress = "gzip",
                              build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_YD_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_YD,
                                              EM.output=mc_model_ensemble,
                                              total.consensus = TRUE,
                                              binary.meth = "TSS",
                                              filtered.meth = "TSS")


##Extract output rasters
YD2 <- unstack(mc_YD_Ens@proj@val)[[7]]
writeRaster(x=YD2, filename="YD.tif")




