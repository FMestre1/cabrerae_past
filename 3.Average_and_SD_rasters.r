#Write average and SD rasters
#FMestre
#02-07-2021

setwd("D:/model_past4")

#Save current as ASC
writeRaster(x=CURRENT_MODEL, filename="CURRENT", format="ascii", overwrite=TRUE)

################################################################
############################# LGM ##############################
################################################################

LGM_R_miroc <- raster("LGM_MIROC.tif")
LGM_R_ccsm4 <- raster("LGM_CCSM4.tif")
LGM_R_mpi <- raster("LGM_MPI.tif")

LGM <- stack(LGM_R_miroc, LGM_R_ccsm4, LGM_R_mpi)

mean_LGM <- calc(LGM, fun=mean)
sd_LGM <- calc(LGM, fun=sd)
writeRaster(x=mean_LGM, filename="mean_LGM", format="ascii", overwrite=TRUE)
writeRaster(x=sd_LGM, filename="sd_LGM", format="ascii", overwrite=TRUE)
#plot(mean_LGM)


################################################################
######################## YOUNGER DRYAS #########################
################################################################

#NOTE: To the Younger Dryas there is only one projection, no average or SD are derived
YD3 <- raster("YD.tif")
#plot(YD3)

#Save 
writeRaster(x=YD3, filename="YD", format="ascii", overwrite=TRUE)


################################################################
######################### MID HOLOCENE #########################
################################################################

HOL_R_miroc <- raster("HOL_MIROC.tif")
HOL_R_mpi <- raster("HOL_MPI.tif")
HOL_R_bcc <- raster("HOL_BCC.tif")

HOL_R_ccsm4 <- raster("HOL_CCSM4.tif")
HOL_R_cnrm <- raster("HOL_CNRM.tif")
HOL_R_hadgem2_cc <- raster("HOL_HadGEM2_CC.tif")

HOL_R_hadgem2_es <- raster("HOL_HadGEM2_ES.tif")
HOL_R_ipsl <- raster("HOL_IPSL.tif")
HOL_R_mri <- raster("HOL_MRI.tif")

MH <- stack(HOL_R_miroc, HOL_R_mpi, HOL_R_bcc, HOL_R_ccsm4, HOL_R_cnrm,
            HOL_R_hadgem2_cc, HOL_R_hadgem2_es, HOL_R_ipsl, HOL_R_mri)

mean_MH <- calc(MH, fun=mean)
sd_MH <- calc(MH, fun=sd)
writeRaster(x=mean_MH, filename="mean_MH", format="ascii", overwrite=TRUE)
writeRaster(x=sd_MH, filename="sd_MH", format="ascii", overwrite=TRUE)
#plot(mean_MH)

################################################################
######################## PLOT TOGETHER #########################
################################################################

par(mfrow=c(2,2))
plot(mean_LGM, main = "LGM")
plot(YD3, main = "YD")
plot(mean_MH, main = "MH")
plot(CURRENT_MODEL, main = "Current")
#dev.off()

#Plot to pdf

pdf(file = "models.pdf",width = 4, height = 4)

par(mfrow=c(2,2))
plot(mean_LGM, main = "LGM")
plot(YD3, main = "YD")
plot(mean_MH, main = "MH")
plot(CURRENT_MODEL, main = "Current")

dev.off()

save.image()
