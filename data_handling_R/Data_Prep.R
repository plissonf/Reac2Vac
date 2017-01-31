# Working directory
/Users/fabienplisson/Desktop/VAERS_db/VAERSData

# Libraries
library(ggplot2)
library(dplyr)
library(readr)
library(data.table)
library(reshape2)
library(tidyr)
library(utils)

# Load all 3 types of files (DATA, SYMPTOMS, VAX)

DATA <- list.files(pattern="*VAERSDATA.csv")


d1 <- read.csv("1990VAERSDATA.csv", header=TRUE)
d2 <- read.csv("1991VAERSDATA.csv", header=TRUE)
d3 <- read.csv("1992VAERSDATA.csv", header=TRUE)
d4 <- read.csv("1993VAERSDATA.csv", header=TRUE)
d5 <- read.csv("1994VAERSDATA.csv", header=TRUE)
d6 <- read.csv("1995VAERSDATA.csv", header=TRUE)
d7 <- read.csv("1996VAERSDATA.csv", header=TRUE)
d8 <- read.csv("1997VAERSDATA.csv", header=TRUE)
d9 <- read.csv("1998VAERSDATA.csv", header=TRUE)
d10 <- read.csv("1999VAERSDATA.csv", header=TRUE)
d11 <- read.csv("2000VAERSDATA.csv", header=TRUE)
d12 <- read.csv("2001VAERSDATA.csv", header=TRUE)
d13 <- read.csv("2002VAERSDATA.csv", header=TRUE)
d14 <- read.csv("2003VAERSDATA.csv", header=TRUE)
d15 <- read.csv("2004VAERSDATA.csv", header=TRUE)
d16 <- read.csv("2005VAERSDATA.csv", header=TRUE)
d17 <- read.csv("2006VAERSDATA.csv", header=TRUE)
d18 <- read.csv("2007VAERSDATA.csv", header=TRUE)
d19 <- read.csv("2009VAERSDATA.csv", header=TRUE)
d20 <- read.csv("2011VAERSDATA.csv", header=TRUE)
d21 <- read.csv("2012VAERSDATA.csv", header=TRUE)
d22 <- read.csv("2013VAERSDATA.csv", header=TRUE)
d23 <- read.csv("2014VAERSDATA.csv", header=TRUE)
d24 <- read.csv("2015VAERSDATA.csv", header=TRUE)
d25 <- read.csv("2016VAERSDATA.csv", header=TRUE)

# Assemble all DATA files since 1990 - dataframe 442,393 obs and 29 features
data <- rbind(d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25)
Patient <- as.vector(data$VAERS_ID) # 442,393 unique patients
write.csv(data, file="data.csv")

s1 <- read.csv("1990VAERSSYMPTOMS.csv", header=TRUE)
s2 <- read.csv("1991VAERSSYMPTOMS.csv", header=TRUE)
s3 <- read.csv("1992VAERSSYMPTOMS.csv", header=TRUE)
s4 <- read.csv("1993VAERSSYMPTOMS.csv", header=TRUE)
s5 <- read.csv("1994VAERSSYMPTOMS.csv", header=TRUE)
s6 <- read.csv("1995VAERSSYMPTOMS.csv", header=TRUE)
s7 <- read.csv("1996VAERSSYMPTOMS.csv", header=TRUE)
s8 <- read.csv("1997VAERSSYMPTOMS.csv", header=TRUE)
s9 <- read.csv("1998VAERSSYMPTOMS.csv", header=TRUE)
s10 <- read.csv("1999VAERSSYMPTOMS.csv", header=TRUE)
s11 <- read.csv("2000VAERSSYMPTOMS.csv", header=TRUE)
s12 <- read.csv("2001VAERSSYMPTOMS.csv", header=TRUE)
s13 <- read.csv("2002VAERSSYMPTOMS.csv", header=TRUE)
s14 <- read.csv("2003VAERSSYMPTOMS.csv", header=TRUE)
s15 <- read.csv("2004VAERSSYMPTOMS.csv", header=TRUE)
s16 <- read.csv("2005VAERSSYMPTOMS.csv", header=TRUE)
s17 <- read.csv("2006VAERSSYMPTOMS.csv", header=TRUE)
s18 <- read.csv("2007VAERSSYMPTOMS.csv", header=TRUE)
s19 <- read.csv("2009VAERSSYMPTOMS.csv", header=TRUE)
s20 <- read.csv("2011VAERSSYMPTOMS.csv", header=TRUE)
s21 <- read.csv("2012VAERSSYMPTOMS.csv", header=TRUE)
s22 <- read.csv("2013VAERSSYMPTOMS.csv", header=TRUE)
s23 <- read.csv("2014VAERSSYMPTOMS.csv", header=TRUE)
s24 <- read.csv("2015VAERSSYMPTOMS.csv", header=TRUE)
s25 <- read.csv("2016VAERSSYMPTOMS.csv", header=TRUE)

