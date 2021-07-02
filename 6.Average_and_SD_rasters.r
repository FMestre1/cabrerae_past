#Write average and SD rasters
#FMestre
#02-07-2021


################################################################
############################# LGM ##############################
################################################################

LGM <- stack(LGM_R_miroc, LGM_R_ccsm4, LGM_R_mpi)


mean_LGM <- calc(LGM, fun=mean)
sd_LGM <- calc(LGM, fun=sd)
writeRaster(x=mean_LGM, filename="mean_LGM", format="ascii")
writeRaster(x=sd_LGM, filename="sd_LGM", format="ascii")

################################################################
######################### MID HOLOCENE #########################
################################################################

MH <- stack(HOL_R_miroc, HOL_R_mpi, HOL_R_bcc, HOL_R_ccsm4, HOL_R_cnrm,
            HOL_R_hadgem2_cc, HOL_R_hadgem2_es, HOL_R_ipsl, HOL_R_mri)

mean_MH <- calc(MH, fun=mean)
sd_MH <- calc(MH, fun=sd)
writeRaster(x=mean_MH, filename="mean_MH", format="ascii")
writeRaster(x=sd_MH, filename="sd_MH", format="ascii")



#NOTE: To the Younger Dryas there is only on projection, no verage or SD are computed
YD3 <- raster("YD.tif")
