#Variable selection
#FMestre
#02-07-2021

#Load study site shapefil
study_site <- raster::shapefile("C:/Doc/areaestudo.shp")

#Load rasters
b1 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_01.tif")
b1 <- crop(b1, study_site)
b1 <- mask(b1, study_site)
#plot(b1)
b2 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_02.tif")
b2 <- crop(b2, study_site)
b2 <- mask(b2, study_site)
#plot(b2)
b3 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_03.tif")
b3 <- crop(b3, study_site)
b3 <- mask(b3, study_site)
#plot(b3)
b4 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_04.tif")
b4 <- crop(b4, study_site)
b4 <- mask(b4, study_site)
#plot(b4)
b5 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_05.tif")
b5 <- crop(b5, study_site)
b5 <- mask(b5, study_site)
#plot(b4)
b6 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_06.tif")
b6 <- crop(b6, study_site)
b6 <- mask(b6, study_site)
#plot(b4)
b7 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_07.tif")
b7 <- crop(b7, study_site)
b7 <- mask(b7, study_site)
#plot(b4)
b8 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_08.tif")
b8 <- crop(b8, study_site)
b8 <- mask(b8, study_site)
#plot(b4)
b9 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_09.tif")
b9 <- crop(b9, study_site)
b9 <- mask(b9, study_site)
#plot(b4)
b10 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_10.tif")
b10 <- crop(b10, study_site)
b10 <- mask(b10, study_site)
#plot(b4)
b11 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_11.tif")
b11 <- crop(b11, study_site)
b11 <- mask(b11, study_site)
#plot(b4)
b12 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_12.tif")
b12 <- crop(b12, study_site)
b12 <- mask(b12, study_site)
#plot(b4)
b13 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_13.tif")
b13 <- crop(b13, study_site)
b13 <- mask(b13, study_site)
#plot(b4)
b14 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_14.tif")
b14 <- crop(b14, study_site)
b14 <- mask(b14, study_site)
#plot(b4)
b15 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_15.tif")
b15 <- crop(b15, study_site)
b15 <- mask(b15, study_site)
#plot(b4)
b16 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_16.tif")
b16 <- crop(b16, study_site)
b16 <- mask(b16, study_site)
#plot(b4)
b17 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_17.tif")
b17 <- crop(b17, study_site)
b17 <- mask(b17, study_site)
#plot(b4)
b18 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_18.tif")
b18 <- crop(b18, study_site)
b18 <- mask(b18, study_site)
#plot(b4)
b19 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.0_bio_10m_19.tif")
b19 <- crop(b19, study_site)
b19 <- mask(b19, study_site)
#plot(b4)

#Create raster stack
vt <- stack(b1, b2, b3, b4, b5, b6, b7, b8, b9, b10,b11, b12, b13, b14, b15, b16, b17, b18, b19)

names(vt) <- c("bio1", "bio2", "bio3", "bio4", "bio5", "bio6", 
            "bio7", "bio8", "bio9", "bio10", "bio11", "bio12", "bio13", "bio14", 
            "bio15", "bio16", "bio17", "bio18", "bio19")

cor1 <- as.data.frame(matrix(ncol=19,nrow=19))

colnames(cor1) <- c("bio1", "bio2", "bio3", "bio4", "bio5", "bio6", 
                    "bio7", "bio8", "bio9", "bio10", "bio11", "bio12", "bio13", "bio14", 
                    "bio15", "bio16", "bio17", "bio18", "bio19")

rownames (cor1) <- c("bio1", "bio2", "bio3", "bio4", "bio5", "bio6", 
                     "bio7", "bio8", "bio9", "bio10", "bio11", "bio12", "bio13", "bio14", 
                     "bio15", "bio16", "bio17", "bio18", "bio19")

name_V <- c("bio1", "bio2", "bio3", "bio4", "bio5", "bio6", 
            "bio7", "bio8", "bio9", "bio10", "bio11", "bio12", "bio13", "bio14", 
            "bio15", "bio16", "bio17", "bio18", "bio19")

for(i in 1:19){
  
  for (j in 1:19){
    
    a <- name_V[i]
    b <- name_V[j]
    
    a1 <- subset(vt,a) 
    b1 <- subset(vt,b) 
    
    cor1[a,b] <- ENMTools::raster.cor(a1, b1, method = "spearman")
  }
  
}
View(cor1)

write.table(cor1, file = "correlations.csv")











