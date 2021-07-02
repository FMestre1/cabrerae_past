#Variable selection
#FMestre
#02-07-2021

#Spearman correlation between variables
b1 <- raster("D:/Doc/rasters_PIB_FR/bio1.tif")
b2 <- raster("D:/Doc/rasters_PIB_FR/bio2.tif")
b3 <- raster("D:/Doc/rasters_PIB_FR/bio3.tif")
b4 <- raster("D:/Doc/rasters_PIB_FR/bio4.tif")
b5 <- raster("D:/Doc/rasters_PIB_FR/bio5.tif")
b6 <- raster("D:/Doc/rasters_PIB_FR/bio6.tif")
b7 <- raster("D:/Doc/rasters_PIB_FR/bio7.tif")
b8 <- raster("D:/Doc/rasters_PIB_FR/bio8.tif")
b9 <- raster("D:/Doc/rasters_PIB_FR/bio9.tif")
b10 <- raster("D:/Doc/rasters_PIB_FR/bio10.tif")
b11 <- raster("D:/Doc/rasters_PIB_FR/bio11.tif")
b12 <- raster("D:/Doc/rasters_PIB_FR/bio12.tif")
b13 <- raster("D:/Doc/rasters_PIB_FR/bio13.tif")
b14 <- raster("D:/Doc/rasters_PIB_FR/bio14.tif")
b15 <- raster("D:/Doc/rasters_PIB_FR/bio15.tif")
b16 <- raster("D:/Doc/rasters_PIB_FR/bio16.tif")
b17 <- raster("D:/Doc/rasters_PIB_FR/bio17.tif")
b18 <- raster("D:/Doc/rasters_PIB_FR/bio18.tif")
b19 <- raster("D:/Doc/rasters_PIB_FR/bio19.tif")

#Create raster stack
vt <- stack(b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, 
            b11, b12, b13, b14, b15, b16, b17, b18, b19)

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
  
  r1 <- cor1[i,]
  
  for (j in 1:19){
    
    a <- name_V[i]
    b <- name_V[j]
    
    a1 <- subset(vt,a) 
    b1 <- subset(vt,b) 
    
    coef1 <- cor(as.vector(a1),as.vector(b1),method="spearman",use="complete.obs")
    
    cor1[a,b] <- coef1
  }
  
}

write.table(cor1, file = "correlations.csv")



