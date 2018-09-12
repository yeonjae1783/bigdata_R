setwd('C:/Users/yeonjae/Desktop/R라뷰/data')

data1 <- read.csv("2013년_서울_주요구별_병원현황.csv",header=T)
data1
par(mfrow=c(1,1))

barplot(as.matrix(data1[1:9,2:11]),
        main=paste("서울시 주요 구별 과목별 병원현황 - 2013년","\n"),ylab="병원수",
        beside=T,col=rainbow(8),ylim=c(0,350))
abline(h=seq(0,350,10),lty=3,lwd=0.2)
name<-data1$표시과목
name
legend(75,350,name,cex=0.8,fill=rainbow(8),bg="white")

par(mfrow=c(2,5))
place <- c("강남구",	"강동구"	,"강서구",	"관악구",	"구로구",	"도봉구",	"동대문구",		"동작구",		"마포구	",	"서대문구"
)
place[1]
for(i in 2:length(data1)){
barplot(as.matrix(data1[1:9,i]*0.1),
        main=paste(place[i-1],"병원현황","\n"),ylab="병원수(단위 : 10개 )",beside=T,col=rainbow(8),ylim=c(0,40))
}

