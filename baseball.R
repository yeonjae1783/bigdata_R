### 프로야구 선수 분석 ###

setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
data=read.csv("야구성적.csv",header = T)
d=data[1:24,21]
name=data$선수명
name
#barplot(t(as.matrix(data[1:25,21])),main=paste("야구 선수별 연봉 대비 출루율 분석"),col=rainbow(25),ylab="연봉대비 출루율",xlim=c(0,26))
#axis(1,at=1:25,labels=name,las=3)
bp<-barplot(data$연봉대비출루율,main=paste("야구 선수별 연봉 대비 출루율 분석"),col=rainbow(25),las=2,names.arg=data$선수명,ylim=c(0,50))
avg <- 0
for ( i in 1:length(data$연봉대비출루율)){
  avg<- avg+data$연봉대비출루율[i]
}
avg
length(data$연봉대비출루율)
avg<-avg/length(data$연봉대비출루율)
avg
abline(h=avg,col="black")
text(1,18
     ,paste("평균 : \n",avg))
text(bp*1.02,y=data$연봉대비출루율*1.07,col="black",cex=0.7,labels=paste(data$연봉대비출루율,"%"))