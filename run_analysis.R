#original zip file was downloaded and extracted to a folder;make sure set to correct working directory#
#read necessary 6 data files and feature file to R console#
subtest<-read.table("subject_test.txt");subtrain<-read.table("subject_train.txt")
xtest<-read.table("x_test.txt");xtrain<-read.table("x_train.txt")
ytest<-read.table("y_test.txt");ytrain<-read.table("y_train.txt")
feature<-read.table("features.txt")

#replace () symbol with "paren" wording to avoid unnecessary confusion in R #
f<-feature$V2
feature$V2<-gsub("()","paren",f,fixed=T)
listofnames<-as.character(feature[,2])
listofnames<-make.names(listofnames,unique=T)

#combine 6 dataset to get a rawmerge file;check dimension for each file first#
test<-cbind(subtest,ytest,xtest)
train<-cbind(subtrain,ytrain,xtrain)
rawmerge<-rbind(test,train)

#rename the measurement columns with feature values#
colnames(rawmerge)<-c("subject","activity",listofnames)

#extract columns containing mean() and std() measurement#
e1<-rawmerge[,grep("meanparen",colnames(rawmerge))]
e2<-rawmerge[,grep("stdparen",colnames(rawmerge))]
#extract the first two columns with subject and activity#
#combine to create a new data set
e3<-rawmerge[,1:2] 
tidydata<-cbind(e3,e1,e2)

#check dimemsion of extracted data#
dim(tidydata) 

#rename activity column value;replace 1to6 with descriptive names#
tidydata$activity<-replace(tidydata$activity,tidydata$activity==1,"walking")
tidydata$activity<-replace(tidydata$activity,tidydata$activity==2,"walkingupstairs")
tidydata$activity<-replace(tidydata$activity,tidydata$activity==3,"walkingdownstairs")
tidydata$activity<-replace(tidydata$activity,tidydata$activity==4,"sitting")
tidydata$activity<-replace(tidydata$activity,tidydata$activity==5,"standing")
tidydata$activity<-replace(tidydata$activity,tidydata$activity==6,"laying")

#change variable names to be more descriptive#
colnames(tidydata)[3:68]<-gsub("paren","",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("Gravity","Gravi",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("t","time",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("f","freq",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("Acc","Accelerated",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("Mag","Magnitude",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("BodyBody","Body",colnames(tidydata)[3:68],fixed=T)
colnames(tidydata)[3:68]<-gsub("stimed","std",colnames(tidydata)[3:68],fixed=T)

#create a new data set by averaging each variable for each subject and activity#
library(dplyr)
finaldata<-tidydata %>% group_by(subject,activity) %>% summarise_each(funs(mean))
#check dimension of final data set
dim(finaldata)

#create a txt file containing final tidy data set in the working directory#
write.table(finaldata,file="JH-finaldata",row.names=F)
