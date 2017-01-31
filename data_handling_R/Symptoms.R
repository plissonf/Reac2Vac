# Rearrange "symptoms" dataset symp so that every patient (unique ID number) 
# has a list with one or more symptoms

# Libraries
library(reshape2)
library(dplyr)
library(stringi)
library(ggplot2)
library(stringr)
library(cluster)

# Import previously created dataset "symp" and use VAERS_ID as indexes;
symp <- read.csv("symp.csv", header=TRUE)
symp$X <- NULL

symp_melt <- melt(symp, id.vars = unique("VAERS_ID")) #{reshape2}
symp_melt$variable <- NULL
names(symp_melt)[names(symp_melt)=="value"] <- "SYMPTOMS"
str(symp_melt)
symp_df <- as.data.frame.matrix(symp_melt)
write.csv(symp_df, file="symp_df.csv")
UniqSymp <- unique(symp_df$SYMPTOMS) # 7,934 unique symptoms
symp_df <- read.csv("symp_df.csv", header=TRUE, na.strings=c("", " ")) # replace blank by NA values
symp_df <- colnames("ID", "VAERS_ID", "SYMPTOMS")

# Cleaning dataset to obtain only two columns with patients IDs and corresponding symptoms
symp_df$X <- NULL # Remove extra indexes
symp_clean <- na.omit(symp_df) # Removing all "patient-symptoms" with blank information
symp_clean <- colnames("ID", "VAERS_ID", "SYMPTOMS")
write.csv(symp_clean, file="symp_clean.csv", row.names=FALSE) # remove row indices and write file

# Group all symptoms from same patient ID into a string;
str_time <- Sys.time()
symp_agg <- aggregate(SYMPTOMS ~ VAERS_ID, data=symp_clean, toString)
write.csv(symp_agg, file="symp_agg.csv", row.names=FALSE)
time_lapsed_agg <- Sys.time() - str_time #55.52 mins

## Count number of symptoms (words) in each patient string {stringi}
strsymp <- symp_agg$SYMPTOMS
symp_agg$SYMPCOUNT <- stri_count(strsymp, fixed=',') + 1
write.csv(symp_agg, file="symp_agg2.csv", row.names=FALSE)

# Group all patients with the same symptom into a dataset "pat_agg";
str_time <- Sys.time()
pat_agg <- aggregate(VAERS_ID ~ SYMPTOMS, data=symp_clean, toString)
time_lapsed_agg2 <- Sys.time() - str_time # 9.32 secs

## Count number of symptoms (words) in each patient string {stringi}
strpatient <- pat_agg$VAERS_ID
pat_agg$PATCOUNT <- stri_count(strpatient, fixed=',') + 1
pat_agg <- order()
head(pat_agg)
write.csv(pat_agg, file="pat_agg.csv", row.names=FALSE)

# Distribution Frequency of Adverse Events (PATCOUNT)
pat_agg <- read.csv("pat_agg.csv", header=TRUE)
pat_agg2 <- pat_agg[, c(1, 3)] # removing patient ID
pat_order <- pat_agg2[order(pat_agg2[,2],decreasing=TRUE),]
pat_top <- pat_order[1:55,]

## All 7933 symptoms
barplot(pat_order$PATCOUNT, main = "Number of patient(s) per adverse event", ylab="Number of Patients", cex.axis=0.9)

## Top 20
labs <- paste(pat_top$SYMPTOMS)
b <- barplot(pat_top$PATCOUNT, col="blue",
        main = "Number of patient(s) per adverse event (top 55)", 
        ylab="Number of Patients",
        #xlab="",
        cex.axis=0.65, 
        las=2,
        xaxt="n")
text(cex=0.55, x=b+0.5, y=-2500, labs, xpd=TRUE, srt=45, pos=2, cex.names=0.4, cex.lab=0.4)

