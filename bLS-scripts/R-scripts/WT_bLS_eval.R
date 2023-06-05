# bLS evaluation WT bLS 
# August 2021

#################################
### Header (Paths, Libraries) ###
#################################

#############################
### # August 2021 - 1st # ###
#############################

library(bLSmodelR)
library(ibts)


PathData <- "C:/Users/AU323818/Dropbox/Uni/eGylle/1st trial Aug21"

PathRSaves <- paste0(PathData,"/RSaves")

Cat.Path <- paste0(PathData,"/bLS data/Catalogs")

#################################

############################
### Preparing Sonic Data ###
############################

Sonic_raw <- read.table(paste0(PathData,"/bLS data/eGylle_1_TT_EC.txt"), header = TRUE, sep = "\t")

Sonic_ibts <- as.ibts(Sonic_raw, st="Time", granularity="30mins") # To get the right time as an ibts object.

# N_traj_EC <- 5E4
N_traj_EC <- 1E5

# ncores <- 88
ncores <- 1
MaxFetch <- -50

Sonic <- genInterval(
  cbind(
    setNames(as.data.frame(Sonic_raw)[,c("UST","L","z0","WD","d","sigU","sigV","sigW","z_sonic")]
    ,c("Ustar","L","Zo","WD","d","sUu","sVu","sWu","z_sWu"))
    ,st=st(Sonic_ibts)
    ,et=et(Sonic_ibts)
    ,Sonic_raw="Sonic"
    ,as.data.frame(Sonic_raw)[,!(names(Sonic_raw) %in% 
    c("Ustar","L","z0","WD","sd_WD","d","sUu","sVu","sWu","z_sonic"))])
  ,MaxFetch=MaxFetch,N=N_traj_EC)


#####################################
### Preparing sources and sensors ###
#####################################
plot1 <- read.table(paste0(PathData,"/QGIS/plot1.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_plot <- read.table(paste0(PathData,"/QGIS/downwind.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_bg <- read.table(paste0(PathData,"/QGIS/background.txt"), header = TRUE, stringsAsFactors = FALSE)

Source <- genSources(Plot = plot1)
plot(Source)

# Sensors
Instr_plot$z <- 1.0 # Provide inlet height
Instr_bg$z <- 1.0

Sensor <- genSensors(CRDS = Instr_plot)
plot(Sensor, Source)



InList <- genInputList(Sensor,Source,Sonic)
InList

####################
### Calculations ###
####################

Results <- runbLS(InList,Cat.Path,ncores = 1)

# saveRDS(Results,file=paste0(PathRSaves,"/WT_bLS_Result_5E4.rds"))
saveRDS(Results,file=paste0(PathRSaves,"/WT_bLS_Result_1E5.rds"))

###
Results <- readRDS (file = file.path(paste0(PathRSaves,"/WT_bLS_Result_1E5.rds")))



# ##########################
## FLAGS ##
### Ustar 
Results$Flag_Ustar0.05 <- Results$Ustar > 0.05
Results$Flag_Ustar0.1 <- Results$Ustar > 0.1
Results$Flag_Ustar0.15 <- Results$Ustar > 0.15

### abs(L) > 10 
# 1/summary(1/Results$L)
Results$Flag_L10 <- abs(Results$L) > 10
Results$Flag_L2 <- abs(Results$L) > 2



# #########################
## SAVE FILES ##
write.table(Results,file=paste0(PathRSaves,"/WT_bLS_1st.csv"), sep=";", row.names = FALSE)







#############################
### # August 2021 - 2nd # ###
#############################

library(bLSmodelR)
library(ibts)


PathData <- "C:/Users/AU323818/Dropbox/Uni/eGylle/2nd trial Aug21"

PathRSaves <- paste0(PathData,"/RSaves")

Cat.Path <- paste0(PathData,"/bLS data/Catalogs")

#################################

############################
### Preparing Sonic Data ###
############################

Sonic_raw <- read.table(paste0(PathData,"/bLS data/eGylle_2_TT_EC.txt"), header = TRUE, sep = "\t")

Sonic_ibts <- as.ibts(Sonic_raw, st="Time", granularity="30mins") # To get the right time as an ibts object.

# N_traj_EC <- 5E4
N_traj_EC <- 1E5

# ncores <- 88
ncores <- 1
MaxFetch <- -50

Sonic <- genInterval(
  cbind(
    setNames(as.data.frame(Sonic_raw)[,c("UST","L","z0","WD","d","sigU","sigV","sigW","z_sonic")]
             ,c("Ustar","L","Zo","WD","d","sUu","sVu","sWu","z_sWu"))
    ,st=st(Sonic_ibts)
    ,et=et(Sonic_ibts)
    ,Sonic_raw="Sonic"
    ,as.data.frame(Sonic_raw)[,!(names(Sonic_raw) %in% 
                                   c("Ustar","L","z0","WD","sd_WD","d","sUu","sVu","sWu","z_sonic"))])
  ,MaxFetch=MaxFetch,N=N_traj_EC)


#####################################
### Preparing sources and sensors ###
#####################################
plot2 <- read.table(paste0(PathData,"/QGIS/plot2.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_plot <- read.table(paste0(PathData,"/QGIS/downwind.txt"), header = TRUE, stringsAsFactors = FALSE)
Instr_bg <- read.table(paste0(PathData,"/QGIS/background.txt"), header = TRUE, stringsAsFactors = FALSE)

Source <- genSources(Plot = plot2)
plot(Source)

# Sensors
Instr_plot$z <- 0.5 # Provide inlet height
Instr_bg$z <- 0.5

Sensor <- genSensors(CRDS = Instr_plot)
plot(Sensor, Source)



InList <- genInputList(Sensor,Source,Sonic)
InList

####################
### Calculations ###
####################

Results <- runbLS(InList,Cat.Path,ncores = 1)

# saveRDS(Results,file=paste0(PathRSaves,"/WT_bLS_Result_5E4.rds"))
saveRDS(Results,file=paste0(PathRSaves,"/WT_bLS_Result_1E5.rds"))

###
Results <- readRDS (file = file.path(paste0(PathRSaves,"/WT_bLS_Result_1E5.rds")))



# ##########################
## FLAGS ##
### Ustar 
Results$Flag_Ustar0.05 <- Results$Ustar > 0.05
Results$Flag_Ustar0.1 <- Results$Ustar > 0.1
Results$Flag_Ustar0.15 <- Results$Ustar > 0.15

### abs(L) > 10 
# 1/summary(1/Results$L)
Results$Flag_L10 <- abs(Results$L) > 10
Results$Flag_L2 <- abs(Results$L) > 2



# #########################
## SAVE FILES ##
write.table(Results,file=paste0(PathRSaves,"/WT_bLS_2nd.csv"), sep=";", row.names = FALSE)





