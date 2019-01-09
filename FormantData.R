#Data processing
formant=read.csv(choose.files())
View(formant)
#Subset the data we need
formant=subset(formant,select=c("filename","word","vowel","freq_f1","freq_f2","vwl_duration","timepoint","point_time","point_vwlpct"))
View(formant)
#class(formant)
#View(formant)
#Sort out xxx and word
formant.sort=formant[order(formant$word),]
#View(formant.sort)
#class(formant.sort)
#summary(formant.sort)
#Exclude all the "xxx"
formant.sort["formantID"]=NA
formant.sort$formantID=1:1460
#View(formant.sort)
formant.data=subset(formant.sort,formantID==1:720)
#View(formant.data)
summary(formant.data)
#Extract coda from vowel
coda=substr(formant.data$vowel,2,2)
#View(coda)
#Make a new column with coda
formant.data["coda"]=NA
formant.data$coda=coda
#View(formant.data)
#Extract Vowel from vowel 
vowel=substr(formant.data$vowel,1,1)
#View(vowel)
#Make a new column for Vowel
formant.data["Vowel"]=NA
formant.data$Vowel=vowel
#View(formant.data)
#Exclude the column vowel
formant.data=subset(formant.data,select=-vowel)
View(formant.data)
#Add a new column "formant"
formant.data["formant"]=NA
formant.data$formant="f1"
#Add a new column "frequency"
formant.data["frequency"]=NA
formant.data$frequency=formant.data$freq_f1
#View(formant.data)
#Form a data frame with f1 only
formant.data.f1=subset(formant.data,select=-c(freq_f1,freq_f2))
#View(formant.data.f1)
#Form a data frame with f2 only
#View(formant.data)
formant.data$formant="f2"
formant.data$frequency=formant.data$freq_f2
formant.data.f2=subset(formant.data,select=-c(freq_f1,freq_f2))
#View(formant.data.f2)
#rbind formant.data.f1 and formant.data.f2
formant.new=rbind(formant.data.f1,formant.data.f2)
View(formant.new)
#replace names

#write.csv(formant.new,file="new formant data.csv",row.names=FALSE)
#data visualization
library(tidyverse)
#install.packages("Hmisc")
library(Hmisc)
formant.plot=ggplot(data=formant.new,aes(x=timepoint,y=frequency,colour=coda,lty=formant))
#formant with error bar in three codas
formant.plot+
  stat_summary(fun.y=mean,
               geom="point")+
  stat_summary(fun.y=mean,
               geom="line")+
  stat_summary(fun.data=mean_cl_normal,
               geom="errorbar",
               width=.2)+
  ylab("frequency")+
  xlab("Time")+
  theme_bw(base_size=20)+
  facet_wrap(filename~Vowel)
#formant.plot with error bar in separate words
formant.plot+
  stat_summary(fun.y=mean,
               geom="point")+
  stat_summary(fun.y=mean,
               geom="line")+
  stat_summary(fun.data=mean_cl_normal,
               geom="errorbar",
               width=.2)+
  ylab("frequency")+
  xlab("Time")+
  theme_bw(base_size=20)+
  facet_wrap(filename~word)
#formant.plot with smoothing only
formant.plot2<-ggplot(data = formant.new, aes(x = timepoint, y = frequency,colour=coda,lty=formant)) +
  geom_smooth(method="loess", se=F)+
  ylab("frequency")+
  xlab("Time")+
  theme_bw(base_size=20)+
  facet_wrap(filename~Vowel)
formant.plot2

#prediction
#predict=read.csv(choose.files())
#View(predict)
#class(predict)
#prediction+geom_bar(stat="identity",aes(fill=vowel),position="dodge")
  









  
