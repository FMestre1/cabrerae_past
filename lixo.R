
###########################################################################################################
#Testing with Worldclim v1

bio1 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_1/w001001.adf")
bio2 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_2/w001001.adf")
bio3 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_3/w001001.adf")
bio4 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_4/w001001.adf")
bio5 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_5/w001001.adf")
bio6 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_6/w001001.adf")
bio7 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_7/w001001.adf")
bio8 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_8/w001001.adf")
bio9 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_9/w001001.adf")
bio10 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_10/w001001.adf")
bio11 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_11/w001001.adf")
bio12 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_12/w001001.adf")
bio13 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_13/w001001.adf")
bio14 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_14/w001001.adf")
bio15 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_15/w001001.adf")
bio16 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_16/w001001.adf")
bio17 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_17/w001001.adf")
bio18 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_18/w001001.adf")
bio19 <- raster("D:/Dados climáticos/Worldclim/Actuais/bio_30s_esri/bio/bio_19/w001001.adf")

bio1 <- crop(bio1, study_site)
bio2 <- crop(bio2, study_site)
bio3 <- crop(bio3, study_site)
bio4 <- crop(bio4, study_site)
bio5 <- crop(bio5, study_site)
bio6 <- crop(bio6, study_site)
bio7 <- crop(bio7, study_site)
bio8 <- crop(bio8, study_site)
bio9 <- crop(bio9, study_site)
bio10 <- crop(bio10, study_site)
bio11 <- crop(bio11, study_site)
bio12 <- crop(bio12, study_site)
bio13 <- crop(bio13, study_site)
bio14 <- crop(bio14, study_site)
bio15 <- crop(bio15, study_site)
bio16 <- crop(bio16, study_site)
bio17 <- crop(bio17, study_site)
bio18 <- crop(bio18, study_site)
bio19 <- crop(bio19, study_site)

bio1 <- mask(bio1, study_site)
bio2 <- mask(bio2, study_site)
bio3 <- mask(bio3, study_site)
bio4 <- mask(bio4, study_site)
bio5 <- mask(bio5, study_site)
bio6 <- mask(bio6, study_site)
bio7 <- mask(bio7, study_site)
bio8 <- mask(bio8, study_site)
bio9 <- mask(bio9, study_site)
bio10 <- mask(bio10, study_site)
bio11 <- mask(bio11, study_site)
bio12 <- mask(bio12, study_site)
bio13 <- mask(bio13, study_site)
bio14 <- mask(bio14, study_site)
bio15 <- mask(bio15, study_site)
bio16 <- mask(bio16, study_site)
bio17 <- mask(bio17, study_site)
bio18 <- mask(bio18, study_site)
bio19 <- mask(bio19, study_site)

vt <- stack(bio1, bio2, bio3, bio4, bio5, bio6, bio7, bio8, bio9, 
            bio10, bio11, bio12, bio13, bio14, bio15, bio16, bio17, bio18, bio19)
#plot(vt)

names(vt) <- c("bio1", "bio2", "bio3", "bio4", "bio5", "bio6", 
               "bio7", "bio8", "bio9", "bio10", "bio11", "bio12", "bio13", "bio14", 
               "bio15", "bio16", "bio17", "bio18", "bio19")

#Test using fuzzySim
mc_05 <- rbind(mc[mc$revisao_pr==1,], dplyr::sample_n(mc[mc$revisao_pr==0,],nrow(mc[mc$revisao_pr==1,])*2))

vars_predict_env <- raster::extract(vt, mc_05[,2:3])
vars_predict_env <- as.data.frame(vars_predict_env)
#head(vars_predict_env)
vars_predict_env <- data.frame(mc_05$revisao_pr, vars_predict_env)
names(vars_predict_env)[1] <- "mc"

select_vars <- fuzzySim::corSelect(vars_predict_env, sp.cols = 1, 
                                   var.cols = 2:20, cor.thresh = 0.7,
                                   select = "p.value", use = "pairwise.complete.obs")
select_vars$selected.vars