# Assemble all SYMPTOMS files since 1990, dataframe of 532,589 obs. and 11 features
symp <- rbind(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25)
# How many patient records with unique VAERS_ID? 442393
unique(symp$VAERS_ID) # just check that Symp dataset as equal number of patients - Yes.

v1 <- read.csv("1990VAERSVAX.csv", header=TRUE)
v2 <- read.csv("1991VAERSVAX.csv", header=TRUE)
v3 <- read.csv("1992VAERSVAX.csv", header=TRUE)
v4 <- read.csv("1993VAERSVAX.csv", header=TRUE)
v5 <- read.csv("1994VAERSVAX.csv", header=TRUE)
v6 <- read.csv("1995VAERSVAX.csv", header=TRUE)
v7 <- read.csv("1996VAERSVAX.csv", header=TRUE)
v8 <- read.csv("1997VAERSVAX.csv", header=TRUE)
v9 <- read.csv("1998VAERSVAX.csv", header=TRUE)
v10 <- read.csv("1999VAERSVAX.csv", header=TRUE)
v11 <- read.csv("2000VAERSVAX.csv", header=TRUE)
v12 <- read.csv("2001VAERSVAX.csv", header=TRUE)
v13 <- read.csv("2002VAERSVAX.csv", header=TRUE)
v14 <- read.csv("2003VAERSVAX.csv", header=TRUE)
v15 <- read.csv("2004VAERSVAX.csv", header=TRUE)
v16 <- read.csv("2005VAERSVAX.csv", header=TRUE)
v17 <- read.csv("2006VAERSVAX.csv", header=TRUE)
v18 <- read.csv("2007VAERSVAX.csv", header=TRUE)
v19 <- read.csv("2009VAERSVAX.csv", header=TRUE)
v20 <- read.csv("2011VAERSVAX.csv", header=TRUE)
v21 <- read.csv("2012VAERSVAX.csv", header=TRUE)
v22 <- read.csv("2013VAERSVAX.csv", header=TRUE)
v23 <- read.csv("2014VAERSVAX.csv", header=TRUE)
v24 <- read.csv("2015VAERSVAX.csv", header=TRUE)
v25 <- read.csv("2016VAERSVAX.csv", header=TRUE)


