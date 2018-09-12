### 서울 관광명소 데이터 분석 ###

rm(list=ls()) #모든 변수값 초기화
setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
library("KoNLP")
library("wordcloud")
library("stringr")
useSejongDic()

#관광지 명칭 수동으로 추가
#mergeUserDic(data.frame(readLines("mergefile.txt"),"ncn"))
txt <- readLines("seoul_go.txt")

#명사만 분리하여 place 변수에 저장
place<-sapply(txt,extractNoun,USE.NAMES = F)
head(place,30)
head(unlist(place),30)
place<-unlist(place)
#place<-Filter(function(x){nchar(x)>=2},c)
place<-place[nchar(place)>=2]
head(place,30)
place <- str_replace_all(place,"[^[:alpha:]]","") #영문, 한글 아닌것 전부 제거
place<-gsub("\\d+","",place)
place<-gsub("\\(","",place)
place <- gsub("[A-Za-z]","",place)

place <- gsub(" ","",place)
place <- gsub("\\,","",place)
place <- gsub("\\.","",place)
place <- gsub("\\/","",place)
place <- gsub("\\[,","",place)
place <- gsub("\\),","",place)
head(place,30)


#place
#place <- place[place != ""] #벡터에서 공백 제거

#단어 대체
place <- gsub("서울","",place)
place <- gsub("명소","",place)
place <- gsub("블로그","",place)
place <- gsub("blog","",place)
place <- gsub("naver","",place)
place <- gsub("데이트","",place)
place <- gsub("검색","",place)
place <- gsub("야경","",place)
place <- gsub("벚꽃","",place)
place <- gsub("사진","",place)
place <- gsub("com","",place)
place <- gsub("추천","",place)
place <- gsub("관광명소","",place)
place <- gsub("me","",place)
place <- gsub("코스","",place)
place <- gsub("단풍","",place)
place <- gsub("주말","",place)
place <- gsub("여행","",place)
place <- gsub("가볼만한곳","",place)
place <- gsub("나들이","",place)
place <- gsub("공원","",place)
place <- gsub("오늘","",place)
place <- gsub("인사","",place)
place <- gsub("소개","",place)
place <- gsub("하늘","",place)
place <- gsub(" ","",place)
place <- gsub("관광","",place)
place <- gsub("요한","",place)
place <- gsub("축제","",place)
place <- gsub("행복","",place)
place <- gsub("거리","",place)
place <- gsub("km","",place)
place <- gsub("출사","",place)
place <- gsub("나들길","",place)
place <- gsub("cognos","",place)
place <- gsub("가을","",place)
place <- gsub("마을","",place)
place <- gsub("하게","",place)
place <- gsub("호수","",place)
place <- gsub("문화","",place)
place <- gsub("시간","",place)
place <- gsub("에서","",place)
place <- gsub("좋은곳","",place)
place <- gsub("tistory","",place)


#write(place,"seoul_go2.txt")
#place2<-read.table("seoul_go2.txt")
wordcount<-table(place)
head(sort(wordcount,decreasing=T),30)

library(RColorBrewer)
palete <- brewer.pal(8,"Set2")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),min_freq=4,
          random.order = F,random.color = T,colors=palete)
#wordcloud(words=names(wordcount), freq=wordcount, scale=c(8,.4), min.freq=2, random.order=F)
