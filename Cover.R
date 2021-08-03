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
#setwd("D:/")

setwd("C:/Users/Frederico/Documents/github/cabrerae_past2")

#Create temporary folder for intermediate results
#rasterOptions(tmpdir="D:/biomod_temp")

#Load packages
library(biomod2)
library(maptools)
library(raster)
library(plyr)
library(fuzzySim)

#Install development version of biomod2
#devtools::install_github('biomodhub/biomod2', dependencies = TRUE)

#Package citation
citation(package = "biomod2", lib.loc = NULL, auto = NULL)
citation("raster")
citation("maptools")
citation("fuzzySim")
citation("plyr")

#Save environment
#save.image(file='cabrerae_past.RData')
#load('cabrerae_past.RData')
