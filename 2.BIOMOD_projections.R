#Projections of the ENM into the geographical space
#FMestre
#02-07-2021

#30/07/2021
#Remove FDA

#models1 <- mc_model@models.computed
#models1 <- models1[stringr::str_detect(models1, pattern="_FDA", negate = TRUE)]
#mc_model_ensemble <- mc_model_ensemble_test

##############################################################
########################## Current ###########################
##############################################################

#Projecting the model into current environmental conditions
mc_current <-BIOMOD_Projection(modeling.output=mc_model,
                               new.env=vars,
                               proj.name="mc_current",
                               selected.models = "all",
                               binary.meth = "TSS",
                               filtered.meth = "TSS",
                               compress = "gzip",
                               build.clamping.mask = FALSE)

mc_current_ES <- BIOMOD_EnsembleForecasting( projection.output=mc_current,
                                             EM.output=mc_model_ensemble,
                                             total.consensus = TRUE,
                                             binary.meth = "TSS",
                                             filtered.meth = "TSS")

##############################################################
######################## Mid-Holocene ########################
##############################################################

#Load current coastline (assuming roughly the same to the MH)
study_site <- raster::shapefile("D:/Doc/areaestudo.shp")

#BCC-CSM1-1########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_HolBCC <-BIOMOD_Projection(modeling.output=mc_model,
                              new.env= HOL_BCC_C,
                              proj.name="HOL_BCC",
                              selected.models = "all",
                              binary.meth = "TSS",
                              filtered.meth = "TSS",
                              compress = "gzip",
                              build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_Hol_BCC_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_HolBCC,
                                              EM.output=mc_model_ensemble,
                                              total.consensus = TRUE,
                                              binary.meth = "TSS",
                                              filtered.meth = "TSS")


#CCSM4 ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_HolCCSM4 <-BIOMOD_Projection(modeling.output=mc_model,
                                new.env= hol_CCSM4_C,
                                proj.name="HOL_CCSM4",
                                xy.new.env = NULL,
                                selected.models = "all",
                                binary.meth = "TSS",
                                filtered.meth = "TSS",
                                compress = TRUE,
                                build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_Hol_CCSM4_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_HolCCSM4,
                                                EM.output=mc_model_ensemble,
                                                total.consensus = TRUE,
                                                binary.meth = "TSS",
                                                filtered.meth = "TSS")


#CNRM-CM5 ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_HolCNRM <-BIOMOD_Projection(modeling.output=mc_model,
                               new.env= hol_CNRM_C,
                               proj.name="HOL_CNRM",
                               xy.new.env = NULL,
                               selected.models = "all",
                               binary.meth = "TSS",
                               filtered.meth = "TSS",
                               compress = TRUE,
                               build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_Hol_CNRM_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_HolCNRM,
                                               EM.output=mc_model_ensemble,
                                               total.consensus = TRUE,
                                               binary.meth = "TSS",
                                               filtered.meth = "TSS")

#HadGEM2 - CC ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_HolHadGEM2_CC <-BIOMOD_Projection(modeling.output=mc_model,
                                     new.env= hol__HadGEM2_CC_C,
                                     proj.name="HOL_HadGEM2_CC",
                                     xy.new.env = NULL,
                                     selected.models = "all",
                                     binary.meth = "TSS",
                                     filtered.meth = "TSS",
                                     compress = TRUE,
                                     build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_Hol_HadGEM2_CC_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_HolHadGEM2_CC,
                                                     EM.output=mc_model_ensemble,
                                                     total.consensus = TRUE,
                                                     binary.meth = "TSS",
                                                     filtered.meth = "TSS")

#HadGEM2 - ES ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_HolHadGEM2_ES <-BIOMOD_Projection(modeling.output=mc_model,
                                     new.env= hol__HadGEM2_ES_C,
                                     proj.name="HOL_HadGEM2_ES",
                                     xy.new.env = NULL,
                                     selected.models = "all",
                                     binary.meth = "TSS",
                                     filtered.meth = "TSS",
                                     compress = TRUE,
                                     build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_Hol_HadGEM2_ES_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_HolHadGEM2_ES,
                                                     EM.output=mc_model_ensemble,
                                                     total.consensus = TRUE,
                                                     binary.meth = "TSS",
                                                     filtered.meth = "TSS")

