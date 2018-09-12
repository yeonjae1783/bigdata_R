### speech graph ###
setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
library(KoNLP)
useSejongDic()
txt <- readLines("noh.txt")
txt <- sapply(txt,extractNoun,USE.NAMES = F)

txt<-unlist(txt)
txt<-txt[nchar(txt)>=2]

txt <- gsub("저","",txt)
txt <- gsub("한","",txt)
txt <- gsub("여러분","",txt)
txt <- gsub(" ","",txt)
txt <- gsub("대","",txt)
txt <- gsub("시","",txt)
txt <- gsub("통령","",txt)
txt <- gsub("작","",txt)

head(unlist(txt),20)
write(unlist(txt),"speech_noh2.txt")
noh2 <- read.table("speech_noh2.txt")
wordcount <- table(noh2)

#pie 그래프 표현
top <- head(sort(wordcount,decreasing = T),10)
top
pie(top)
pie(top,col=rainbow(10),radius = 1) # 무지개 색으로 표현

#수치와 함께 pie 그래프
pct <- round(top/sum(top)*100,1) #수치값
lab <- paste(names(top),"\n",pct,"%")
pie(top,main="서울시 가볼만한 명소 ",col=rainbow(10),cex=0.8,labels=lab)


#도넛 모양 만들기
pie(top,main="서울시 가볼만한 명소 ",col=rainbow(10),cex=0.8,labels=lab)
par(new=T)
pie(top,radius=0.6,main="서울시 가볼만한 명소 ",col="white",labels=NA,border=NA)


#3D pie 그래프 
#install.packages("plotrix")
library(plotrix)
th_pct <- round(top/sum(top)*100,1)
th_name <- names(top)
th_label <- paste(th_name,th_pct,"%\n")
pie3D(top,main="서울의 가볼만한 명소 ",col=rainbow(10),cex=0.5,labels=th_label,explode=0.05)


#bar형태 그래프
bplot <- barplot(top,main="서울의 가볼만한 명소",col=rainbow(10),cex.names=0.7,las=2,ylim=c(0,30))

#수치 표현하는 barplot
b_pct <- round(top/sum(top)*100,1)
text(x=bplot,y=top*1.1,labels = paste("(",pct,"%",")"),col="black",cex=0.7)
text(x=bplot,y=top*0.9,labels = paste("(",top,"건",")"),col="black",cex=0.7)

bplot <- barplot(top,main="서울의 가볼만한 명소",col=rainbow(10),cex.names=0.7,las=1,xlim=c(0,30),horiz=T)
text(x=top*1.2,y=bplot,labels = paste("(",pct,"%",")"),col="black",cex=0.7)
text(x=top*0.8,y=bplot,labels = paste("(",top,"건",")"),col="black",cex=0.7)
