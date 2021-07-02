###################################################
#                                                 #
#            SUPP. INFO. - R SCRIPT               #
# Integrating fossil, niche modelling and genetic #
#   information to infer past refugia and range   #
#      shifts in an Iberian endemic vole          #
#                                                 #
#                                                 #
#            Mestre, F.; Barbosa, S.;             #
#     Garrido-García, J.A.; Pita, R.; Mira, A.;   #
#     Alves, P.C.; Paupério, J.; Searle, J.B.;    #
#                    Beja, P.                     #
#                                                 #
###################################################

#by F. Mestre

#Set working directory
setwd("D:/")


#Create temporary folder for intermediate results
rasterOptions(tmpdir="D:/biomod_temp")

#Load packages
library(biomod2)
library(maptools)
library(raster)
library(plyr)
library(fuzzySim)

#Install development version of biomod2
devtools::install_github('biomodhub/biomod2', dependencies = TRUE)

#Package citation
citation(package = "biomod2", lib.loc = NULL, auto = NULL)
citation("raster")
citation("maptools")
citation("fuzzySim")
citation("plyr")

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

#Load species occurrence data
mc <- readShapePoly("~/Mcabrerae.shp")
mc<-mc@data
mc<-mc[,c(5,6,9)]
mc <- mc[mc[,3]==1,1:2]
mc <- SpatialPoints(mc)

#NOT THIS SHAPE
#mc_R <- rgdal::readOGR("F:/Dados biológicos/Mcabrerae_total/Mcabrerae_total_3.shp")
#mc_R <- mc_R[mc_R$Presenca == 1,]
#mc_R <- rgeos::gCentroid(mc_R,byid=TRUE)
#plot(mc_R)


#Loading variables
bio4 <- raster("current/bio4.tif")
bio8 <- raster("current/bio8.tif")
bio12 <- raster("current/bio12.tif")
bio18 <- raster("current/bio18.tif")
vars <- stack(bio4, bio8, bio12, bio18)
plot(vars)

#Format data for biomod2
data_biomod <- BIOMOD_FormatingData(resp.var = mc,
                                    expl.var = vars,
                                    resp.name = "mc3",
                                    PA.nb.rep = 5,
                                    PA.nb.absences = 469*2,
                                    PA.strategy = "random",
                                    PA.dist.min = 0,
                                    PA.dist.max = NULL,
                                    PA.sre.quant = NULL,
                                    PA.table = NULL,
                                    na.rm = TRUE)


#Modelling
model_opt <- BIOMOD_ModelingOptions(
  GLM = list( type = 'polynomial',#Modifiquei
              interaction.level = 0,
              myFormula = NULL,
              test = 'AIC',
              family = binomial(link = 'logit'),
              mustart = 0.5,
              control = glm.control(epsilon = 1e-08, maxit = 50
                                    , trace = FALSE) ),
  
  GBM = list( distribution = 'bernoulli',
              n.trees = 4000,#Modifiquei
              interaction.depth = 7,
              n.minobsinnode = 5,
              shrinkage = 0.001,
              bag.fraction = 0.5,
              train.fraction = 1,
              cv.folds = 3,
              keep.data = FALSE,
              verbose = FALSE,
              perf.method = 'cv'),
  
  GAM = list( algo = 'GAM_mgcv',
              type = 's_smoother',
              k = -1,
              interaction.level = 0,
              myFormula = NULL,
              family = binomial(link = 'logit'),
              method = 'GCV.Cp',
              optimizer = c('outer','newton'),
              select = FALSE,
              knots = NULL,
              paraPen = NULL,
              control = list(nthreads = 1, irls.reg = 0, epsilon = 1e-07
                             , maxit = 200, trace = FALSE, mgcv.tol = 1e-07, mgcv.half = 15
                             , rank.tol = 1.49011611938477e-08
                             , nlm = list(ndigit=7, gradtol=1e-06, stepmax=2, steptol=1e-04, iterlim=200, check.analyticals=0)
                             , optim = list(factr=1e+07)
                             , newton = list(conv.tol=1e-06, maxNstep=5, maxSstep=2, maxHalf=30, use.svd=0)
                             , outerPIsteps = 0, idLinksBases = TRUE, scalePenalty = TRUE
                             , keepData = FALSE) ),
  
  CTA = list( method = 'class',
              parms = 'default',
              cost = NULL,
              control = list(xval = 5, minbucket = 5, minsplit = 5
                             , cp = 0.001, maxdepth = 25) ),
  
  ANN = list( NbCV = 5,
              rang = 0.1,
              maxit = 200),
  
  FDA = list( method = 'mars'),
  
  MARS = list( degree = 2,
               penalty = 2,
               thresh = 0.001,
               prune = TRUE),
  
  RF = list( do.classif = TRUE,
             ntree = 500,
             mtry = 'default',
             nodesize = 5,
             maxnodes = NULL)
)

