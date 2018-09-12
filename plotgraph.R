### 보험청구 건수 분석 ###
par(mfrow=c(1,1)) # 1행 1열로 그래프 배치하기
setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
data = read.csv("연도별요양기관별보험청구건수_2001_2013_세로.csv",header=T)

plot(data$상급종합병원*0.00001,ylab="",xlab="",ylim=c(0,6000),main=paste("연도별 요양 기관별 보험 청구 건수(단위:십만건)\n출처 : 건강보험심사평가원"),axes=F,type="o",lwd=2)
color=c("black","red","orange","yellow","green","blue","purple","cyan","pink","brown")

for(a in 3:length(data)){
par(new=T) #겹쳐서 그리기
lines(data[,a]*0.00001,type="o",lwd=2,col=color[a-1]) #lines()를 사용해야 y축 값이 계속 변하지않음
}

axis(1,at=1:10,labels=data$년도,las=2)
axis(2,las=2)
name<-names(data[0,2:11])   #names()를 써야 문자열값이 나옴
name

legend(1,6200,name,cex=0.55,fill=color,bg="white")