#IPSL ########################################################################

#Projections
#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_IPSL <-BIOMOD_Projection(modeling.output=mc_model,
                            new.env= hol_IPSL_C,
                            proj.name="HOL_IPSL",
                            xy.new.env = NULL,
                            selected.models = "all",
                            binary.meth = "TSS",
                            filtered.meth = "TSS",
                            compress = TRUE,
                            build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_Hol_IPSL_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_IPSL,
                                               EM.output=mc_model_ensemble,
                                               total.consensus = TRUE,
                                               binary.meth = "TSS",
                                               filtered.meth = "TSS")

#MIROC ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_MIROC <-BIOMOD_Projection(modeling.output=mc_model,
                             new.env= hol_MIROC_C,
                             proj.name="HOL_MIROC",
                             xy.new.env = NULL,
                             selected.models = "all",
                             binary.meth = "TSS",
                             filtered.meth = "TSS",
                             compress = TRUE,
                             build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_Hol_MIROC_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_MIROC,
                                                EM.output=mc_model_ensemble,
                                                total.consensus = TRUE,
                                                binary.meth = "TSS",
                                                filtered.meth = "TSS")

#MPI ########################################################################

#Projections
#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_MPI <-BIOMOD_Projection(modeling.output=mc_model,
                           new.env= hol_MPI_C,
                           proj.name="HOL_MPI",
                           xy.new.env = NULL,
                           selected.models = "all",
                           binary.meth = "TSS",
                           filtered.meth = "TSS",
                           compress = TRUE,
                           build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_Hol_MPI_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_MPI,
                                              EM.output=mc_model_ensemble,
                                              total.consensus = TRUE,
                                              binary.meth = "TSS",
                                              filtered.meth = "TSS")

#MRI ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_MRI <-BIOMOD_Projection(modeling.output=mc_model,
                           new.env= hol_MRI_C,
                           proj.name="HOL_MRI",
                           xy.new.env = NULL,
                           selected.models = "all",
                           binary.meth = "TSS",
                           filtered.meth = "TSS",
                           compress = TRUE,
                           build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_Hol_MRI_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_MRI,
                                              EM.output=mc_model_ensemble,
                                              total.consensus = TRUE,
                                              binary.meth = "TSS",
                                              filtered.meth = "TSS")


##############################################################
############################# YD #############################
##############################################################


mc_YD <-BIOMOD_Projection(modeling.output=mc_model,
                          new.env= yd_C,
                          proj.name="YD",
                          selected.models = "all",
                          binary.meth = "TSS",
                          filtered.meth = "TSS",
                          compress = "gzip",
                          build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_YD_Ens <- BIOMOD_EnsembleForecasting(projection.output=mc_YD,
                                        EM.output=mc_model_ensemble,
                                        total.consensus = TRUE,
                                        binary.meth = "TSS",
                                        filtered.meth = "TSS")



##############################################################
############################# LGM ############################
##############################################################


#CCSM4 ########################################################################

#Projections
#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_lgm_ccsm4 <-BIOMOD_Projection(modeling.output=mc_model,
                                 new.env= LGM_CCSM4_C,
                                 proj.name="LGM_CCSM4_test",
                                 xy.new.env = NULL,
                                 selected.models = "all",
                                 binary.meth = "TSS",
                                 filtered.meth = "TSS",
                                 compress = TRUE,
                                 build.clamping.mask = TRUE)

#Ensemble Forecasting
mc_LGM_CCSM4_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_lgm_ccsm4,
                                                EM.output=mc_model_ensemble,
                                                total.consensus = TRUE,
                                                binary.meth = "TSS",
                                                filtered.meth = "TSS")

#MIROC ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_lgm_miroc <-BIOMOD_Projection(modeling.output=mc_model,
                                 new.env= LGM_MIROC_C,
                                 proj.name="LGM_MIROC",
                                 xy.new.env = NULL,
                                 selected.models = "all",
                                 binary.meth = "TSS",
                                 filtered.meth = "TSS",
                                 compress = TRUE,
                                 build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_LGM_MIROC_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_lgm_miroc,
                                                EM.output=mc_model_ensemble,
                                                total.consensus = TRUE,
                                                binary.meth = "TSS",
                                                filtered.meth = "TSS")