mc_model <- BIOMOD_Modeling( data_biomod,
                             models = c("GLM","GBM","GAM","CTA","ANN","FDA","MARS","RF"),
                             models.options = model_opt,
                             NbRunEval=5,
                             DataSplit=70,
                             Yweights=NULL,
                             Prevalence=NULL,
                             VarImport=5,
                             models.eval.meth = "TSS",
                             SaveObj = TRUE,
                             rescal.all.models = TRUE,
                             do.full.models = TRUE)


#Modeling summary
mc_model

#Model evaluations
model_eval <- get_evaluations(mc_model)

#Relative importance of explanatory variables
var_import <- get_variables_importance(mc_model)

#Ensemble Modelling
mc_model_ensemble <- BIOMOD_EnsembleModeling( modeling.output=mc_model,
                                              chosen.models = "all",
                                              em.by = "all",
                                              eval.metric = "TSS",
                                              eval.metric.quality.threshold = 0.5,
                                              prob.mean = TRUE,
                                              prob.cv = TRUE,
                                              prob.ci = TRUE,
                                              prob.ci.alpha = 0.05,
                                              prob.median = TRUE,
                                              committee.averaging = TRUE,
                                              prob.mean.weight = TRUE,
                                              prob.mean.weight.decay = "proportional",
                                              VarImport=5)


#Ensemble Summary 
mc_model_ensemble

#Evaluation Scores
getEMeval(mc_model_ensemble)


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

############################

##Extract output rasters
LGM_MPI <- unstack(mc_LGM_MPI_Ens@proj@val)[[7]]
writeRaster(x=LGM_MPI, filename="LGM_MPI.tif")

LGM_MIROC <- unstack(mc_LGM_MIROC_Ens@proj@val)[[7]]
writeRaster(x=LGM_MIROC, filename="LGM_MIROC.tif")

LGM_CCSM4 <- unstack(mc_LGM_CCSM4_Ens@proj@val)[[7]]
writeRaster(x=LGM_CCSM4, filename="LGM_CCSM4.tif")

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

YD2 <- unstack(mc_YD_Ens@proj@val)[[7]]
writeRaster(x=YD2, filename="YD.tif")

CURRENT_MODEL <- unstack(mc_current_ES@proj@val)[[7]]
writeRaster(x=CURRENT_MODEL, filename="CURRENT_MODEL.tif")


##########################################################################
################################ Analyzing Outputs #######################
##########################################################################

##############################################################
########### YOUNGER DRYAS - FOSSIL VS GENERAL ################
##############################################################

fossil_prone <- shapefile("D:/sig_past_cabrera_distribution/fossilProne/fossil_prone.shp")
#plot(fossil_prone)

#Ceating mask rasters
mask3 <- rasterize(fossil_prone, YD2)
#plot(mask3)

#Do not to which fossil record to compare. Maybe LGM?!

#BACKGROUND - FOSSIL PRONE REGION ################################
#if I use the LGM fossils...
YD_out <- raster("YD.tif")
YD_out2 <- mask3*YD_out
fos_YD <- extract(x=YD_out2, y=fos_lgm)
back_YD_fp <- as.vector(as.matrix(YD_out2))
back_YD_fp <- back_YD_fp[!is.na(back_YD_fp)]


#BACKGROUND - ALL AREA ###########################################

#####BCC-CSM1-1
back_YD <- as.vector(as.matrix(YD_out))
back_YD <- back_YD[!is.na(back_YD)]

#t Student test
m_fp <- t.test(x=fos_YD, y=back_YD_fp, alternative="greater")
n_fp <- t.test(x=fos_YD, y=back_YD, alternative="greater")
#Too few to compare to...

##############################################################
############# HOLOCENE - FOSSIL VS GENERAL ###################
##############################################################

#HOLOCENE - FOSSIL VS GENERAL

#Fossil Shapefile
fos_hol <- shapefile("C:/Users/Frederico/Documents/0. Artigos/4. SUBMETIDOS/Cabrerae Paleodistribution/Paleo/fossils_MH.shp")

#BACKGROUND - FOSSIL PRONE REGION  ###########################################

