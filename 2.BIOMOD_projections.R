#Projections of the ENM into the geographical space
#FMestre
#02-07-2021

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

#BCC-CSM1-1########################################################################
#ADD GRIDS
bio4_H_BCC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/BCC-CSM1-1/bcmidbi4.tif")
bio8_H_BCC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/BCC-CSM1-1/bcmidbi8.tif")
bio12_H_BCC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/BCC-CSM1-1/bcmidbi12.tif")
bio18_H_BCC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/BCC-CSM1-1/bcmidbi18.tif")
#Stack
HOL_BCC <- stack(bio4_H_BCC,bio8_H_BCC,bio12_H_BCC,bio18_H_BCC) 
HOL_BCC_C <- crop(HOL_BCC, study_site)
HOL_BCC_C <- mask(HOL_BCC_C, study_site)
HOL_BCC_C <- stack(HOL_BCC_C)
names(HOL_BCC_C) <- c("bio4", "bio8", "bio12", "bio18")

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CCSM4/ccmidbi4.tif")
bio8_H_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CCSM4/ccmidbi8.tif")
bio12_H_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CCSM4/ccmidbi12.tif")
bio18_H_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CCSM4/ccmidbi18.tif")

#Stack
hol_CCSM4 <- stack(bio4_H_CCSM4,bio8_H_CCSM4,bio12_H_CCSM4,bio18_H_CCSM4) 
hol_CCSM4_C <- crop(hol_CCSM4, study_site)
hol_CCSM4_C <- mask(hol_CCSM4_C, study_site)
hol_CCSM4_C <- stack(hol_CCSM4_C)
names(hol_CCSM4_C)<- c("bio4","bio8","bio12","bio18")
plot(hol_CCSM4_C)

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_CNRM <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CNRM-CM5/cnmidbi4.tif")
bio8_H_CNRM <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CNRM-CM5/cnmidbi8.tif")
bio12_H_CNRM <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CNRM-CM5/cnmidbi12.tif")
bio18_H_CNRM <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/CNRM-CM5/cnmidbi18.tif")
#Stack
hol_CNRM <- stack(bio4_H_CNRM,bio8_H_CNRM,bio12_H_CNRM,bio18_H_CNRM) 
hol_CNRM_C <- crop(hol_CNRM, study_site)
hol_CNRM_C <- mask(hol_CNRM_C, study_site)
hol_CNRM_C <- stack(hol_CNRM_C)
names(hol_CNRM_C)<- c("bio4","bio8","bio12","bio18")
plot(hol_CNRM_C)


#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_HadGEM2_CC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-CC/hgmidbi4.tif")
bio8_H_HadGEM2_CC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-CC/hgmidbi8.tif")
bio12_H_HadGEM2_CC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-CC/hgmidbi12.tif")
bio18_H_HadGEM2_CC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-CC/hgmidbi18.tif")
#Stack
hol__HadGEM2_CC <- stack(bio4_H_HadGEM2_CC,bio8_H_HadGEM2_CC,bio12_H_HadGEM2_CC,bio18_H_HadGEM2_CC) 
hol__HadGEM2_CC_C <- crop(hol__HadGEM2_CC, study_site)
hol__HadGEM2_CC_C <- mask(hol__HadGEM2_CC_C, study_site)
hol__HadGEM2_CC_C <- stack(hol__HadGEM2_CC_C)
names(hol__HadGEM2_CC_C)<- c("bio4","bio8","bio12","bio18")
plot(hol__HadGEM2_CC_C)

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_HadGEM2_ES <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-ES/hemidbi4.tif")
bio8_H_HadGEM2_ES <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-ES/hemidbi8.tif")
bio12_H_HadGEM2_ES <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-ES/hemidbi12.tif")
bio18_H_HadGEM2_ES <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/HadGEM2-ES/hemidbi18.tif")

#Stack
hol__HadGEM2_ES <- stack(bio4_H_HadGEM2_ES,bio8_H_HadGEM2_ES,bio12_H_HadGEM2_ES,bio18_H_HadGEM2_ES) 
hol__HadGEM2_ES_C <- crop(hol__HadGEM2_ES, study_site)
hol__HadGEM2_ES_C <- mask(hol__HadGEM2_ES_C, study_site)
hol__HadGEM2_ES_C <- stack(hol__HadGEM2_ES_C)
names(hol__HadGEM2_ES_C)<- c("bio4","bio8","bio12","bio18")
plot(hol__HadGEM2_ES_C)

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_IPSL <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/IPSL-CM5A-LR/ipmidbi4.tif")
bio8_H_IPSL <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/IPSL-CM5A-LR/ipmidbi8.tif")
bio12_H_IPSL <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/IPSL-CM5A-LR/ipmidbi12.tif")
bio18_H_IPSL <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/IPSL-CM5A-LR/ipmidbi18.tif")
#Stack
hol_IPSL <- stack(bio4_H_IPSL,bio8_H_IPSL,bio12_H_IPSL,bio18_H_IPSL) 
hol_IPSL_C <- crop(hol_IPSL, study_site)
hol_IPSL_C <- mask(hol_IPSL_C, study_site)
hol_IPSL_C <- stack(hol_IPSL_C)
names(hol_IPSL_C)<- c("bio4","bio8","bio12","bio18")
plot(hol_IPSL_C)

