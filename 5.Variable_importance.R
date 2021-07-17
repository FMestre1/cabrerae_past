#Variable  Importance
#FMestre
#02-07-2021

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
#ANN_VI <- apply(simplify2array(v_l[c(-6,-20)]), 1:2, mean)
#ANN_VI <- as.numeric(ANN_VI[,5])
#out_VI[,5] <- ANN_VI

write.table(out_VI, file="VI.csv")