# Assemble all VAX files since 1990, dataframe of 709,907 obs. and 8 features
vax <- rbind(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
str(vax)
write.csv(vax, file="vax.csv")
unique(vax$VAERS_ID) # just check that Vax dataset as identical number of patients - Yes.

# Symptoms dataset "symp"
# 1 - Eliminate feature "symptom version" of dataframe symp 
str(symp)
symp <- symp[ -c(3,5,7,9,11)]
str(symp) # 532,594 "patient" observations  by 5 "symptoms" levels 
write.csv(symp, file="symp.csv") #{utils}

symp <- read.csv("symp.csv", header=TRUE)
symp_melt <- melt(symp, id.vars = unique("VAERS_ID"))
symp_melt$variable <- NULL
names(symp_melt)[names(symp_melt)=="value"] <- "SYMPTOMS"
str(symp_melt)
symp_df <- as.data.frame.matrix(symp_melt)
write.csv(symp_df, file="symp_df.csv")
UniqSymp <- unique(symp_df$SYMPTOMS) # 7934 unique symptoms

# Bowlean matrix from symptoms per patient - dataframe (442,393 x 7,934) has over 2^31 elements
symp_df <- read.csv("symp_df.csv", header=TRUE, na.strings=c("", " ")) # replace blank by NA values
symp_df <- colnames("ID", "VAERS_ID", "SYMPTOMS")
symp_df$X <- NULL
symp_clean <- na.omit(symp_df) # Removing all "patient-symptoms" with blank information
symp_clean <- colnames("ID", "VAERS_ID", "SYMPTOMS")
write.csv(symp_clean, file="symp_clean.csv", row.names=FALSE) # remove row indices and write file


# Attempt to make a bowlean matrix
symp_mat <- table(symp_clean$VAERS_ID, symp_clean$SYMPTOMS) # too big to execute alone!

# Splitting method
## 1- split the data into smaller dataframes (20)
symp_split <- split(symp_clean,rep(1:10,each=266297))

## 2- create as many bowlean matrices
symp_mat1 <- table(symp_split[[1]])
write.csv(symp_mat1, file="symp_mat1.csv")

symp_mat2 <- table(symp_split[[2]])
write.csv(symp_mat2, file="symp_mat2.csv") 

symp_mat3 <- table(symp_split[[3]])
write.csv(symp_mat3, file="symp_mat3.csv") 

symp_mat4 <- table(symp_split[[4]])
write.csv(symp_mat3, file="symp_mat3.csv") 

symp_mat5 <- table(symp_split[[5]])

symp_mat6 <- table(symp_split[[6]])

symp_mat7 <- table(symp_split[[7]])

symp_mat8 <- table(symp_split[[8]])

symp_mat9 <- table(symp_split[[9]])

symp_mat10 <- table(symp_split[[10]])

## 3- assemble unique bowlean matrix by adding patient (rows) of smaller bowlean matrices
symp_mat01 <- rbind(symp_mat1, symp_mat2, symp_mat3)

## Sampling bowlean with first 10,000 "patients" obs. ~ 5% all patients
symp_clean <- read.csv("symp_clean.csv", header=TRUE)
set.seed(123)
symp_sample <- symp_clean[sample(nrow(symp_clean), 22000),]
uniqsympsamp <- unique(symp_sample$SYMPTOMS)
symp_sample_mat <- table(symp_sample$VAERS_ID, symp_sample$SYMPTOMS) # 21125 patients x 7933 symptoms
write.csv(symp_sample_mat, file="symp_sample_mat.csv", row.names=FALSE)



# Melt table to have each patient and associated type(s) of vaccine (or viral infection)
vax <- read.csv("vax.csv", header=TRUE)
vax_melt <- melt(vax, id.vars = c("VAERS_ID", "VAX_TYPE"), na.rm=TRUE) 
vax_melt$variable <- NULL
vax_melt$value <- NULL
head(vax_melt)
write.csv(vax_melt, file="vax_melt.csv", row.names=FALSE) 
vax_sub <- vax_melt[c("VAERS_ID", "VAX_TYPE")] # keep only vaccine type

vax_agg <- aggregate(VAX_TYPE ~ VAERS_ID, data=vax_sub, toString)
write.csv(vax_agg, file="vax_agg.csv", row.names=FALSE) # Type and diversity of vaccine per patient

# Create Bowlean matrix with counts of vaccine as features
vax_mat2 <- table(vax_agg)
vax_count <- as.data.frame.matrix(vax_mat) # save matrix as data.frame
write.csv(vax_count, file="vax_count.csv", row.names=FALSE) 

# Create Bowlean matrix with types of vaccine as features and patient as observations
vax_type <- as.data.frame.matrix(vax_mat) # save matrix as data.frame
vax_type[vax_type>0] <- 1
head(vax_type)
write.csv(vax_type, file="vax_type.csv", row.names=FALSE) 

#1. Grouping "vaccines count": rename columns
vax_df <- vax_count
head(vax_df)
colnames(vax_df)
colnames(vax_df)[colnames(vax_df)=="VARZOS"] <- "Herpes"
colnames(vax_df)[colnames(vax_df)=="VAR"] <- "Varicella"
colnames(vax_df)[colnames(vax_df)=="VARCEL"] <- "Varicella"
colnames(vax_df)[colnames(vax_df)=="TBE"] <- "Tick-Borne Encephalitis"
colnames(vax_df)[colnames(vax_df)=="RAB"] <- "Rabies"
colnames(vax_df)[colnames(vax_df)=="SSEV"] <- "Seasonal Encephalitis"
colnames(vax_df)[colnames(vax_df)=="YF"] <- "Yellow Fever"
colnames(vax_df)[colnames(vax_df)=="TYP"] <- "Typhoid"
colnames(vax_df)[colnames(vax_df)=="MEA"] <- "Measles"
colnames(vax_df)[colnames(vax_df)=="CHOL"] <- "Cholera"
colnames(vax_df)[colnames(vax_df)=="BCG"] <- "Bacillus Calmette_Guerin"
colnames(vax_df)[colnames(vax_df)=="ANTH"] <- "Anthrax"
colnames(vax_df)[colnames(vax_df)=="SMALL"] <- "Small Pox"
colnames(vax_df)[colnames(vax_df)=="RUB"] <- "Rubella"
colnames(vax_df)[colnames(vax_df)=="LYME"] <- "Lyme Disease"
colnames(vax_df)[colnames(vax_df)=="MU"] <- "Mumps"
colnames(vax_df)[colnames(vax_df)=="PLAGUE"] <- "Plague"

# Combos
colnames(vax_df)[colnames(vax_df)=="ADEN"] <- "Adenovirus"
colnames(vax_df)[colnames(vax_df)=="ADEN_4_7"] <- "Adenovirus"

colnames(vax_df)[colnames(vax_df)=="TTOX"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="TD"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="TDAP"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="TDAPIPV"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="DT"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[c(9:10,18,46,64)] <- "Diphtheria+Tetanus+Pertussis"

colnames(vax_df)[c(47:49)] <- "Japanese Encephalitis"
colnames(vax_df)[c(67, 68, 69, 84)] <- "Pneumonia"
colnames(vax_df)[c(72:75)] <- "Rotavirus"
colnames(vax_df)[c(1,7,11:17)] <- "Polio Virus Combos"
colnames(vax_df)[c(42:45)] <- "Human Papillovirus"
colnames(vax_df)[c(36, 41)] <- "Haemophilus Influenza B"
colnames(vax_df)[c(20, 35)] <- "HIB Combos"
colnames(vax_df)[c(19:23)] <- "Polio Virus Combos"
colnames(vax_df)[c(25:28, 30:32)] <- "Seasonal Influenza"
colnames(vax_df)[c(24, 29, 33:34)] <- "Pandemic Influenza"
colnames(vax_df)[c(37:40)] <- "Hepatitis"
colnames(vax_df)[c(52:54, 59:61)] <- "Meningococcal meningitis"
colnames(vax_df)[c(56:58)] <- "Measles+Mumps+Rubella"
colnames(vax_df)[63] <- "Measles+Mumps+Rubella"
colnames(vax_df)[55] <- "Measles+Rubella"
colnames(vax_df)[65] <- "Pertussis"

# Re-assign number to each column / specific "vaccine" to allow grouping
vax_df <- vax_aggr
colnames(vax_df)[colnames(vax_df)=="PolioVirus_Combos_repeats"] <- "PV_repeats"
colnames(vax_df)[colnames(vax_df)=="Adenovirus"] <- "Adn_repeats"
colnames(vax_df)[colnames(vax_df)=="Anthrax"] <- "Anth_repeats"
colnames(vax_df)[colnames(vax_df)=="Bacillus_Calmette_Guerin"] <- "BCG_repeats"
colnames(vax_df)[colnames(vax_df)=="Cholera"] <- "Chol_repeats"
colnames(vax_df)[colnames(vax_df)=="Diphtheria+Tetanus+Pertussis"] <- "DTP_repeats"
colnames(vax_df)[colnames(vax_df)=="Pandemic_Influenza"] <- "PanInfl_repeats"
colnames(vax_df)[colnames(vax_df)=="Seasonal_Influenza"] <- "SeasInfl_repeats"
colnames(vax_df)[colnames(vax_df)=="HIB_Combos"] <- "HIB_Combos_repeats"
colnames(vax_df)[colnames(vax_df)=="Haemophilus_Influenza_B"] <- "HIB_repeats"
colnames(vax_df)[colnames(vax_df)=="Hepatitis"] <- "Hep_repeats"
colnames(vax_df)[colnames(vax_df)=="Human_Papillovirus"] <- "HPV_repeats"
colnames(vax_df)[colnames(vax_df)=="Japanese_Encephalitis"] <-"JapEnc_repeats"
colnames(vax_df)[colnames(vax_df)=="Lyme_Disease"] <- "LymeDis_repeats"
colnames(vax_df)[colnames(vax_df)=="Measles"] <- "Measles_repeats"
colnames(vax_df)[colnames(vax_df)=="Meningococcal_meningitis"] <- "Mening_repeats"
colnames(vax_df)[colnames(vax_df)=="Measles+Rubella"] <- "MR_repeats"
colnames(vax_df)[colnames(vax_df)=="Measles+Mumps+Rubella"] <- "MMR_repeats"
colnames(vax_df)[colnames(vax_df)=="Mumps"] <- "Mu_repeats"
colnames(vax_df)[colnames(vax_df)=="Pertussis"] <- "Pert_repeats"
colnames(vax_df)[colnames(vax_df)=="Plague"] <- "Plag_repeats"
colnames(vax_df)[colnames(vax_df)=="Pneumonia"] <- "Pneum_repeats"
colnames(vax_df)[colnames(vax_df)=="Rabies"] <- "Rab_repeats"
colnames(vax_df)[colnames(vax_df)=="Rubella"] <- "Rub_repeats"
colnames(vax_df)[colnames(vax_df)=="Rotavirus"] <- "Rota_repeats"
colnames(vax_df)[colnames(vax_df)=="Small_Pox"] <- "SmallPox_repeats"
colnames(vax_df)[colnames(vax_df)=="Seasonal_Encephalitis"] <- "SeasEnc_repeats"
colnames(vax_df)[colnames(vax_df)=="Tick-Borne_Encephalitis"] <- "TBE_repeats"
colnames(vax_df)[colnames(vax_df)=="Typhoid"] <- "Typh_repeats"
colnames(vax_df)[colnames(vax_df)=="Varicella"] <- "Vari_repeats"
colnames(vax_df)[colnames(vax_df)=="Herpes"] <- "Herp_repeats"
colnames(vax_df)[colnames(vax_df)=="Yellow_Fever"] <- "YF_repeats"


# Merge columns with same or similar denominations
#http://stackoverflow.com/questions/8961063/combining-multiple-identically-named-columns-in-r
dim(vax_df)
vax_trans <- t(vax_df)
aggr <- by(vax_trans, INDICES=row.names(vax_trans), FUN=colSums)
vax_aggr <- as.data.frame(do.call(cbind,aggr))

# Re-assign names to columns
colnames(vax_aggr)[colnames(vax_aggr)=="PolioVirus_Combos"] <- "PV_repeats"
colnames(vax_aggr)[colnames(vax_aggr)=="Adenovirus"] <- "Adn_repeats"
colnames(vax_aggr)[colnames(vax_aggr)=="Anthrax"] <- "Anth_repeats"
colnames(vax_aggr)[colnames(vax_aggr)=="Bacillus CalGuerin"] <- "BCG_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==5] <- "Chol_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==6] <- "DTP_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==7] <- "PanInfl_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==8] <- "SeasInfl_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==9] <- "HIB_Combos_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==10] <- "HIB_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==11] <- "Hep_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==12] <- "HPV_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==13] <- "JapEnc_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==14] <- "LymeDis_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==15] <- "Measles_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==16] <- "Mening_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==17] <- "MR_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==18] <- "MMR_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==19] <- "Mu_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==20] <- "Pert_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==21] <- "Plag_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==22] <- "Pneum_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==23] <- "Rab_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==24] <- "Rub_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==25] <- "Rota_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==26] <- "SmallPox_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==27] <- "SeasEnce_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==28] <- "TBE_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==29] <- "Typh_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==30] <- "Var_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==31] <- "Herp_repeats"
colnames(vax_aggr)[colnames(vax_aggr)==32] <- "YF_repeats"
 