# Only "real" reported adverse events
symp_clean <- read.csv("symp_clean.csv", header=TRUE)
symp_clean$SYMPTOMS <- tolower(symp_clean$SYMPTOMS) # lowercase SYMPTOMS
# replace "injection site ", "chest", "neck",...  with ""
symp_clean$SYMPTOMS <- gsub(c("injection site |back |neck |chest |face |tongue"), c(""), symp_clean$SYMPTOMS)
# remove row with "No adverse event", "Drug ineffective"...
toremove = c("no adverse event |unevaluable event |drug ineffective")
symp_new <- subset(symp_clean, SYMPTOMS!="no adverse event")
symp_new <- subset(symp_new, SYMPTOMS!="unevaluable event")
symp_new <- subset(symp_new, SYMPTOMS!="drug ineffective")
# re-aggregate to pat_agg 
pat_agg <- aggregate(VAERS_ID ~ SYMPTOMS, data=symp_new, toString)
# replot pat_order and pat_top
strpatient <- pat_agg$VAERS_ID
d <- stri_count(strpatient, fixed=',') + 1
write.csv(pat_agg, file="pat_agg_cleaned.csv", row.names=FALSE) # renamed pat_agg > pat_agg_cleaned

#pat_agg <- order()
pat_agg2 <- pat_agg_cleaned[, c(1, 3)] # removing patient ID
pat_order <- pat_agg2[order(pat_agg2[,2],decreasing=TRUE),]
pat_top <- pat_order[1:20,]


# Group all patients with the same symptom into a dataset "pat_agg";
str_time <- Sys.time()
pat_agg <- aggregate(VAERS_ID ~ SYMPTOMS, data=symp_clean, toString)
time_lapsed_agg2 <- Sys.time() - str_time # 9.32 secs

## Count number of symptoms (words) in each patient string {stringi}
strpatient <- pat_agg$VAERS_ID
pat_agg$PATCOUNT <- stri_count(strpatient, fixed=',') + 1
pat_agg <- order()
head(pat_agg)

# Binary classification: Adverse event reported vs. Not an adverse event
symp_agg <- read.csv("symp_agg.csv", header=TRUE)

## Test
test <- symp_agg[1:500,]
strsymp <- test$SYMPTOMS

test$CLASS <- ifelse(grepl("Injection site pain|Agitation", strsymp), "1", "0")
strsymp[41]
strsymp[42]

## Whole dataset
toMatch <- c("No adverse event|Unevaluable event|Drug ineffective")
strsymp <- symp_agg$SYMPTOMS
symp_agg$CLASS <- ifelse(grepl(toMatch, strsymp), "0", "1")
strsymp[1] # "1" should not contain the words in toMatch
strsymp[23] # "0" should contain at least one of them
table(symp_agg$CLASS) # 51,737 patients have no adverse reactions (~11.6%) and 390,654 showed some adverse reaction



# Dataset with 390,654 patients showing adverse reactions
symp_agg_sub <- symp_agg[symp_agg$CLASS== 1,]
dim(symp_agg_sub)

## Distribution Number of symptoms identified per patient (SYMPCOUNT)
ggplot(symp_agg_sub, aes(x=SYMPCOUNT)) + geom_histogram(binwidth=1, colour="black", fill="blue") + theme_bw() + xlab("Number of Adverse Events") + ylab("Frequency") + ggtitle("Number of Adverse Events / Patient") + scale_x_continuous(breaks= c(10, 50, 100, 150, 168))
pdf("Number of Symptoms per Patient.pdf")



## Remove columns SYMPCOUNT & CLASS
symp_agg_sub$SYMPCOUNT <- NULL
symp_agg_sub$CLASS <- NULL

# Simplifying the symptoms list
## Lowercase every "adverse event" term
symp_agg_sub$SYMPTOMS <- tolower(symp_agg_sub$SYMPTOMS)

## The terms "injection site", "back", "chest"... appear for some patients and not others. This is one level too specific.
## Replace such "body location" by nothing
temp <- symp_agg_sub[1:500,]
temp$SYMPTOMS <- gsub(c("injection site |back |neck |chest "), c(""), temp$SYMPTOMS)

symp_agg_sub$SYMPTOMS <- gsub(c("injection site |back |neck |chest |face |tongue"), c(""), symp_agg_sub$SYMPTOMS)
dim(symp_agg_sub)
write.csv(symp_agg_sub, file="symp_agg_sub.csv", row.names=FALSE)


