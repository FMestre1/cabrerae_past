#Comparing projections to each time period
#FMestre
#02-07-2021

################################################################
############################# LGM ##############################
################################################################

#Loading rasters
LGM_R_miroc <- raster("LGM_MIROC.tif")
LGM_R_ccsm4 <- raster("LGM_CCSM4.tif")
LGM_R_mpi <- raster("LGM_MPI.tif")

#Convert to matrix
lgm_miroc <- getValues(LGM_R_miroc)/1000
lgm_ccsm4 <- getValues(LGM_R_ccsm4)/1000
lgm_mpi <- getValues(LGM_R_mpi)/1000

#Compare
LGM_miroc_ccsm4 <- fuzzySim::modOverlap(lgm_miroc, lgm_ccsm4)
LGM_miroc_mpi <- fuzzySim::modOverlap(lgm_miroc, lgm_mpi)
LGM_ccsm4_mpi <- fuzzySim::modOverlap(lgm_ccsm4, lgm_mpi)

################################################################
######################### MID HOLOCENE #########################
################################################################

#Load rasters
HOL_R_miroc <- raster("HOL_MIROC.tif")
HOL_R_mpi <- raster("HOL_MPI.tif")
HOL_R_bcc <- raster("HOL_BCC.tif")

HOL_R_ccsm4 <- raster("HOL_CCSM4.tif")
HOL_R_cnrm <- raster("HOL_CNRM.tif")
HOL_R_hadgem2_cc <- raster("HOL_HadGEM2_CC.tif")

HOL_R_hadgem2_es <- raster("HOL_HadGEM2_ES.tif")
HOL_R_ipsl <- raster("HOL_IPSL.tif")
HOL_R_mri <- raster("HOL_MRI.tif")

#Convert to matrix
hol_miroc <- getValues(HOL_R_miroc)/1000
hol_mpi <- getValues(HOL_R_mpi)/1000
hol_bcc <- getValues(HOL_R_bcc)/1000

hol_ccsm4 <- getValues(HOL_R_ccsm4)/1000
hol_cnrm <- getValues(HOL_R_cnrm)/1000
hol_hadgem2_cc <- getValues(HOL_R_hadgem2_cc)/1000

hol_hadgem2_es <- getValues(HOL_R_hadgem2_es)/1000
hol_ipsl <- getValues(HOL_R_ipsl)/1000
hol_mri <- getValues(HOL_R_mri)/1000

#Compare
HOL_miroc_mpi <- fuzzySim::modOverlap(hol_miroc,hol_mpi)
HOL_miroc_bcc <- fuzzySim::modOverlap(hol_miroc,hol_bcc)
HOL_miroc_ccsm4 <- fuzzySim::modOverlap(hol_miroc,hol_ccsm4)
HOL_miroc_cnrm <- fuzzySim::modOverlap(hol_miroc,hol_cnrm)
HOL_miroc_hadgem2_cc <- fuzzySim::modOverlap(hol_miroc,hol_hadgem2_cc)
HOL_miroc_hadgem2_es <- fuzzySim::modOverlap(hol_miroc,hol_hadgem2_es)
HOL_miroc_ipsl <- fuzzySim::modOverlap(hol_miroc,hol_ipsl)
HOL_miroc_mri <- fuzzySim::modOverlap(hol_miroc,hol_mri)

HOL_mpi_bcc <- fuzzySim::modOverlap(hol_mpi,hol_bcc)
HOL_mpi_ccsm4 <- fuzzySim::modOverlap(hol_mpi,hol_ccsm4)
HOL_mpi_cnrm <- fuzzySim::modOverlap(hol_mpi,hol_cnrm)
HOL_mpi_hadgem2_cc <- fuzzySim::modOverlap(hol_mpi,hol_hadgem2_cc)
HOL_mpi_hadgem2_es <- fuzzySim::modOverlap(hol_mpi,hol_hadgem2_es)
HOL_mpi_ipsl <- fuzzySim::modOverlap(hol_mpi,hol_ipsl)
HOL_mpi_mri <- fuzzySim::modOverlap(hol_mpi,hol_mri)

HOL_bcc_ccsm4 <- fuzzySim::modOverlap(hol_bcc,hol_ccsm4)
HOL_bcc_cnrm <- fuzzySim::modOverlap(hol_bcc,hol_cnrm)
HOL_bcc_hadgem2_cc <- fuzzySim::modOverlap(hol_bcc,hol_hadgem2_cc)
HOL_bcc_hadgem2_es <- fuzzySim::modOverlap(hol_bcc,hol_hadgem2_es)
HOL_bcc_ipsl <- fuzzySim::modOverlap(hol_bcc,hol_ipsl)
HOL_bcc_mri <- fuzzySim::modOverlap(hol_bcc,hol_mri)

HOL_ccsm4_cnrm <- fuzzySim::modOverlap(hol_ccsm4,hol_cnrm)
HOL_ccsm4_hadgem2_cc <- fuzzySim::modOverlap(hol_ccsm4,hol_hadgem2_cc)
HOL_ccsm4_hadgem2_es <- fuzzySim::modOverlap(hol_ccsm4,hol_hadgem2_es)
HOL_ccsm4_ipsl <- fuzzySim::modOverlap(hol_ccsm4,hol_ipsl)
HOL_ccsm4_mri <- fuzzySim::modOverlap(hol_ccsm4,hol_mri)

HOL_cnrm_hadgem2_cc <- fuzzySim::modOverlap(hol_cnrm,hol_hadgem2_cc)
HOL_cnrm_hadgem2_es <- fuzzySim::modOverlap(hol_cnrm,hol_hadgem2_es)
HOL_cnrm_ipsl <- fuzzySim::modOverlap(hol_cnrm,hol_ipsl)
HOL_cnrm_mri <- fuzzySim::modOverlap(hol_cnrm,hol_mri)

HOL_hadgem2_cc_hadgem2_es <- fuzzySim::modOverlap(hol_hadgem2_cc,hol_hadgem2_es)
HOL_hadgem2_cc_ipsl <- fuzzySim::modOverlap(hol_hadgem2_cc,hol_ipsl)
HOL_hadgem2_cc_mri <- fuzzySim::modOverlap(hol_hadgem2_cc,hol_mri)

HOL_hadgem2_es_ipsl <- fuzzySim::modOverlap(hol_hadgem2_es,hol_ipsl)
HOL_hadgem2_es_mri <- fuzzySim::modOverlap(hol_hadgem2_es,hol_mri)

HOL_ipsl_mri <- fuzzySim::modOverlap(hol_ipsl,hol_mri)

#

save.image()

