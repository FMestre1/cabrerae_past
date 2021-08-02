#Ecological Niche Modelling with biomod2
#FMestre
#02-07-2021

setwd("D:/model_past/")

#Load species occurrence data

# Convert data frame to sf object
load("mc3.RData")
mc3_coords <- mc3@coords

#Loading variables
vars <- stack(b3, b8, b12, b18)
names(vars) <- c("bio3", "bio8", "bio12", "bio18")
plot(vars)

#Format data for biomod2
data_biomod <- BIOMOD_FormatingData(resp.var = as.numeric(mc3$mc),
                                    expl.var = vars,
                                    resp.xy = mc3_coords,
                                    resp.name = "mc",
                                    PA.nb.rep = 5,
                                    PA.nb.absences = 469*2,
                                    PA.strategy = "random",
                                    PA.dist.min = 0,
                                    PA.dist.max = NULL,
                                    PA.sre.quant = NULL,
                                    PA.table = NULL,
                                    na.rm = TRUE)


#Modelling options
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
  
 #FDA = list( method = 'mars'),
  
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
                             models = c("GLM","GBM","GAM","CTA","ANN","MARS","RF"),
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