ID <- as.factor(rownames(aggr))
vax_count_aggr <- cbind(ID, vax_aggr) # Ready to cbind
write.csv(vax_count_aggr, file="vax_count_aggr.csv", row.names=FALSE) 
write.csv(vax_df, file="vax_totalcount.csv", row.names=FALSE) 

# 2. Grouping "vaccines type": rename columns
vax_df <- vax_type
head(vax_df)
colnames(vax_df)
colnames(vax_df)[colnames(vax_df)=="VARZOS"] <- "Herpes"
colnames(vax_df)[colnames(vax_df)=="VAR"] <- "Varicella"
colnames(vax_df)[colnames(vax_df)=="VARCEL"] <- "Varicella"
colnames(vax_df)[colnames(vax_df)=="TBE"] <- "Tick-Borne Encephalitis"
colnames(vax_df)[colnames(vax_df)=="RAB"] <- "Rabies"
colnames(vax_df)[colnames(vax_df)=="SSEV"] <- "Seasonal Encephalitis"
colnames(vax_df)[colnames(vax_df)=="YF"] <- "Yellow Fever"
colnames(vax_df)[colnames(vax_df)=="TYP"] <- "Typhoid"
colnames(vax_df)[colnames(vax_df)=="MEA"] <- "Measles"
colnames(vax_df)[colnames(vax_df)=="CHOL"] <- "Cholera"
colnames(vax_df)[colnames(vax_df)=="BCG"] <- "Bacillus Calmette_Guerin"
colnames(vax_df)[colnames(vax_df)=="ANTH"] <- "Anthrax"
colnames(vax_df)[colnames(vax_df)=="SMALL"] <- "Small Pox"
colnames(vax_df)[colnames(vax_df)=="RUB"] <- "Rubella"
colnames(vax_df)[colnames(vax_df)=="LYME"] <- "Lyme Disease"
colnames(vax_df)[colnames(vax_df)=="MU"] <- "Mumps"
colnames(vax_df)[colnames(vax_df)=="PLAGUE"] <- "Plague"

