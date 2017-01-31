# Exploratory data analysis of vaccines among 390,000 people

# libraries
library(reshape2)
library(dplyr)
library(stringi)
library(ggplot2)
library(stringr)
library(cluster)

# Distribution of most reported vaccines
## Load dataset
vax <- read.csv("vax.csv", header=TRUE)
vax2 <- vax[, c(2, 3)] # Only ID and Vaccine type

## Renaming process of vaccines
vax2$VAX_TYPE <- gsub(c("\\bTTOX\\b"), c("Tetanus Toxoid"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bMEA\\b"), c("Measles"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bVARZOS\\b"), c("Herpes"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bTBE\\b"), c("Tick-Borne Encephalitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bRAB\\b"), c("Rabies"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bSSEV\\b"), c("Seasonal Encephalitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bYF\\b"), c("Yellow Fever"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bTYP\\b"), c("Typhoid"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bPER\\b"), c("Pertussis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bCHOL\\b"), c("Cholera"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bBCG\\b"), c("Bacillus Calmette_Guerin"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bANTH\\b"), c("Anthrax"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bSMALL\\b"), c("Small Pox"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bRUB\\b"), c("Rubella"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bLYME\\b"), c("Lyme Disease"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bPLAGUE\\b"), c("Plague"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bJEVX\\b|\\bJEV1\\b|\\bJEV\\b"), c("Japanese Encephalitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bVARCEL\\b|\\bVAR\\b"), c("Varicella"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bRVX\\b|\\bRV1\\b|\\bRV5\\b|\\bRV\\b"), c("Rotavirus"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bADEN_4_7\\b|\\bADEN\\b"), c("Adenovirus"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bUNK\\b|\\bPPV\\b|\\bPNC\\b|\\bPNC13\\b"), c("Pneumonia"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\b6VAX-F\\b"), c("Polio virus"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bMMRV\\b|\\bMMR\\b|\\bMM\\b"), c("Measles Mumps Rubella"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bMUR\\b"), c("Mumps Rubella"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bMU\\b"), c("Mumps"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bMEN\\b|\\bMENB\\b|\\bMNQ\\b|\\bMNC\\b"), c("Meningicoccal meningitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bFLU3\\b|\\bFLUC3\\b|\\bFLUA3\\b|\\bFLUR3\\b|\\bFLU4\\b|\\bFLUN4\\b|\\bFLUN3\\b"), c("Seasonal Influenza"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bTD\\b|\\bTDAP\\b|\\bDTPH\\b|\\bDTAP\\b|\\bDT\\b|\\bDTP\\b|\\bIPV\\b|\\bTDAPIPV\\b|\\bOPV\\b"), c("Diphtheria Tetanus Pertussis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bHEP\\b|\\bHEPAB\\b|\\bHEPATYP\\b|\\bHEPA\\b"), c("Hepatitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bHPV2\\b|\\bHPV4\\b|\\bHPV9\\b|\\bHPVX\\b"), c("Human papillomavirus"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bDTAPV\\b|\\bDTaPIPV\\b|\\bDTaPIPVHib\\b|\\bDTAPHEPBIP\\b|\\bDTP1H1\\b|\\bDTOX\\b|\\bDPP\\b|\\bDTAPIPV\\b|\\bDTIPV\\b"), c("Polio Virus Combos"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bDTPIPV\\b"), c("Polio Virus Combos"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bHIBV\\b|\\bHBPV\\b|\\bHIBHEPB\\b|\\bDTPHIB\\b"), c("Haemophilus Influenza B"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bMENHIB\\b|\\bMNQHIB\\b"), c("Meningicoccal meningitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bDTPPHIB\\b|\\bDTAPIPVHIB\\b|\\bDTAPH\\b"), c("HIB Combos"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bDTPIHI\\b"), c("PV Combos"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bDTPHEP\\b"), c("Hepatitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bHBHEPB\\b"), c("Hepatitis"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\MER\\b"), c("Measles Rubella"), vax2$VAX_TYPE)

vax2$VAX_TYPE <- gsub(c("\\bH5N1\\b|\\bFLUX[:(H1N1):]\\b|\\bFLU[:(H1N1):]\\b|\\bFLUN[:(H1N1):]\\b"), c("Pandemic Influenza"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\b[:):]\\b"), c(" "), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("\\bPandemic InfluenzaH1N1 \\b"), c("Pandemic Influenza"), vax2$VAX_TYPE)
vax2$VAX_TYPE <- gsub(c("PV Combos"), c("Polio Virus Combos"), vax2$VAX_TYPE)

## Aggregation
vax_agg <- aggregate(VAERS_ID ~ VAX_TYPE, data=vax2, toString)
strpatient <- vax_agg$VAERS_ID
vax_agg$PATCOUNT <- stri_count(strpatient, fixed=',') + 1
vax_agg2 <- vax_agg[, c(1, 3)] # Only Vaccine type and Nb Patients
vax_order <- vax_agg2[order(vax_agg2[,2],decreasing=TRUE),]

labs <- paste(vax_order$VAX_TYPE)
b <- barplot(vax_order$PATCOUNT, col="red",
             main = "Number of patient(s) per immunization type", 
             ylab="Number of Patients",
             #xlab="",
             cex.axis=0.65, 
             las=2,
             xaxt="n")
text(cex=0.55, x=b+0.5, y=-2000, labs, xpd=TRUE, srt=45, pos=2, cex.names=0.4, cex.lab=0.4)

labs <- paste(vax_order$VAX_TYPE)
b <- barplot(vax_order$PATCOUNT, col="red",
             main = "Number of patient(s) per immunization type", 
             xlab="Number of Patients",
             ylab="",
             cex.axis=0.65, 
             las=2,
             yaxt="n",
             horiz=TRUE)
text(cex=0.55, y=b+0.1, x=-200, labs, xpd=TRUE, srt=-50, pos=2, cex.names=0.4, cex.lab=0.4)

# Correlation between features from ~300,000 patients
Data <- read.csv("Data_303429.csv", header=TRUE)
head(Data)
colnames(Data)
Data_sub <- Data[, -c(1:3, 43:74)] # 40 features left

library(corrplot)
Data_cor <- cor(Data_sub)
head(round(Data_cor,2))
corrplot(Data_cor, method="color", tl.col = "black", tl.cex=0.6, cl.ratio=0.4)
pdf("Correlogram.pdf", heigth=10, width=10)

# Heatmap with individual symptom
Data2 <- read.csv("Data_390654.csv", header=TRUE)
head(Data2)
colnames(Data2)
Data2_sub <- Data2[, -c(1, 43:74)] 

symp_clean <- read.csv("symp_clean.csv", header=TRUE)
symp_clean$SYMPTOMS <- tolower(symp_clean$SYMPTOMS)
symp_clean$SYMPTOMS <- gsub(c("injection site |back |neck |chest |face |tongue"), c(""), symp_clean$SYMPTOMS)                 
symp_clean <- subset(symp_clean, SYMPTOMS!="no adverse event")
symp_clean <- subset(symp_clean, SYMPTOMS!="unevaluable event")
symp_clean <- subset(symp_clean, SYMPTOMS!="drug ineffective")
colnames(symp_clean) <- c("id", "SYMPTOMS")
Data3 <- merge(symp_clean, Data2_sub, by.y="id")

Data4 <- merge(pat_order, Data3, by.y="SYMPTOMS")
Data4 <- Data4[order(Data4[,2],decreasing=TRUE),]
Data4$class <- NULL

Data_kms <- read.csv("Data_11symp_5cl.csv", header=TRUE)
Data_kms$id <- Data_kms$ID
Data_303429 <- read.csv("Data_303429.csv", header=TRUE)
Data_kms2 <- merge(Data_kms, Data4, by.y="id") # reduce number of patients
Data_kms2 <- Data_kms2[,-c(76:148)]
Data_km2 <- Data_kms[, c("id", "SYMPTOMS", "Class", "PATCOUNT")]


Data_5 <- merge(Data4, Data_km2, by.y="id")
#Data_5$class <- NULL
Data_5 <- Data_5[order(Data_5[,4],decreasing=TRUE),]
head(Data_5)
dim(Data_5) #1,197,895 cases
Data_5 <- na.omit(Data_5)
dim(Data_5) #1,267,835 cases

Data_6 <- Data_5[, c(1:3, 44)]
dim(Data_6)
symptop <- unique(Data_6$SYMPTOMS) # 7867 adverse events as many PATCOUNT
class <- unique(Data_6$Class) # 5 classes
id <- unique(Data_6$id) # 321539 patients



#Datacast <- acast(Data_6, symptop ~ )
Data_melt <- melt(Data_5, id=c("Class", "SYMPTOMS"))
write.csv(Data_melt, file="Melt_class vs adverse events.csv", row.names=FALSE) # renamed pat_agg > pat_agg_cleaned

symptop <- unique(Data_melt$SYMPTOMS)
table(as.character(interaction(Data_melt$Class, symptop[1:11], sep=":")))

i=0
for(i in c(1:5)){
  list <- subset(x, Class == i & SYMPTOMS == "pain")$freq
  i = i + 1
}

Data_melt$pair <- with(Data_melt, interaction(interaction(Data_melt$Class, symptop[1:11], sep=":"))
rowSums(xtabs(~ value + pair, Data_melt) > 0)
