### graph2 ###
#Part 2 - 예제 2-2 -소스코드

setwd("C:/Users/yeonjae/Desktop/R라뷰/data")

#install.packages("KoNLP") 
#install.packages("wordcloud") 
#install.packages("RColorBrewer")
library(KoNLP)  
library(wordcloud)

myray_1 <- readLines("new_myray.txt") 

myray_2 <- sapply(myray_1,extractNoun,USE.NAMES=F)
myray_2

my_ray3 <- unlist(myray_2) 
my_ray3 <- Filter(function(x) {nchar(x) >= 2} ,my_ray3) 
#my_ray3
my_ray3 <- gsub(" ","-",my_ray3) 
my_ray3 <- gsub("교체","",my_ray3)  
my_ray3 <- gsub("작동","",my_ray3)  
my_ray3 <- gsub("교환","",my_ray3)  
my_ray3 <- gsub("ㅠㅠ","",my_ray3) 
my_ray3 <- gsub("\\d+","",my_ray3) 
my_ray3 <- gsub("\\.","",my_ray3)   
head(sort(my_ray3,decreasing = T),20)

write(unlist(my_ray3),"myray_2.txt") 
ray <- read.table("myray_2.txt")
wordcount <- table(ray)


my_ray4 <- head(sort(wordcount, decreasing=T),10)
my_ray4
colors <- c()
for ( i in 1:length(my_ray4)) {
  if (my_ray4[i] >= 10 ) {
    colors <- c(colors,"red") }
  else if (my_ray4[i] >= 6 ){
    colors <- c(colors,"yellow") }
  else { 
    colors <- c(colors,"green") }
}

bchart <- barplot(my_ray4,main="고객불만 상위 TOP 10", ylab="불만건수" ,
                  names.arg=names(my_ray4),col=colors,las=2 , ylim=c(0,13))

text(x = bchart, y = my_ray4*0.95, labels = paste(my_ray4,"건"), col = "black", cex = 0.7)

pct <- round(my_ray4/sum(my_ray4) * 100 ,1)
text(x = bchart, y = my_ray4*1.05, labels = paste("(",pct,"%",")"), col = "black", cex = 0.6)

abline(h=8,col="red",lty=2,lwd=1)
abline(h=5,col="black",lty=2,lwd=1)

my_ray5 <- head(sort(wordcount, decreasing=T),10)

colors <- c()
for ( i in 1:length(my_ray5)) {
  if (my_ray5[i] >= 10 ) {
    colors <- c(colors,"red") }
  else if (my_ray5[i] >= 6 ){
    colors <- c(colors,"yellow") }
  else { 
    colors <- c(colors,"green") }
}
lab <- paste(names(my_ray5),"\n",my_ray5,"건")
pie(my_ray5,main="고객 불만 상위 Top 10",col=colors,
    cex=0.8,labels = lab)