# Combos
colnames(vax_df)[colnames(vax_df)=="ADEN"] <- "Adenovirus"
colnames(vax_df)[colnames(vax_df)=="ADEN_4_7"] <- "Adenovirus"

colnames(vax_df)[colnames(vax_df)=="TTOX"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="TD"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="TDAP"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="TDAPIPV"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[colnames(vax_df)=="DT"] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_df)[c(9:10,18,46,64)] <- "Diphtheria+Tetanus+Pertussis"

colnames(vax_df)[c(47:49)] <- "Japanese Encephalitis"
colnames(vax_df)[c(67, 68, 69, 84)] <- "Pneumonia"
colnames(vax_df)[c(72:75)] <- "Rotavirus"
colnames(vax_df)[c(1,7,11:17)] <- "Polio Virus Combos"
colnames(vax_df)[c(42:45)] <- "Human Papillovirus"
colnames(vax_df)[c(36, 41)] <- "Haemophilus Influenza B"
colnames(vax_df)[c(20, 35)] <- "HIB Combos"
colnames(vax_df)[c(19:23)] <- "Polio Virus Combos"
colnames(vax_df)[c(25:28, 30:32)] <- "Seasonal Influenza"
colnames(vax_df)[c(24, 29, 33:34)] <- "Pandemic Influenza"
colnames(vax_df)[c(37:40)] <- "Hepatitis"
colnames(vax_df)[c(52:54, 59:61)] <- "Meningococcal meningitis"
colnames(vax_df)[c(56:58)] <- "Measles+Mumps+Rubella"
colnames(vax_df)[63] <- "Measles+Mumps+Rubella"
colnames(vax_df)[55] <- "Measles+Rubella"
colnames(vax_df)[65] <- "Pertussis"

