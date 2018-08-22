setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석")
library(KoNLP)
library(wordcloud)

moon= readLines("moon.txt")
useSejongDic()
mergeUserDic(data.frame(c('문재인','5·18','임을 위한 행진곡'),"ncn")) #새로운 단어 추가
nouns <- sapply(moon, extractNoun,USE.NAMES=F) # 벡터 혹은 리스트에 있는 각각의 원소에 대해 특정함수를 적용하기위해 사용하는 함수
nouns <- unlist(nouns)
nouns <- nouns[nchar(nouns)>=2]
nouns
#nouns <-gsub("하게","",nouns)
wordFreq<-table(nouns)
pal<-brewer.pal(10,"Spectral")
windowsFonts(malgun=windowsFont("맑은 고딕"))

set.seed(1000)
wordcloud(words=names(wordFreq),freq=wordFreq,scale=c(3,0.5),colors=pal,min.freq = 2,
          random.order = F,family="malgun")
