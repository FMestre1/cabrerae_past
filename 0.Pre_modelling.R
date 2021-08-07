#Variable selection
#FMestre
#02-07-2021

#Load species data
load("mc3.RData")

#Correlation analysis
vars_10x10_PT_SP_FR <- raster::shapefile("D:/Doc/mc_10x10_km_worldclim1.shp")
vars_10x10_PT_SP_FR <- vars_10x10_PT_SP_FR@data
vars_10x10_PT_SP_FR <- vars_10x10_PT_SP_FR[,-c(1:2)]
#View(vars_10x10_PT_SP_FR)

cor1 <- cor(vars_10x10_PT_SP_FR, use="complete.obs", method="spearman")
#View(cor1)

setwd("D:/model_past4/")

write.table(cor1, file = "correlations_10x10_km.csv")


#selected these variables bio4"  "bio8"  "bio12" "bio18"

#Create 10x10 km rasters
vars_10x10_PT_SP_FR <- raster::shapefile("D:/Doc/mc_10x10_km_worldclim1.shp")
b1 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_1.tif")
study_site <- raster::shapefile("D:/Doc/areaestudo.shp")
b1 <- crop(b1, study_site)
b1 <- mask(b1, study_site)
plot(b1)
save.image()
#
bio4_10 <- raster::rasterize(x=vars_10x10_PT_SP_FR, y=b1, field=vars_10x10_PT_SP_FR$bio4)
raster::writeRaster(bio4_10, filename = "D:/Doc/clima_10x10_km_W1/bio4.tif")
#
bio8_10 <- raster::rasterize(x=vars_10x10_PT_SP_FR, y=b1, field=vars_10x10_PT_SP_FR$bio8)
raster::writeRaster(bio8_10, filename = "D:/Doc/clima_10x10_km_W1/bio8.tif")
#
bio12_10 <- raster::rasterize(x=vars_10x10_PT_SP_FR, y=b1, field=vars_10x10_PT_SP_FR$bio12)
raster::writeRaster(bio12_10, filename = "D:/Doc/clima_10x10_km_W1/bio12.tif")
#
bio18_10 <- raster::rasterize(x=vars_10x10_PT_SP_FR, y=b1, field=vars_10x10_PT_SP_FR$bio18)
raster::writeRaster(bio18_10, filename = "D:/Doc/clima_10x10_km_W1/bio18.tif")