# Re-assign number to each column / specific "vaccine" to allow grouping
colnames(vax_df)[colnames(vax_df)=="Polio Virus Combos"] <- 1
colnames(vax_df)[colnames(vax_df)=="Adenovirus"] <- 2
colnames(vax_df)[colnames(vax_df)=="Anthrax"] <- 3
colnames(vax_df)[colnames(vax_df)=="Bacillus Calmette_Guerin"] <- 4
colnames(vax_df)[colnames(vax_df)=="Cholera"] <- 5
colnames(vax_df)[colnames(vax_df)=="Diphtheria+Tetanus+Pertussis"] <- 6
colnames(vax_df)[colnames(vax_df)=="Pandemic Influenza"] <- 7
colnames(vax_df)[colnames(vax_df)=="Seasonal Influenza"] <- 8
colnames(vax_df)[colnames(vax_df)=="HIB Combos"] <- 9
colnames(vax_df)[colnames(vax_df)=="Haemophilus Influenza B"] <- 10
colnames(vax_df)[colnames(vax_df)=="Hepatitis"] <- 11
colnames(vax_df)[colnames(vax_df)=="Human Papillovirus"] <- 12
colnames(vax_df)[colnames(vax_df)=="Japanese Encephalitis"] <- 13
colnames(vax_df)[colnames(vax_df)=="Lyme Disease"] <- 14
colnames(vax_df)[colnames(vax_df)=="Measles"] <- 15
colnames(vax_df)[colnames(vax_df)=="Meningococcal meningitis"] <- 16
colnames(vax_df)[colnames(vax_df)=="Measles+Rubella"] <- 17
colnames(vax_df)[colnames(vax_df)=="Measles+Mumps+Rubella"] <- 18
colnames(vax_df)[colnames(vax_df)=="Mumps"] <- 19
colnames(vax_df)[colnames(vax_df)=="Pertussis"] <- 20
colnames(vax_df)[colnames(vax_df)=="Plague"] <- 21
colnames(vax_df)[colnames(vax_df)=="Pneumonia"] <- 22
colnames(vax_df)[colnames(vax_df)=="Rabies"] <- 23
colnames(vax_df)[colnames(vax_df)=="Rubella"] <- 24
colnames(vax_df)[colnames(vax_df)=="Rotavirus"] <- 25
colnames(vax_df)[colnames(vax_df)=="Small Pox"] <- 26
colnames(vax_df)[colnames(vax_df)=="Seasonal Encephalitis"] <- 27
colnames(vax_df)[colnames(vax_df)=="Tick-Borne Encephalitis"] <- 28
colnames(vax_df)[colnames(vax_df)=="Typhoid"] <- 29
colnames(vax_df)[colnames(vax_df)=="Varicella"] <- 30
colnames(vax_df)[colnames(vax_df)=="Herpes"] <- 31
colnames(vax_df)[colnames(vax_df)=="Yellow Fever"] <- 32


# Merge columns with same or similar denominations
#http://stackoverflow.com/questions/8961063/combining-multiple-identically-named-columns-in-r
dim(vax_df)
vax_trans <- t(vax_df)
aggr <- by(vax_trans, INDICES=row.names(vax_trans), FUN=colSums)
vax_aggr <- as.data.frame(do.call(cbind,aggr))

