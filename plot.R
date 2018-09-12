
 var1 <- c(1,2,3,4,5)
 plot(var1)
 
 var2 <- c(2,2,2)
 plot(var2)
 
 x<-1:3
 y<-3:1
 plot(x,y,xlim=c(1,10),ylim=c(1,5),
       +      xlab="X축 값",ylab="Y축 값",
       +      main="Plot Test")
 v1 <- c(100,130,120,160,150)
 plot(v1,type='o',col='red',ylim=c(0,200),axes=F,ann=F) # axes=F : 축 표시 안함, ann = F : 축 제목 지정 안함
 axis(1,at=1:5,lab=c("MON","TUE","WED","THU","FRI"))
 axis(2,ylim=c(0,200))
 
 title(main="FRUIT",col.main="red",font.main=4)
 title(xlab="DAY",col.lab="black")
 title(ylab="PRICE",col.lab="black")
 
 v1 <- 5:1
 v2 <- 1:5
 v3 <- 3:7
 plot(v1,type='s',col='red',ylim=c(1,10))
 par(new=T) # 
 lines(v2,type='o',col='blue',ylim=c(1,5))
 par(new=T)
 lines(v3,type='l',col='black',ylim=c(1,10))
 
 legend(4,9.8,c("v1","v2","v3"),cex=0.9,col=c("red","blue","black"),lty=1)
 
 