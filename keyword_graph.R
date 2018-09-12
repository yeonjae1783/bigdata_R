### 특정 키워드 그래프로 분석 ###

setwd('C:/Users/yeonjae/Desktop/R라뷰/data')
txt <- readLines('oracle_alert_testdb.log')

keyword1 <- grep("^ORA-+",txt,value=T)
keyword2 <- substr(keyword1,5,9)
head(sort(keyword2,decreasing=T),20)

#영문 제거
keyword3 <- gsub("[A-Z]","",keyword2)
keyword3 <- gsub("[a-z]","",keyword2)

head(unlist(keyword3),20)

write(unlist(keyword3),"keyword3.txt")
keyword4 <- read.table("keyword3.txt")
#keyword4

wordcount <- table(keyword4)
top10 <- head(sort(wordcount,decreasing=T),10)
#bar plot 
bplot <- barplot(top10,main="많이 발생한 오류 ",col=rainbow(10),cex.name=1,las=2,ylim=c(0,4000))

#dev.new()
#수치값( 발생 횟수 )
text(x=bplot,y=top10*1.07,labels=paste(top10,"건"),col="black")

#수치값 ( 발생 비율 )
pct <- round(top10/sum(top10)*100,1)
text(x=bplot,y=top10*0.95,labels=paste(pct,"%"),col="black")


top10 <- head(sort(wordcount,decreasing=T),10)
top10
#그래프 그리기
#dev.new( )
top10
#plot(top10)
#plot(top10,xlab="",ylab="",axes=T,type="o")
plot(top10,xlab="",ylab="",ylim=c(0,4000),axes=T,type="o",col="red",
     main="많이 발생하는 오라클 에러-선그래프",lwd=2) #lwd는 선두께
#plot(top10,xlab="",ylab="",ylim=c(0,4000),type="o",col="red",
 #    main="많이 발생하는 오라클 에러-선그래프",lwd=2) #lwd는 선두께
#axis(1,at=1:10,labels = c(names(top10)),las=2) #XY축 형태를 변경하는 axis()
a= names(top10)
a[1:9]
#axis(1,at=1:10,lab = c("00312" ,"27037" ,"25153" ,"16038" ,"19502" ,"16014" ,"00313", "00600", "01092" ,"01110"),las=2,) #XY축 형태를 변경하는 axis()

lablist<-as.vector(a[1:10])
lablist
axis(1, at=seq(1, 10, by=1), labels = FALSE)
text(seq(1, 10, by=1), par("usr")[3] - 0.2, labels = lablist, srt = 45, pos = 1, xpd = TRUE)

axis(2,at=1:10,labels = a[1:10],las=1)#XY축 형태를 변경하는 axis()

axis(2,las=1)
abline(h=seq(0,4000,100),v=seq(1,10,1),col="gray",lty=2)



# 출력화면 4 - 양쪽 측면에 다른 기준을 주고 그래프를 겹쳐서 그리기

#dev.new()
par(mar=c(5,4,4,4)+0.1) # 그래프의 여백 조정하기

bp <- barplot(top10,main = "많이 발생한 오라클 에러 코드-종합", 
              col = rainbow(10), cex.names=0.7, las = 2,ylim=c(0,4000))
text(x = bp, y = top10*1.05, labels = paste(top10,"건"), col = "black", cex = 0.7)
par(new=T) # 그래프를 겹쳐서 그립니다.
plot(top10,type="o",axes=F, ylab="",xlab="",ylim=c(0,4000),lty=2,col="blue") 
pct <- round(top10/sum(top10) * 100 ,1)
text(x = bp, y = top10*1.15, labels = paste(pct,"%"), col = "black", cex = 0.7)

axis(4,las=1) # 4번 측면에 새로운 축 그리기 (오른쪽 측면)

mtext(side=4,line=2.5,"Line Chart") # 4번 측면에 글씨 쓰기
abline(h=seq(0,4000,200),v=seq(1,10,1),col="gray",lty=2)