# Re-assign names to columns
colnames(vax_aggr)[colnames(vax_aggr)==1] <- "PolioVirus_Combos"
colnames(vax_aggr)[colnames(vax_aggr)==2] <- "Adenovirus"
colnames(vax_aggr)[colnames(vax_aggr)==3] <- "Anthrax"
colnames(vax_aggr)[colnames(vax_aggr)==4] <- "Bacillus_Calmette_Guerin"
colnames(vax_aggr)[colnames(vax_aggr)==5] <- "Cholera"
colnames(vax_aggr)[colnames(vax_aggr)==6] <- "Diphtheria+Tetanus+Pertussis"
colnames(vax_aggr)[colnames(vax_aggr)==7] <- "Pandemic_Influenza"
colnames(vax_aggr)[colnames(vax_aggr)==8] <- "Seasonal_Influenza"
colnames(vax_aggr)[colnames(vax_aggr)==9] <- "HIB_Combos"
colnames(vax_aggr)[colnames(vax_aggr)==10] <- "Haemophilus_Influenza_B"
colnames(vax_aggr)[colnames(vax_aggr)==11] <- "Hepatitis"
colnames(vax_aggr)[colnames(vax_aggr)==12] <- "Human_Papillovirus"
colnames(vax_aggr)[colnames(vax_aggr)==13] <- "Japanese_Encephalitis"
colnames(vax_aggr)[colnames(vax_aggr)==14] <- "Lyme Disease"
colnames(vax_aggr)[colnames(vax_aggr)==15] <- "Measles"
colnames(vax_aggr)[colnames(vax_aggr)==16] <- "Meningococcal_meningitis"
colnames(vax_aggr)[colnames(vax_aggr)==17] <- "Measles+Rubella"
colnames(vax_aggr)[colnames(vax_aggr)==18] <- "Measles+Mumps+Rubella"
colnames(vax_aggr)[colnames(vax_aggr)==19] <- "Mumps"
colnames(vax_aggr)[colnames(vax_aggr)==20] <- "Pertussis"
colnames(vax_aggr)[colnames(vax_aggr)==21] <- "Plague"
colnames(vax_aggr)[colnames(vax_aggr)==22] <- "Pneumonia"
colnames(vax_aggr)[colnames(vax_aggr)==23] <- "Rabies"
colnames(vax_aggr)[colnames(vax_aggr)==24] <- "Rubella"
colnames(vax_aggr)[colnames(vax_aggr)==25] <- "Rotavirus"
colnames(vax_aggr)[colnames(vax_aggr)==26] <- "Small_Pox"
colnames(vax_aggr)[colnames(vax_aggr)==27] <- "Seasonal_Encephalitis"
colnames(vax_aggr)[colnames(vax_aggr)==28] <- "Tick-Borne_Encephalitis"
colnames(vax_aggr)[colnames(vax_aggr)==29] <- "Typhoid"
colnames(vax_aggr)[colnames(vax_aggr)==30] <- "Varicella"
colnames(vax_aggr)[colnames(vax_aggr)==31] <- "Herpes"
colnames(vax_aggr)[colnames(vax_aggr)==32] <- "Yellow_Fever"

ID <- unique(vax$VAERS_ID)
vax_aggr <- cbind(ID, vax_aggr) # Ready to cbind
write.csv(vax_aggr, file="vax_totaltype.csv", row.names=FALSE) 

# Feature reduction in dataframe "data" prior to combine
data <- read.csv("data.csv", header=TRUE)
str(data)
names(data)
myvars <- c("VAERS_ID", "STATE", "AGE_YRS", "SEX", "DIED", "ER_VISIT", "VAX_DATE", "NUMDAYS", "RPT_DATE")
PersonData2 <- PersonData[myvars]
dim(PersonData2)
colnames(PersonData2)[colnames(PersonData2)=="VAERS_ID"] <- "ID"

PersonData2$ER_VISIT <- sub("^$", "0", PersonData2$ER_VISIT)
PersonData2$ER_VISIT <- sub("Y", "1", PersonData2$ER_VISIT)
PersonData2$DIED <- sub("Y", "1", PersonData2$DIED)

# Combine "data2" and "vax_aggr2" datasets by ID
vax_aggr2 <- read.csv("vax_aggr2.csv", header=TRUE)
data_vax <- merge(data2, vax_aggr2, by="ID") # complete 442393 patients and 40 variables
write.csv(data_vax, file="data_vax.csv", row.names=FALSE) 

# Plot number of vaccinations per year
data_vax <- read.csv("data_vax.csv", header=TRUE)
dim(data_vax)

dates <- data_vax$VAX_DATE

data_vax$ER_VISIT <- sub("^$", "0", data_vax$ER_VISIT)
data_vax$ER_VISIT <- sub("Y", "1", data_vax$ER_VISIT)
data_vax$DIED <- sub("Y", "1", data_vax$DIED)
data_vax$DIED <- sub("^$", "0", data_vax$DIED)
data_vax$SEX <- sub("M", "1", data_vax$SEX)
data_vax$SEX <- sub("F", "2", data_vax$SEX)
data_vax$SEX <- sub("U", "3", data_vax$SEX)
data_vax <- cbind(dates, data_vax)
data_vax$VAX_DATE <- NULL
write.csv(data_vax, file="data_vax_clean.csv", row.names=FALSE)


boxplot(AGE_YRS~SEX, data=data_vax, main="Age Range per Gender", ylab="Age (Yrs)", xlab="Gender", col=c("blue", "pink", "gray"))
png("Gender Immunizations.png")
pdf("Gender Immunizations.pdf")
dev.off()
save