#####BCC-CSM1-1
H_BCC <- raster("HOL_BCC.tif")
H_BCC2 <- mask1*H_BCC
fos_H_BCC <- extract(x=H_BCC, y=fos_hol)
back_H_BCC_fp <- as.vector(as.matrix(H_BCC2))
back_H_BCC_fp <- back_H_BCC_fp[!is.na(back_H_BCC_fp)]

#####CCSM4
H_CCSM4 <- raster("HOL_CCSM4.tif")
H_CCSM42 <- mask1*H_CCSM4
fos_H_CCSM4 <- extract(x=H_CCSM4, y=fos_hol)
back_H_CCSM4_fp <- as.vector(as.matrix(H_CCSM42))
back_H_CCSM4_fp <- back_H_CCSM4_fp[!is.na(back_H_CCSM4_fp)]

#####CNRM-CM5
H_CNRM <- raster("HOL_CNRM.tif")
H_CNRM2 <- mask1*H_CNRM
fos_H_CNRM <- extract(x=H_CNRM, y=fos_hol)
back_H_CNRM_fp <- as.vector(as.matrix(H_CNRM2))
back_H_CNRM_fp <- back_H_CNRM_fp[!is.na(back_H_CNRM_fp)]

#####HadGEM2-CC
H_HadGEM2_CC <- raster("HOL_HadGEM2_CC.tif")
H_HadGEM2_CC2 <- mask1*H_HadGEM2_CC
fos_H_HadGEM2_CC <- extract(x=H_HadGEM2_CC, y=fos_hol)
back_H_HadGEM2_CC_fp <- as.vector(as.matrix(H_HadGEM2_CC2))
back_H_HadGEM2_CC_fp <- back_H_HadGEM2_CC_fp[!is.na(back_H_HadGEM2_CC_fp)]

#####HadGEM2-ES
H_HadGEM2_ES <- raster("HOL_HadGEM2_ES.tif")
H_HadGEM2_ES2 <- mask1*H_HadGEM2_ES
fos_H_HadGEM2_ES <- extract(x=H_HadGEM2_ES, y=fos_hol)
back_H_HadGEM2_ES_fp <- as.vector(as.matrix(H_HadGEM2_ES2))
back_H_HadGEM2_ES_fp <- back_H_HadGEM2_ES_fp[!is.na(back_H_HadGEM2_ES_fp)]

#####IPSL-CM5A-LR
H_IPSL <- raster("HOL_IPSL.tif")
H_IPSL2 <- mask1*H_IPSL
fos_H_IPSL <- extract(x=H_IPSL, y=fos_hol)
back_H_IPSL_fp <- as.vector(as.matrix(H_IPSL2))
back_H_IPSL_fp <- back_H_IPSL_fp[!is.na(back_H_IPSL_fp)]

#####MIROC-ESM
H_MIROC <- raster("HOL_MIROC.tif")
H_MIROC2 <- mask1*H_MIROC
fos_H_MIROC <- extract(x=H_MIROC, y=fos_hol)
back_H_MIROC_fp <- as.vector(as.matrix(H_MIROC2))
back_H_MIROC_fp <- back_H_MIROC_fp[!is.na(back_H_MIROC_fp)]

#####MPI-ESM-P
H_MPI <- raster("HOL_MPI.tif")
H_MPI2 <- mask1*H_MPI
fos_H_MPI <- extract(x=H_MPI, y=fos_hol)
back_H_MPI_fp <- as.vector(as.matrix(H_MPI2))
back_H_MPI_fp <- back_H_MPI_fp[!is.na(back_H_MPI_fp)]

#####MRI-CGCM3
H_MRI <- raster("HOL_MRI.tif")
H_MRI2 <- mask1*H_MRI
fos_H_MRI <- extract(x=H_MRI, y=fos_hol)
back_H_MRI_fp <- as.vector(as.matrix(H_MRI2))
back_H_MRI_fp <- back_H_MRI_fp[!is.na(back_H_MRI_fp)]

#t Student test
a_fp <- t.test(x=fos_H_BCC, y=back_H_BCC_fp, alternative="greater")
b_fp <- t.test(x=fos_H_CCSM4, y=back_H_CCSM4_fp, alternative="greater")
c1_fp <- t.test(x=fos_H_CNRM, y=back_H_CNRM_fp, alternative="greater")
d_fp <- t.test(x=fos_H_HadGEM2_CC, y=back_H_HadGEM2_CC_fp, alternative="greater")
e_fp <- t.test(x=fos_H_HadGEM2_ES, y=back_H_HadGEM2_ES_fp, alternative="greater")
f_fp <- t.test(x=fos_H_IPSL, y=back_H_IPSL_fp, alternative="greater")
g_fp <- t.test(x=fos_H_MIROC, y=back_H_MIROC_fp, alternative="greater")
h_fp <- t.test(x=fos_H_MPI, y=back_H_MPI_fp, alternative="greater")
i_fp <- t.test(x=fos_H_MRI, y=back_H_MRI_fp, alternative="greater")

