 plot.new()
 x <- c(1,2,3,4,5)
 barplot(x)
 
 x <- 1:5
 barplot(x,horiz=T)

 x <- matrix(c(5,4,3,2),2,2)
 x
 barplot(x,beside=T,names=c(5,3),col=c("green","yellow"))
 
 barplot(x,names=c(5,3),col=c("green","yellow"),ylim=c(0,13))
 
 barplot(x,beside=T,names=c(5,3),col=c("green","yellow"),horiz=T)

 barplot(x,names=c(5,3),col=c("green","yellow"),horiz=T)
 
 v1 <- c(150,140,130,120,150)
 v2 <- c(130,150,120,110,160)
 v3 <- c(110,110,140,150,140)
 
 df <- data.frame(BANANA=v1,APPLE=v2,CHERRY=v3)
 df
 barplot(as.matrix(df),main="Fruit Sales",ylim=c(0,500),beside=T,col=rainbow(nrow(df)))
 legend(1.5,500,c("MON","TUE","WED","THU","FRI"),cex=0.8,fill=rainbow(nrow(df)))
 
 
 barplot(t(df),main = "Fruit Sales",ylim=c(0,800),col=rainbow(length(df)),space=0.1,cex.axis=0.8,las=1,
         names.arg=c("MON","TUE","WED","THU","FRI"),cex=0.8)
 legend(0,800,names(df),cex=0.7,fill=rainbow(length(df)))
 
 
 