## Create Document Term Matrix for K-means clustering
library(NLP)
library(slam)
library(tm)
library(cluster)

#temp <- symp_agg_sub[1:500,]
#temp$SYMPTOMS <- gsub("([a-z])([a-z])", "\\1_\\2", temp$SYMPTOMS) # 
#temp$SYMPTOMS <- gsub("(\\w)(\\s)(\\w)", "\\1-\\3", temp$SYMPTOMS)

## Apply hyphen to all combination of words e.g. myasthenic syndrome as myasthenic-syndrome
symp_agg_sub$SYMPTOMS <- gsub("(\\w)(\\s)(\\w)", "\\1-\\3", symp_agg_sub$SYMPTOMS)

## Remove all commas between words
symp_agg_sub$SYMPTOMS <- gsub(",", "", symp_agg_sub$SYMPTOMS) 

# Make corpus and document term matrix
myCorpus <- symp_agg_sub
corpus <- Corpus(VectorSource(myCorpus$SYMPTOMS))
dtm <- DocumentTermMatrix(corpus)
dtm # ~matrix 390654 (patients ID) x 7814 (symptoms)
findFreqTerms(dtm, 10) #Symptoms were reduced from 7,933 to 7,814
dtm_matrix <- as.matrix(dtm)
write.csv(dtm_matrix, file="dtm_matrix.csv", row.names=FALSE)

dtm <- removeSparseTerms(dtm, 0.999) #372 adverse events
dtm_matrix <- as.matrix(dtm)
dim(dtm_matrix)
m = 390654
n = 372
t = 144078062 # table(dtm_matrix==0)
k = (m*n)/t

k = 1 


dtm2 <- removeSparseTerms(dtm, 0.99) # 55 adverse events
dtm2_matrix <- as.matrix(dtm2)
write.csv(dtm2_matrix, file="dtm2_matrix.csv", row.names=FALSE)

set.seed(20)
str_time <- Sys.time()
symp_dtm_kms <- kmeans(dtm2_matrix, 20)
time_lapsed <- Sys.time() - str_time
head(symp_dtm_kms$cluster)

dtm3 <- removeSparseTerms(dtm, 0.95) # 11 adverse events
dtm3_matrix <- as.matrix(dtm3)
write.csv(dtm3_matrix, file="dtm3_matrix.csv", row.names=FALSE)

dtm4 <- removeSparseTerms(dtm, 0.9995) # 588 adverse events
dtm4_matrix <- as.matrix(dtm4)
write.csv(dtm4_matrix, file="dtm4_matrix.csv", row.names=FALSE)



# Measure k using m*n/t (m= rows, n=columns, t=zero elements)
dim(dtm2_matrix)
m = 390654
n = 55
t = 20622893 # table(dtm2_matrix==0)
k = (m*n)/t

k = 1 

mydata <- dtm_matrix
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in c(1:25)){
  wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}
k <- 1:25
df = data.frame(k, wss) 
p <- ggplot(df, aes(k,wss)) + geom_point(colour="blue") + geom_line(aes(x=k, y=wss, colour = "372 (0.999 sparsity)")) + theme_bw() + ggtitle("Search for k in k-means clustering") + xlab("Number of clusters k") + ylab("Within groups sum of squares") + scale_colour_manual(name="Nb. Adverse events", values=c("372 (0.999 sparsity)"="blue"))


mydata <- dtm2_matrix
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in c(1:25)){
  wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}
k <- 1:25
df = data.frame(k, wss) 
p2 <- ggplot(df, aes(k,wss)) + geom_point(colour="red") + geom_line(aes(x=k, y=wss, colour = "55 (0.99 sparsity)")) + theme_bw() + ggtitle("Search for k in k-means clustering") + xlab("Number of clusters k") + ylab("Within groups sum of squares") + scale_colour_manual(name="Nb. Adverse events", values=c("55 (0.99 sparsity)"="red", myline2="blue", myline3="purple"))



mydata <- dtm3_matrix
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in c(1:25)){
  wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}
