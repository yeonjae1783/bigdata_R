### graph ###
#Part 2 - 예제 2-1 -소스코드

setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
#install.packages("KoNLP")
#install.packages("wordcloud")
#install.packages("stringr")

library(KoNLP)  
library(wordcloud)
library(stringr)

useSejongDic( ) 
mergeUserDic(data.frame(readLines("mergefile.txt"), "ncn"))
mergeUserDic(data.frame(c('북촌한옥'),"ncn")) #새로운 단어 추가
txt <- readLines("seoul_go.txt")
place <- sapply(txt,extractNoun,USE.NAMES=F)
head(place,10) 
head(unlist(place), 30)

c <- unlist(place)  #벡터로 바꾸는 작업
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

NROW(res) #res개수 

write(res,"seoul_go2.txt") ## 최종 정제된 내용을 확인하기 위해 파일로 저장
res2 <- read.table("seoul_go2.txt") # 공백 행을 없애고 변수로 불러들입니다
wordcount <- table(res2) # 각 단어별 언급 횟수를 집계합니다
head(sort(wordcount, decreasing=T),30)
#pal=brewer.pal(7,"Dark2")
#wordcloud(names(wordcount),freq=wordcount,min.freq = 2,random.order = F,random.color = T,colors = pal,rot.per = 0.25)
top10 <- head(sort(wordcount, decreasing=T),10)
top10

#상위 10개 pie 형 그래프로 출력
pie(top10)
pie(top10,col=rainbow(10),radius=1)  #pie 색깔과 크기 지정
#수치값을 함께 출력하기
pct <- round(top10/sum(top10) * 100 ,1) # round()는 반올림 함수 1이면 소숫점아래 첫번째자리
names(top10)
lab <- paste(names(top10),"\n",pct,"%")
pie(top10,main="서울시 가볼만한 명소 TOP 10",col=rainbow(10), cex=0.8,labels = lab)

#도넛모양 만들기
pie(top10,main="서울의 가볼만한 명소 TOP 10",col=rainbow(10),cex=0.8,labels = lab)
par(new=T)
pie(top10,radius=0.6,col="white",labels=NA,border=NA) #가운데 하얀색 pie를 만들어 도넛모양으로 

#3D pie chart 출력하기
#install.packages("plotrix")
bchart <- head(sort(wordcount, decreasing=T),10)
library(plotrix)
th_pct <- round(bchart/sum(bchart) * 100,1)
th_names <- names(bchart)
th_labels <- paste(th_names,"\n","(",th_pct,")")
pie3D(bchart,main="서울의 가볼만한 명소 Top 10",col=rainbow(10),
      cex=0.5,labels=th_labels,explode=0.05)
시
#bar형태로 표시
bchart <- head(sort(wordcount, decreasing=T),10)
bplot <- barplot(bchart,  main = "서울의 가볼만한 명소 TOP 10 ", col = rainbow(10), 
                 cex.names=0.7, las = 2,ylim=c(0,30))
#las (축 라벨 스타일. 0(축에 평행), 1(수평), 2(축에 수직), 3(수직)),ylim ( y의 범위 )
pct <- round(bchart/sum(bchart) * 100 ,1)
pct

text(x = bplot, y = bchart*1.05, labels = paste("(",pct,"%",")"), col = "black", cex = 0.7)
text(x = bplot, y = bchart*0.95, labels = paste(bchart,"건"), col = "black", cex = 0.7)
     
     barplot(bchart,main="서울의 가볼만한 명소 Top 10",col=rainbow(10),
             xlim=c(0,30),cex.name=0.7,las=1,horiz=T)
     text(y = bplot, x = bchart*0.9, labels = paste(bchart,"건"), col = "black", cex = 0.7)
     text(y = bplot, x = bchart*1.1, labels = paste("(",pct,"%",")"), col = "black", cex = 0.7)
     
     

     
     