#MPI ########################################################################

#Projections

#Temporary folder
#rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_lgm_mpi <-BIOMOD_Projection(modeling.output=mc_model,
                               new.env= LGM_MPI_C,
                               proj.name="LGM_MPI",
                               xy.new.env = NULL,
                               selected.models = "all",
                               binary.meth = "TSS",
                               filtered.meth = "TSS",
                               compress = TRUE,
                               build.clamping.mask = TRUE)


#Ensemble Forecasting
mc_LGM_MPI_Ens <- BIOMOD_EnsembleForecasting( projection.output=mc_lgm_mpi,
                                              EM.output=mc_model_ensemble,
                                              total.consensus = TRUE,
                                              binary.meth = "TSS",
                                              filtered.meth = "TSS")


##############################################################
####################### GETTING RASTERS ######################
##############################################################

#Current
CURRENT_MODEL <- unstack(mc_current_ES@proj@val)[[7]]
writeRaster(x=CURRENT_MODEL, filename="CURRENT_MODEL.tif", overwrite = TRUE)

#Mid-Holocene

HOL_MRI <- unstack(mc_Hol_MRI_Ens@proj@val)[[7]]
writeRaster(x=HOL_MRI, filename="HOL_MRI.tif", overwrite=TRUE)

HOL_MPI <- unstack(mc_Hol_MPI_Ens@proj@val)[[7]]
writeRaster(x=HOL_MPI, filename="HOL_MPI.tif", overwrite=TRUE)

HOL_MIROC <- unstack(mc_Hol_MIROC_Ens@proj@val)[[7]]
writeRaster(x=HOL_MIROC, filename="HOL_MIROC.tif", overwrite=TRUE)

HOL_IPSL <- unstack(mc_Hol_IPSL_Ens@proj@val)[[7]]
writeRaster(x=HOL_IPSL, filename="HOL_IPSL.tif", overwrite=TRUE)

HOL_HadGEM2_ES <- unstack(mc_Hol_HadGEM2_ES_Ens@proj@val)[[7]]
writeRaster(x=HOL_HadGEM2_ES, filename="HOL_HadGEM2_ES.tif", overwrite=TRUE)

HOL_HadGEM2_CC <- unstack(mc_Hol_HadGEM2_CC_Ens@proj@val)[[7]]
writeRaster(x=HOL_HadGEM2_CC, filename="HOL_HadGEM2_CC.tif", overwrite=TRUE)

HOL_CNRM <- unstack(mc_Hol_CNRM_Ens@proj@val)[[7]]
writeRaster(x=HOL_CNRM, filename="HOL_CNRM.tif", overwrite=TRUE)

HOL_CCSM4 <- unstack(mc_Hol_CCSM4_Ens@proj@val)[[7]]
writeRaster(x=HOL_CCSM4, filename="HOL_CCSM4.tif", overwrite=TRUE)

HOL_BCC <- unstack(mc_Hol_BCC_Ens@proj@val)[[7]]
writeRaster(x=HOL_BCC, filename="HOL_BCC.tif", overwrite=TRUE)

#Younger Dryas

YD2 <- unstack(mc_YD_Ens@proj@val)[[7]]
writeRaster(x=YD2, filename="YD.tif", overwrite=TRUE)

#Last Glacial Maximum

LGM_MPI <- unstack(mc_LGM_MPI_Ens@proj@val)[[7]]
writeRaster(x=LGM_MPI, filename="LGM_MPI.tif", overwrite=TRUE)

LGM_MIROC <- unstack(mc_LGM_MIROC_Ens@proj@val)[[7]]
writeRaster(x=LGM_MIROC, filename="LGM_MIROC.tif", overwrite=TRUE)

LGM_CCSM4 <- unstack(mc_LGM_CCSM4_Ens@proj@val)[[7]]
writeRaster(x=LGM_CCSM4, filename="LGM_CCSM4.tif", overwrite=TRUE)