## Sampling bowlean with first 22,000 "patients" obs. ~ 5% all patients
symp_clean <- read.csv("symp_clean.csv", header=TRUE)
set.seed(123)
symp_sample <- symp_clean[sample(nrow(symp_clean), 22000),]
uniqsympsamp <- unique(symp_sample$SYMPTOMS)
symp_sample_mat <- table(symp_sample$VAERS_ID, symp_sample$SYMPTOMS) # 21125 patients x 7933 symptoms
write.csv(symp_sample_mat, file="symp_sample_mat.csv", row.names=FALSE)
vector_patient <- as.factor(symp_sample$VAERS_ID)
colnames(symp_sample)[colnames(symp_sample)=="VAERS_ID"] <- "ID"
vector_patient <- as.factor(symp_sample$ID)

# Execute K-means clustering on symp_sample_sat
dim(symp_sample_mat)
symp_sample_mat2 <- as.data.frame.matrix(symp_sample_mat)
write.csv(symp_sample_mat2, file="symp_sample_mat2.csv", row.names=FALSE)

set.seed(20)
str_time <- Sys.time()
symp_kms_500 <- kmeans(symp_sample_mat2, 500)
time_lapsed <- Sys.time() - str_time
head(symp_kms$cluster)

# Fitness of 78.3% with 500 "symptoms" clusters
symp_kms_500 <- symp_kms
sympclust <- as.factor(symp_kms_500$cluster)

# Subset "data_vax" to match samples from "symptoms"
dim(data_vax)
dim(symp_sample_mat) # 21,125 patients x 7933 symptoms

data_vax2 <- subset(data_vax, ID %in% symp_sample$ID) # Done!
write.csv(data_vax2, file="data_vax2.csv", row.names=FALSE)

# Merge "data/vaccine" sample dataset with sample "symptom" clusters
data_comb <- cbind(data_vax2, sympclust)
write.csv(data_comb, file="data_comb.csv", row.names=FALSE)

# Identified associated symptoms per cluster 
symp_kms_500$centers
write.csv(symp_kms_500$centers, file="centers.csv", row.names=FALSE)

# Identified cluster of symptoms per patient
sympclust


# Identify most common symptoms from "symp_sample_mat"
freq_symp <- read.csv("top_symptoms.csv", header=TRUE)
head(freq_symp)
colnames(freq_symp) <- c("Symptoms", "Frequency")

freq_symp_100 <- freq_symp[1:100,]
counts <- freq_symp_100$Frequency
b1 <- barplot(counts , main="Top100 Vaccine-associated Adverse Events", xlab="Symptoms", ylab="Count", col="darkgreen")

freq_symp_20 <- freq_symp[1:20,]
counts <- freq_symp_20$Frequency
symptoms <- freq_symp_20$Symptoms
barplot(counts , main="Top20", ylab="Count", col="darkgreen", names.arg=symptoms, las=2, cex.names=0.6, cex.lab=0.8)

# We use top100 symptoms (reported ~2000 times)
# Trim symp_sample_mat
symp_clean <- read.csv("symp_clean.csv", header=TRUE)
set.seed(123)
symp_sample <- symp_clean[sample(nrow(symp_clean), 22000),]
symp_sample_mat <- table(symp_sample$VAERS_ID, symp_sample$SYMPTOMS)
symp_sample_trans <- t(symp_sample_mat)

symp100 <- as.factor(freq_symp_100$Symptoms) # top100 symptoms vector
symp100_trans <- subset(symp_sample_trans, SYMPTOMS %in% symp100)


symp100_sample <- subset(symp_sample, SYMPTOMS %in% symp100)
dim(symp100_sample)

symp100_sample_mat <- table(symp_sample$VAERS_ID, symp_sample$SYMPTOMS) # 14,620 patients x 100 symptoms

uniqsympsamp <- unique(symp_sample$SYMPTOMS)
symp100_sample_mat <- table(symp100_sample$VAERS_ID, symp100_sample$SYMPTOMS)
symp100_sample_trans <- t(symp100_sample_mat)
symp100_trans <- subset(symp100_sample_trans, SYMPTOMS %in% symp100)

write.csv(symp_sample_mat, file="symp_sample_mat.csv", row.names=FALSE)
vector_patient <- as.factor(symp_sample$VAERS_ID)
colnames(symp_sample)[colnames(symp_sample)=="VAERS_ID"] <- "ID"
vector_patient <- as.factor(symp_sample$ID)


symp_sample_mat <- read.csv("symp_sample_mat.csv", header=TRUE)
colnames(symp_sample_mat)
symp_sample_trans <- t(symp_sample_mat)
symp100_trans <- subset(symp_sample, SYMPTOMS %in% symp100)
<- t(symp100_trans)
write.csv(data_vax2, file="data_vax2.csv", row.names=FALSE)