#Projections
#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_MIROC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MIROC_ESM/mrmidbi4.tif")
bio8_H_MIROC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MIROC_ESM/mrmidbi8.tif")
bio12_H_MIROC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MIROC_ESM/mrmidbi12.tif")
bio18_H_MIROC <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MIROC_ESM/mrmidbi18.tif")
#Stack
hol_MIROC <- stack(bio4_H_MIROC,bio8_H_MIROC,bio12_H_MIROC,bio18_H_MIROC) 
hol_MIROC_C <- crop(hol_MIROC, study_site)
hol_MIROC_C <- mask(hol_MIROC_C, study_site)
hol_MIROC_C <- stack(hol_MIROC_C)
names(hol_MIROC_C)<- c("bio4","bio8","bio12","bio18")
plot(hol_MIROC_C)

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_MPI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MPI-ESM-P/memidbi4.tif")
bio8_H_MPI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MPI-ESM-P/memidbi8.tif")
bio12_H_MPI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MPI-ESM-P/memidbi12.tif")
bio18_H_MPI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MPI-ESM-P/memidbi18.tif")
#Stack
hol_MPI <- stack(bio4_H_MPI,bio8_H_MPI,bio12_H_MPI,bio18_H_MPI) 
hol_MPI_C <- crop(hol_MPI, study_site)
hol_MPI_C <- mask(hol_MPI_C, study_site)
hol_MPI_C <- stack(hol_MPI_C)
names(hol_MPI_C)<- c("bio4","bio8","bio12","bio18")
plot(hol_MPI_C)


#Projections
#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_H_MRI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MRI-CGCM3/mgmidbi4.tif")
bio8_H_MRI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MRI-CGCM3/mgmidbi8.tif")
bio12_H_MRI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MRI-CGCM3/mgmidbi12.tif")
bio18_H_MRI <- raster("D:/Dados climáticos/Dados do passado/Holoceno-Mais_recente/MRI-CGCM3/mgmidbi18.tif")
#Stack
hol_MRI <- stack(bio4_H_MRI,bio8_H_MRI,bio12_H_MRI,bio18_H_MRI) 
hol_MRI_C <- crop(hol_MRI, study_site)
hol_MRI_C <- mask(hol_MRI_C, study_site)
hol_MRI_C <- stack(hol_MRI_C)
names(hol_MRI_C)<- c("bio4","bio8","bio12","bio18")
plot(hol_MRI_C)


#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

YD_coastline <- shapefile("C:/Doc/costa_YD.shp")

#Load rasters
bio4_YD <- raster("D:/Dados climáticos/Dados do passado/PaleoClim/2.5m/YDS_v1_2_5m/bio_4.tif")
bio8_YD <- raster("D:/Dados climáticos/Dados do passado/PaleoClim/2.5m/YDS_v1_2_5m/bio_8.tif")
bio12_YD <- raster("D:/Dados climáticos/Dados do passado/PaleoClim/2.5m/YDS_v1_2_5m/bio_12.tif")
bio18_YD <- raster("D:/Dados climáticos/Dados do passado/PaleoClim/2.5m/YDS_v1_2_5m/bio_18.tif")
#

#Stack
YD <- stack(bio4_YD,bio8_YD,bio12_YD,bio18_YD)
yd_C <- crop(YD, YD_coastline)
yd_C <- mask(yd_C, YD_coastline)
yd_C <- stack(yd_C)
names(yd_C)<- c("bio4","bio8","bio12","bio18")
plot(yd_C)


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

LGM_study_site <- shapefile("C:/Users/Frederico/Documents/0. Artigos/4. SUBMETIDOS/Cabrerae Paleodistribution/Rascunhos/Outros/Outros-Dropbox/gis/LGM_PI_FR.shp")
plot(LGM_study_site)

#CCSM4 ########################################################################

#ADD GRIDS
bio4_LGM_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/CCSM4/cclgmbi4.tif")
bio8_LGM_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/CCSM4/cclgmbi8.tif")
bio12_LGM_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/CCSM4/cclgmbi12.tif")
bio18_LGM_CCSM4 <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/CCSM4/cclgmbi18.tif")
#Stack
LGM_CCSM4 <- stack(bio4_LGM_CCSM4,bio8_LGM_CCSM4,bio12_LGM_CCSM4,bio18_LGM_CCSM4) 
LGM_CCSM4_C <- crop(LGM_CCSM4, LGM_study_site)
LGM_CCSM4_C <- mask(LGM_CCSM4_C, LGM_study_site)
LGM_CCSM4_C <- stack(LGM_CCSM4_C)
names(LGM_CCSM4_C)<- c("bio4","bio8","bio12","bio18")
plot(LGM_CCSM4_C)