round(a_fp$p.value, 3)
round(b_fp$p.value, 3) 
round(c1_fp$p.value, 3)
round(d_fp$p.value, 3)
round(e_fp$p.value, 3)
round(f_fp$p.value, 3)
round(g_fp$p.value, 3)
round(h_fp$p.value, 3)
round(i_fp$p.value, 3)


#BACKGROUND - ALL AREA ###########################################

#####BCC-CSM1-1
back_H_BCC <- as.vector(as.matrix(H_BCC))
back_H_BCC <- back_H_BCC[!is.na(back_H_BCC)]

#####CCSM4
back_H_CCSM4 <- as.vector(as.matrix(H_CCSM4))
back_H_CCSM4 <- back_H_CCSM4[!is.na(back_H_CCSM4)]

#####CNRM-CM5
back_H_CNRM <- as.vector(as.matrix(H_CNRM))
back_H_CNRM <- back_H_CNRM[!is.na(back_H_CNRM)]

#####HadGEM2-CC
back_H_HadGEM2_CC <- as.vector(as.matrix(H_HadGEM2_CC))
back_H_HadGEM2_CC <- back_H_HadGEM2_CC[!is.na(back_H_HadGEM2_CC)]

#####HadGEM2-ES
back_H_HadGEM2_ES <- as.vector(as.matrix(H_HadGEM2_ES))
back_H_HadGEM2_ES <- back_H_HadGEM2_ES[!is.na(back_H_HadGEM2_ES)]

#####IPSL-CM5A-LR
back_H_IPSL <- as.vector(as.matrix(H_IPSL))
back_H_IPSL <- back_H_IPSL[!is.na(back_H_IPSL)]

#####MIROC-ESM
back_H_MIROC <- as.vector(as.matrix(H_MIROC))
back_H_MIROC <- back_H_MIROC[!is.na(back_H_MIROC)]

#####MPI-ESM-P
back_H_MPI <- as.vector(as.matrix(H_MPI))
back_H_MPI <- back_H_MPI[!is.na(back_H_MPI)]

#####MRI-CGCM3
back_H_MRI <- as.vector(as.matrix(H_MRI))
back_H_MRI <- back_H_MRI[!is.na(back_H_MRI)]

#t Student test
a <- t.test(x=fos_H_BCC, y=back_H_BCC, alternative="greater")
b <- t.test(x=fos_H_CCSM4, y=back_H_CCSM4, alternative="greater")
c1 <- t.test(x=fos_H_CNRM, y=back_H_CNRM, alternative="greater")
d <- t.test(x=fos_H_HadGEM2_CC, y=back_H_HadGEM2_CC, alternative="greater")
e <- t.test(x=fos_H_HadGEM2_ES, y=back_H_HadGEM2_ES, alternative="greater")
f <- t.test(x=fos_H_IPSL, y=back_H_IPSL, alternative="greater")
g <- t.test(x=fos_H_MIROC, y=back_H_MIROC, alternative="greater")
h <- t.test(x=fos_H_MPI, y=back_H_MPI, alternative="greater")
i <- t.test(x=fos_H_MRI, y=back_H_MRI, alternative="greater")

round(a$p.value, 3)
round(b$p.value, 3) 
round(c1$p.value, 3)
round(d$p.value, 3)
round(e$p.value, 3)
round(f$p.value, 3)
round(g$p.value, 3)
round(h$p.value, 3)
round(i$p.value, 3)

##############################################################
################## LGM - FOSSIL VS GENERAL ###################
##############################################################

#Fossil Shapefile
fos_lgm <- shapefile("C:/Users/Frederico/Documents/0. Artigos/4. SUBMETIDOS/Cabrerae Paleodistribution/Paleo/fossils_LGM.shp")

#Creating mask
mask2 <- rasterize(fossil_prone,LGM_CCSM4)
#plot(mask2)

#BACKGROUND - FOSSIL PRONE REGION  ###########################################

#####CCSM4
LGM_CCSM4 <- raster("LGM_CCSM4.tif")
LGM_CCSM42_fp <- mask2*LGM_CCSM4
fos_LGM_CCSM4 <- extract(x=LGM_CCSM4, y=fos_lgm)
back_LGM_CCSM4_fp <- as.vector(as.matrix(LGM_CCSM42_fp))
back_LGM_CCSM4_fp <- LGM_CCSM42_fp[!is.na(LGM_CCSM42_fp)]