k <- 1:25
df = data.frame(k, wss) 
p3 <- ggplot(df, aes(k,wss)) + geom_point(colour="green") + geom_line(aes(x=k, y=wss, colour = "11 (0.95 sparsity)")) + theme_bw() + ggtitle("Search for k in k-means clustering") + xlab("Number of clusters k") + ylab("Within groups sum of squares") + scale_colour_manual(name="Nb. Adverse events", values=c("11 (0.95 sparsity)"="green"))

mydata <- dtm4_matrix
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in c(1:25)){
  wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}
k <- 1:25
df = data.frame(k, wss) 
p4 <- ggplot(df, aes(k,wss)) + geom_point(colour="purple") + geom_line(aes(x=k, y=wss, colour = "588 (0.9995 sparsity)")) + theme_bw() + ggtitle("Search for k in k-means clustering") + xlab("Number of clusters k") + ylab("Within groups sum of squares") + scale_colour_manual(name="Nb. Adverse events", values=c("588 (0.9995 sparsity)"="purple"))

require(gridExtra)
grid.arrange(p3, p2, p, p4, nrow=2, ncol=2)
# Applying the "Elbow" approach, the reduction in cost appear at k=5 and k=12

# Term Document Matrix
tdm <- TermDocumentMatrix(corpus)
tdm # ~matrix 390654 (patients ID) x 7814 (symptoms)
findFreqTerms(tdm, 20) #Symptoms were reduced from 7,933 to 7,814
tdm_matrix <- as.matrix(tdm)
write.csv(tdm_matrix, file="tdm_matrix.csv", row.names=FALSE)

# First tdm
tdm2 <- removeSparseTerms(tdm, 0.99) # 55 "symptoms" terms
tdm2_matrix <- as.matrix(tdm2)
write.csv(tdm2_matrix, file="tdm2_matrix.csv", row.names=FALSE)

mydata <- tdm2_matrix
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in c(1:25)){
  wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}
k <- 1:25
df = data.frame(k, wss) 
p5 <- ggplot(df, aes(k,wss)) + geom_point(colour="orange") + geom_line(aes(x=k, y=wss, colour = "55 (0.96 sparsity)")) + theme_bw() + ggtitle("Search for k in k-means clustering") + xlab("Number of clusters k") + ylab("Within groups sum of squares") + scale_colour_manual(name="Nb. Adverse events", values=c("55 (0.96 sparsity)"="orange"))

set.seed(20)
symp_tdm_kms <- kmeans(tdm2_matrix, 10)
symp_tdm_kms$size

#Second tdm
tdm3 <- removeSparseTerms(tdm, 0.995) # 114 "symptoms" terms 98%
tdm3_matrix <- as.matrix(tdm3)
write.csv(tdm3_matrix, file="tdm3_matrix.csv", row.names=FALSE)

mydata <- tdm3_matrix
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in c(1:25)){
  wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}
k <- 1:25
df = data.frame(k, wss) 
p6 <- ggplot(df, aes(k,wss)) + geom_point(colour="blue") + geom_line(aes(x=k, y=wss, colour = "114 (0.98 sparsity)")) + theme_bw() + ggtitle("Search for k in k-means clustering") + xlab("Number of clusters k") + ylab("Within groups sum of squares") + scale_colour_manual(name="Nb. Adverse events", values=c("114 (0.98 sparsity)"="blue"))

set.seed(20)
symp_tdm3_kms <- kmeans(tdm3_matrix, 12)
symp_tdm3_kms$size

# Identifying at k=5,12 the most balanced clusters based on number of adverse events (11, 55, 372, 588, 7814)
dtm3_matrix <- read.csv("dtm3_matrix.csv", header=TRUE)
set.seed(20)
kms_11_5 <- kmeans(dtm3_matrix, 5)
head(kms_11_5$size) 

# Create K-means Clustering plot
library(fpc)
plotcluster(dtm3_matrix, kms_11_5$cluster)

library(cluster) 
clusplot(dtm3_matrix, kms_11_5$cluster, color=c("blue", "red", "green"), shade=FALSE, labels=5, lines=1)

