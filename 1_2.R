#Part 2 - 예제 1-2 소스코드

setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
#install.packages("KoNLP")
#install.packages("wordcloud")
#install.packages("stringr")

library(KoNLP)  
library(wordcloud)
library(stringr)

useSejongDic( ) 
mergeUserDic(data.frame(readLines("mergefile.txt"), "ncn"))

txt <- readLines("seoul_go.txt")
place <- sapply(txt,extractNoun,USE.NAMES=F)
head(place,10) 

head(unlist(place), 30)
c <- unlist(place) 
place <- Filter(function(x) {nchar(x) >= 2} ,c)

res <- str_replace_all(place, "[^[:alpha:]]", "") #영문, 한글 아닌것 전부 제거
res <- res[res != ""] #벡터에서 공백을 제거합니다
res <- gsub("서울","",res)  
res <- gsub("명소","",res)  
res <- gsub("소개","",res)  
res <- gsub("추천","",res)  
res <- gsub("블로그","",res)  
res <- gsub("검색","",res)  
res <- gsub("blog","",res)  
res <- gsub("naver","",res)  
res <- gsub("com","",res)  
res <- gsub("me","",res)  
res <- gsub("데이트","",res)  
res <- gsub("약도","",res)  
res <- gsub("사진","",res)  
res <- gsub("야경","",res)  
res <- gsub("여행","",res)  
res <- gsub("근교","",res)  
res <- gsub("이야기","",res)  
res <- gsub("안녕","",res)  
res <- gsub("도시","",res) 
res <- gsub("관광","",res)
res <- gsub("벚꽃","",res)
res <- gsub("코스","",res)
res <- gsub("오늘","",res)
res <- gsub("요한","",res)
res <- gsub("축제","",res)
res <- gsub("행복","",res)
res <- gsub("가볼만한곳","",res)
res <- gsub("걷기","",res)
res <- gsub("km","",res)
res <- gsub("거리","",res)
res <- gsub("공원","",res)
res <- gsub("문화","",res)
res <- gsub("마을","",res)
res <- gsub("가을","",res)
res <- gsub("단풍","",res)
res <- gsub("나들이","",res)
res <- gsub("주말","",res)
res <- gsub("출사","",res)
res <- gsub("하게","",res)
res <- gsub("구경","",res)
res <- gsub("유명","",res)
res <- gsub("좋은곳","",res)
res <- gsub("daum","",res)
res <- gsub("시간","",res)
NROW(res) 
write(res,"seoul_go2.txt") ## 최종 정제된 내용을 확인하기 위해 파일로 저장
res2 <- read.table("seoul_go2.txt") # 공백 행을 없애고 변수로 불러들입니다
wordcount <- table(res2) # 각 단어별 언급 횟수를 집계합니다
head(sort(wordcount, decreasing=T),30)

library(RColorBrewer) 
palete <- brewer.pal(8,"Set2") 
wordcloud(names(wordcount),freq=wordcount,scale=c(3,.1),rot.per=0.25,min.freq=3,
          random.order=F,random.color=T,colors=palete)
savePlot("seoul_go.png",type="png")