#Projections
#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

mc_lgm_ccsm4 <-BIOMOD_Projection(modeling.output=mc_model,
                                 new.env= LGM_CCSM4_C,
                                 proj.name="LGM_CCSM4",
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

#ADD GRIDS# 
bio4_LGM_MIROC <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MIROC-ESM/mrlgmbi4.tif")
bio8_LGM_MIROC <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MIROC-ESM/mrlgmbi8.tif")
bio12_LGM_MIROC <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MIROC-ESM/mrlgmbi12.tif")
bio18_LGM_MIROC <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MIROC-ESM/mrlgmbi18.tif")
#Stack
LGM_MIROC <- stack(bio4_LGM_MIROC,bio8_LGM_MIROC,bio12_LGM_MIROC,bio18_LGM_MIROC) 
LGM_MIROC_C <- crop(LGM_MIROC, LGM_study_site)
LGM_MIROC_C <- mask(LGM_MIROC_C, LGM_study_site)
LGM_MIROC_C <- stack(LGM_MIROC_C)
names(LGM_MIROC_C)<- c("bio4","bio8","bio12","bio18")
plot(LGM_MIROC_C)

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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

#ADD GRIDS
bio4_LGM_MPI <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MPI-ESM-P/melgmbi4.tif")
bio8_LGM_MPI <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MPI-ESM-P/melgmbi8.tif")
bio12_LGM_MPI <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MPI-ESM-P/melgmbi12.tif")
bio18_LGM_MPI <- raster("D:/Dados climáticos/Dados do passado/LGM-Mais_recentes/MPI-ESM-P/melgmbi18.tif")
#Stack
LGM_MPI <- stack(bio4_LGM_MPI,bio8_LGM_MPI,bio12_LGM_MPI,bio18_LGM_MPI) 
LGM_MPI_C <- crop(LGM_MPI, LGM_study_site)
LGM_MPI_C <- mask(LGM_MPI_C, LGM_study_site)
LGM_MPI_C <- stack(LGM_MPI_C)
names(LGM_MPI_C)<- c("bio4","bio8","bio12","bio18")
plot(LGM_MPI_C)

#Projections

#Temporary folder
rasterOptions(tmpdir="/mnt/3CA48C17071C8B48/fred/r_temp")

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
writeRaster(x=CURRENT_MODEL, filename="CURRENT_MODEL.tif")

#Mid-Holocene

HOL_MRI <- unstack(mc_Hol_MRI_Ens@proj@val)[[7]]
writeRaster(x=HOL_MRI, filename="HOL_MRI.tif")

HOL_MPI <- unstack(mc_Hol_MPI_Ens@proj@val)[[7]]
writeRaster(x=HOL_MPI, filename="HOL_MPI.tif")

HOL_MIROC <- unstack(mc_Hol_MIROC_Ens@proj@val)[[7]]
writeRaster(x=HOL_MIROC, filename="HOL_MIROC.tif")

HOL_IPSL <- unstack(mc_Hol_IPSL_Ens@proj@val)[[7]]
writeRaster(x=HOL_IPSL, filename="HOL_IPSL.tif")

HOL_HadGEM2_ES <- unstack(mc_Hol_HadGEM2_ES_Ens@proj@val)[[7]]
writeRaster(x=HOL_HadGEM2_ES, filename="HOL_HadGEM2_ES.tif")

HOL_HadGEM2_CC <- unstack(mc_Hol_HadGEM2_CC_Ens@proj@val)[[7]]
writeRaster(x=HOL_HadGEM2_CC, filename="HOL_HadGEM2_CC.tif")

HOL_CNRM <- unstack(mc_Hol_CNRM_Ens@proj@val)[[7]]
writeRaster(x=HOL_CNRM, filename="HOL_CNRM.tif")

HOL_CCSM4 <- unstack(mc_Hol_CCSM4_Ens@proj@val)[[7]]
writeRaster(x=HOL_CCSM4, filename="HOL_CCSM4.tif")

HOL_BCC <- unstack(mc_Hol_BCC_Ens@proj@val)[[7]]
writeRaster(x=HOL_BCC, filename="HOL_BCC.tif")

#Younger Dryas

YD2 <- unstack(mc_YD_Ens@proj@val)[[7]]
writeRaster(x=YD2, filename="YD.tif")

#Last Glacial Maximum

LGM_MPI <- unstack(mc_LGM_MPI_Ens@proj@val)[[7]]
writeRaster(x=LGM_MPI, filename="LGM_MPI.tif")

LGM_MIROC <- unstack(mc_LGM_MIROC_Ens@proj@val)[[7]]
writeRaster(x=LGM_MIROC, filename="LGM_MIROC.tif")

LGM_CCSM4 <- unstack(mc_LGM_CCSM4_Ens@proj@val)[[7]]
writeRaster(x=LGM_CCSM4, filename="LGM_CCSM4.tif")
