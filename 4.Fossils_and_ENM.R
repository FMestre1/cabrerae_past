#Fossil Record and ENM
#FMestre
#02-07-2021

#Fossil prone region
fossil_prone <- shapefile("D:/sig_past_cabrera_distribution/fossilProne/fossil_prone.shp")
#plot(fossil_prone)

##############################################################
############### MID-HOLOCENE - FOSSIL AND ENM ################
##############################################################

#Fossil Shapefile for the MH
fos_hol <- shapefile("C:/Users/Frederico/Documents/0. Artigos/4. SUBMETIDOS/Cabrerae Paleodistribution/Paleo/fossils_MH.shp")

############# FOSSILS vs FOSSIL PRONE AREA ############

mask1 <- rasterize(fossil_prone, HOL_BCC)

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

################## FOSSILS vs ALL AREA ################


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
############### YOUNGER DRYAS - FOSSIL AND ENM ###############
##############################################################

############# FOSSILS vs FOSSIL PRONE AREA ############

#Do not to which fossil record to compare. Maybe LGM?!

#Ceating mask rasters
mask3 <- rasterize(fossil_prone, YD2)
#plot(mask3)

YD_out <- raster("YD.tif")
YD_out2 <- mask3*YD_out
fos_YD <- raster::extract(x=YD_out, y=fos_lgm)
back_YD_fp <- as.vector(as.matrix(YD_out2))
back_YD_fp <- back_YD_fp[!is.na(back_YD_fp)]

m_fp <- t.test(x=fos_YD, y=back_YD_fp, alternative="greater")

################## FOSSILS vs ALL AREA ################

back_YD <- as.vector(as.matrix(YD_out))
back_YD <- back_YD[!is.na(back_YD)]

#t Student test
n <- t.test(x=fos_YD, y=back_YD, alternative="greater")

##############################################################
#################### LGM - FOSSIL AND ENM ####################
##############################################################

#Fossil Shapefile
fos_lgm <- shapefile("C:/Users/Frederico/Documents/0. Artigos/4. SUBMETIDOS/Cabrerae Paleodistribution/Paleo/fossils_LGM.shp")

############# FOSSILS vs FOSSIL PRONE AREA ############

#Creating mask
mask2 <- rasterize(fossil_prone,LGM_CCSM4)
#plot(mask2)


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

################## FOSSILS vs ALL AREA ################

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

save.image()