library(factoextra)
fviz_cluster(kms_11_5, data = dtm3_matrix, frame=TRUE, title = "Cluster plot", frame.alpha = 0.5)

library(HSAUR)
library(tools)
dissE <- daisy(dtm3_matrix) 
dE2   <- dissE^2
sk2   <- silhouette(kms_11_5$cl, dE2)
plot(sk2)


set.seed(20)
kms_11_12 <- kmeans(dtm3_matrix, 12)
head(kms_11_12$size) 

set.seed(20)
kms_55_5 <- kmeans(dtm2_matrix, 5)
head(kms_55_5$size) 

set.seed(20)
kms_55_12 <- kmeans(dtm2_matrix, 12)
head(kms_55_12$size) 

set.seed(20)
kms_372_5 <- kmeans(dtm_matrix, 5)
head(kms_372_5$size)

set.seed(20)
kms_372_12 <- kmeans(dtm_matrix, 12)
head(kms_372_12$size) 

set.seed(20)
kms_588_5 <- kmeans(dtm4_matrix, 5)
sd(kms_588_5$size)

# Plot k-means clustering from 55 symptoms / 12 clusters DTM {cluster}
kms_55_12 <- kmeans(dtm2_matrix, 12)
clusplot(dtm2_matrix, kms_55_12$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

# Plot k-means clustering from 114 symptoms / 12 clusters TDM {cluster}
kms_114_12 <- kmeans(tdm3_matrix, 12)
clusplot(tdm3_matrix, kms_114_12$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

# Create 3 classifiers and bind them to data_vax dataset
## Classifier 1: 55 symptoms / 12 clusters (390,654 patients)
kms_55_12$cluster
sympclust_55.df <- as.data.frame(kms_55_12$cluster)
sympclust_55.df$ID <- symp_agg_sub$VAERS_ID
write.csv(sympclust_55.df, file="sympclust_55.csv", row.names=FALSE)

## Classifier 2: 372 symptoms / 15 clusters (390,654 patients)
kms_372_15$cluster
sympclust_372.df <- as.data.frame(kms_372_15$cluster)
sympclust_372.df$ID <- symp_agg_sub$VAERS_ID
write.csv(sympclust_372.df, file="sympclust_372.csv", row.names=FALSE)

## Classifier 3: 11 symptoms / 5 clusters (390,654 patients)
kms_11_5$cluster
sympclust_11.df <- as.data.frame(kms_11_5$cluster)
sympclust_11.df$ID <- symp_agg_sub$VAERS_ID
write.csv(sympclust_11.df, file="sympclust_11.csv", row.names=FALSE)

## Attach the other dataset data_vax_clean by VAERS_ID
data_vax_clean <- read.csv("data_vax_clean.csv", header=TRUE)
head(data_vax_clean)

## data_vax_clean extra cleaning
data_vax_clean$DIED[is.na(data_vax_clean$DIED)] <- 0 # replace NA with zero values

data_vax_clean <- read.csv("VaxPersoData.csv", header=TRUE)
  
## Merge
Data11 <- merge(data_vax_clean, sympclust_11.df, by="ID")
Data11$Class <- Data11$kms_11_5.cluster
Data11$kms_11_5.cluster <- NULL
write.csv(Data11, file="Data_11symp_5cl.csv", row.names=FALSE)

Data55 <- merge(data_vax_clean, sympclust_55.df, by="ID")
Data55$Class <- Data55$kms_55_12.cluster
Data55$kms_55_12.cluster <- NULL
write.csv(Data55, file="Data_55symp_12cl.csv", row.names=FALSE)

Data372 <- merge(data_vax_clean, sympclust_372.df, by="ID")
Data372$Class <- Data372$kms_372_15.cluster
Data372$kms_372_15.cluster <- NULL
write.csv(Data372, file="Data_372symp_15cl.csv", row.names=FALSE)

symp_agg$ID <- symp_agg$VAERS_ID
Data2 <- merge(symp_agg, data_vax_clean, by.y="ID")
Data2$SYMPTOMS <- NULL
Data2$SYMPCOUNT <- NULL
write.csv(Data2, file="Data_2cl.csv", row.names=FALSE)
