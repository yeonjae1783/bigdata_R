### 서울 응답소 데이터 분석 ###
setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
library(KoNLP)
library(wordcloud)
useSejongDic()

data1 <-readLines("seoul_new.txt")
#data1
#공백을 기준으로 명사만 추출하기
#data2 <- extractNoun(data1)
data2 <- sapply(data1,extractNoun,USE.NAMES=F)
#data2
head(unlist(data2),30)

data3 <- unlist(data2)
#data3 <- data3[nchar(data3)>=2]
data3 <-Filter(function(x){nchar(x)>=2},data3) # 두 글자 이상 되는것만 필터링하기

#원하지 않는 내용 걸러내기
data3 <-gsub("\\d+","",data3)
data3 <-gsub(" ","",data3)
data3 <-gsub("서울","",data3)
data3 <-gsub("서울시","",data3)
data3 <-gsub("부탁","",data3)
data3 <-gsub("요청","",data3)
data3 <-gsub("제안","",data3)
data3 <-gsub("-","",data3)
data3 <-gsub("개선","",data3)
data3 <-gsub("민원","",data3)
data3 <-gsub("OO","",data3)
data3 <-gsub("관련","",data3)
data3 <-gsub("시","",data3)
data3 <-gsub("택","",data3)
data3 <-gsub("문제","",data3)
data3 <-gsub("불편","",data3)
data3 <-gsub("장","",data3)
data3 <-gsub("O","",data3)
data3 <-gsub("OOO","",data3)
#파일로 저장 한 후 테이블 형태로 변환하여 불러들이기
write(unlist(data3),"seoul_2.txt")
data3 <-gsub("시","",data3)
data4 <-read.table("seoul_2.txt")
#data4
nrow(data4) # 데이터 개수
wordcount <-table(data4)
#wordcount
head(sort(wordcount,decreasing = T),20)

library(RColorBrewer)
palete<-brewer.pal(9,"Set3")

wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq = 2,random.order = F,random.color = T,colors=palete)
legend(0.3,1,"서울시 응답소 요청사항 분석",  cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")
saveplot("seoul_new.png",type="png")