#####MIROC-ESM
LGM_MIROC <- raster("LGM_MIROC.tif")
LGM_MIROC2_fp <- mask2*LGM_MIROC
fos_LGM_MIROC <- extract(x=LGM_MIROC, y=fos_lgm)
back_LGM_MIROC_fp <- as.vector(as.matrix(LGM_MIROC2_fp))
back_LGM_MIROC_fp <- back_LGM_MIROC_fp[!is.na(back_LGM_MIROC_fp)]

#####MPI-ESM-P
LGM_MPI <- raster("LGM_MPI.tif")
LGM_MPI2_fp <- mask2*LGM_MPI
fos_LGM_MPI <- extract(x=LGM_MPI, y=fos_lgm)
back_LGM_MPI_fp <- as.vector(as.matrix(LGM_MPI2_fp))
back_LGM_MPI_fp <- back_LGM_MPI_fp[!is.na(back_LGM_MPI_fp)]

#t Student test
j_fp <- t.test(x=fos_LGM_CCSM4, y=back_LGM_CCSM4_fp, alternative="greater")
l_fp <- t.test(x=fos_LGM_MIROC,y=back_LGM_MIROC_fp, alternative="greater")
m_fp <- t.test(x=fos_LGM_MPI, y=back_LGM_MPI_fp, alternative="greater")

round(j_fp$p.value,3)
round(l_fp$p.value,3)
round(m_fp$p.value,3)

#BACKGROUND - ALL AREA  ###########################################
#####CCSM4
back_LGM_CCSM4 <- as.vector(as.matrix(LGM_CCSM4))
back_LGM_CCSM4 <- back_LGM_CCSM4[!is.na(back_LGM_CCSM4)]

#####MIROC-ESM
back_LGM_MIROC <- as.vector(as.matrix(LGM_MIROC))
back_LGM_MIROC <- back_LGM_MIROC[!is.na(back_LGM_MIROC)]

#####MPI-ESM-P
back_LGM_MPI <- as.vector(as.matrix(LGM_MPI))
back_LGM_MPI <- back_LGM_MPI[!is.na(back_LGM_MPI)]

#t Student test
j <- t.test(x=fos_LGM_CCSM4, y=back_LGM_CCSM4, alternative="greater")
l <- t.test(x=fos_LGM_MIROC,y=back_LGM_MIROC, alternative="greater")
m <- t.test(x=fos_LGM_MPI, y=back_LGM_MPI, alternative="greater")

round(j$p.value,3)
round(l$p.value,3)
round(m$p.value,3)


#############################################################################
#############################################################################
#Variable Importance - Average per algorithm

v1 <- var_import
f1 <- plyr::alply(v1,4,.dims = TRUE)
v_l <- list()

for (i in 1:5){

t1 <- f1[[i]]

t1 <- plyr::alply(t1,3,.dims = TRUE)

v_l <- c(v_l,t1)
	
}

#Averaging...
out_VI <- apply(simplify2array(v_l), 1:2, mean)

#ANN has one NA (remove that 'run')
ANN_VI <- apply(simplify2array(v_l[c(-6,-20)]), 1:2, mean)
ANN_VI <- as.numeric(ANN_VI[,5])
out_VI[,5] <- ANN_VI

write.table(out_VI, file="VI.csv")

#############################################################################
#############################################################################
#Comparing projection maps

##################### LGM
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

##################### Mid-HOLOCENE

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

#############################################################################
#############################################################################
#Average and variance in both projections

#setwd("C:/Users/FMest/Desktop")

#LGM
LGM <- stack(LGM_R_miroc, LGM_R_ccsm4, LGM_R_mpi)

#YD
YD3 <- raster("YD.tif")

#MH
MH <- stack(HOL_R_miroc, HOL_R_mpi, HOL_R_bcc, HOL_R_ccsm4, HOL_R_cnrm,
HOL_R_hadgem2_cc, HOL_R_hadgem2_es, HOL_R_ipsl, HOL_R_mri)

#LGM
mean_LGM <- calc(LGM, fun=mean)
sd_LGM <- calc(LGM, fun=sd)
writeRaster(x=mean_LGM, filename="mean_LGM", format="ascii")
writeRaster(x=sd_LGM, filename="sd_LGM", format="ascii")

#MH
mean_MH <- calc(MH, fun=mean)
sd_MH <- calc(MH, fun=sd)
writeRaster(x=mean_MH, filename="mean_MH", format="ascii")
writeRaster(x=sd_MH, filename="sd_MH", format="ascii")
