##################################
#   트위터 데이터 분석하기       #
##################################


#rm(list = ls())              
setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석/데이터/제3장")
library(twitteR)
library(tm)
library(wordcloud)

load("rdmTweets.RData") #rdmTweets.RData이 파일 읽기
#str(rdmTweets) #내부구조 알고자 할 때
#class(rdmTweets) #파일의 객체 목록 알고자 할 때 


#데이터프레임으로 변환 (특정 변수만 분석하고 싶을 때)
# lapply(벡터,함수) 벡터 혹은 리스트의 각 원소에 함수 적용하는 
df <- do.call("rbind", lapply(rdmTweets, as.data.frame)) #각 변수끼리 묶기 위해
myCorpus <- Corpus(VectorSource(df$text)) #corpus 생성

 # convert to lower case
  myCorpus <- tm_map(myCorpus,tolower)
  
 # remove punctuation
  myCorpus <- tm_map(myCorpus, removePunctuation)
 # remove number
  myCorpus <- tm_map(myCorpus,removeNumbers)
 # remove stopwords from corpus
  myCorpus <- tm_map(myCorpus, removeWords, stopwords('english'))
  
# 지우는 형식 만들어서 지우기  
# remove URLs
 removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) #http로 시작하는 문자열 중에서 뒤에 알파벳이나 숫자가 나오는 문자열 
 #[[:alnum:]]는 알파벳 혹은 숫자 의미
 myCorpus <- tm_map(myCorpus, removeURL)
 
 
 
# myCorpus <- tm_map(myCorpus, PlainTextDocument)
 tdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(1,Inf)))
 m <- as.matrix(tdm)
as.matrix(tdm)
 #각 문서에서 단어의 사용빈도 알려줌
 #https://m.blog.naver.com/PostView.nhn?blogId=steadilycoming&logNo=220979512147&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F
 
 # calculate the frequency of words and sort it descendingly by frequency
 wordFreq <- sort(rowSums(m), decreasing=TRUE)

 set.seed(375) # to make it reproducible
 pal=brewer.pal(8,"Dark2")
 # set.seed () 함수를 사용하면 동일한 임의의 varibales를 사용하여 특정 작업을 다시 평가하는 데 필요한 임의의 변수 세트를 재사용하는 데 도움이됩니다.
 wordcloud(words=names(wordFreq), freq=wordFreq, scale=c(8,.4), min.freq=2,colors=pal, random.order=F)
# dev.off()
