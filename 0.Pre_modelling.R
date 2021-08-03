#Variable selection
#FMestre
#02-07-2021

#Load study site shapefil
study_site <- raster::shapefile("D:/Doc/areaestudo.shp")
#study_site <- raster::shapefile("C:/github_projects/cabrerae_past/areaestudo.shp")
load("mc3.RData")


#Load rasters
b1 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_1.tif")
#b1 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_1.tif")
b1 <- crop(b1, study_site)
b1 <- mask(b1, study_site)
#plot(b1)
b2 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_2.tif")
#b2 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_2.tif")
b2 <- crop(b2, study_site)
b2 <- mask(b2, study_site)
#plot(b2)
b3 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_3.tif")
#b3 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_3.tif")
b3 <- crop(b3, study_site)
b3 <- mask(b3, study_site)
#plot(b3)
b4 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_4.tif")
#b4 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_4.tif")
b4 <- crop(b4, study_site)
b4 <- mask(b4, study_site)
#plot(b4)
b5 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_5.tif")
#b5 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_5.tif")
b5 <- crop(b5, study_site)
b5 <- mask(b5, study_site)
#plot(b5)
b6 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_6.tif")
#b6 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_6.tif")
b6 <- crop(b6, study_site)
b6 <- mask(b6, study_site)
#plot(b6)
b7 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_7.tif")
#b7 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_7.tif")
b7 <- crop(b7, study_site)
b7 <- mask(b7, study_site)
#plot(b7)
b8 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_8.tif")
#b8 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_8.tif")
b8 <- crop(b8, study_site)
b8 <- mask(b8, study_site)
#plot(b8)
b9 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_9.tif")
#b9 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_9.tif")
b9 <- crop(b9, study_site)
b9 <- mask(b9, study_site)
#plot(b9)
b10 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_10.tif")
#b10 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_10.tif")
b10 <- crop(b10, study_site)
b10 <- mask(b10, study_site)
#plot(b10)
b11 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_11.tif")
#b11 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_11.tif")
b11 <- crop(b11, study_site)
b11 <- mask(b11, study_site)
#plot(b11)
b12 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_12.tif")
#b12 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_12.tif")
b12 <- crop(b12, study_site)
b12 <- mask(b12, study_site)
#plot(b12)
b13 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_13.tif")
#b13 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_13.tif")
b13 <- crop(b13, study_site)
b13 <- mask(b13, study_site)
#plot(b13)
b14 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_14.tif")
#b14 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_14.tif")
b14 <- crop(b14, study_site)
b14 <- mask(b14, study_site)
#plot(b14)
b15 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_15.tif")
#b15 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_15.tif")
b15 <- crop(b15, study_site)
b15 <- mask(b15, study_site)
#plot(b15)
b16 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_16.tif")
#b16 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_16.tif")
b16 <- crop(b16, study_site)
b16 <- mask(b16, study_site)
#plot(b16)
b17 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_17.tif")
#b17 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_17.tif")
b17 <- crop(b17, study_site)
b17 <- mask(b17, study_site)
#plot(b17)
b18 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_18.tif")
#b18 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_18.tif")
b18 <- crop(b18, study_site)
b18 <- mask(b18, study_site)
#plot(b18)
b19 <- raster("D:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_19.tif")
#b19 <- raster("F:/Dados climáticos/WorldClim 2.0/wc2.1_30s_bio/wc2.1_30s_bio_19.tif")
b19 <- crop(b19, study_site)
b19 <- mask(b19, study_site)
#plot(b19)

#Create raster stack
vt <- stack(b1, b2, b3, b4, b5, b6, b7, b8, b9, b10,b11, b12, b13, b14, b15, b16, b17, b18, b19)
#plot(vt)

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

####
#Using fuzzySim
mc_poly <- raster::shapefile("D:/Doc/Especies/Mcabrerae_total/Mcabrerae_total_3.shp")
#mc_poly <- raster::shapefile("Mcabrerae_total_3.shp")

#plot(mc_poly)
mc_poly <- mc_poly@data
mc_poly <- mc_poly[mc_poly$Presenca==0,][,5:6]
mc_poly <- data.frame(mc_poly,0)
names(mc_poly)[3] <- "mc"
#
mc_pres <- data.frame(mc3@coords, mc3$mc)
names(mc_pres) <- names(mc_poly)
#
mc <- rbind(mc_poly,mc_pres)
#
#mc_05 <- rbind(mc[mc$mc==1,], dplyr::slice_sample(mc[mc$mc==0,],n = nrow(mc[mc$mc==1,])*2))
mc_05 <- rbind(mc[mc$mc==1,], dplyr::slice_sample(mc[mc$mc==0,],n = nrow(mc[mc$mc==1,])))

vars_predict_env <- raster::extract(vt, mc_05[,1:2])
vars_predict_env <- as.data.frame(vars_predict_env)
#head(vars_predict_env)
vars_predict_env <- data.frame(mc_05$mc, vars_predict_env)
names(vars_predict_env)[1] <- "mc"
#ncol(vars_predict_env)
select_vars <- fuzzySim::corSelect(vars_predict_env, sp.cols = 1, 
                                   var.cols = 2:20, cor.thresh = 0.7, method = "spearman",
                                   select = "p.value", use = "pairwise.complete.obs")

select_vars$selected.vars
#selected these variables "bio3"  "bio8"  "bio12" "bio18"