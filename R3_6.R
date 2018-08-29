
#rm(list = ls())              

setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석/데이터/제3장")
library(twitteR)
library(KoNLP) 
library(wordcloud)
library(tm)

load("삼성전자.RData")
#ls()
#str(rdmTweets)
df <- do.call("rbind", lapply(rdmTweets, as.data.frame))
#dim(df)

useSejongDic()
nouns <- sapply(df$text, extractNoun, USE.NAMES=F) 
 # 벡터 혹은 리스트에 있는 각각의 원소에 대해 특정함수를 적용하기위해 사용하는 함수
nouns <- unlist(nouns)
nouns <- nouns[nchar(nouns)>=2]
nouns
myCorpus <- Corpus(VectorSource(nouns))
#inspect(myCorpus)
 # convert to lower case
myCorpus <- tm_map(myCorpus, tolower)
 # remove punctuation
myCorpus <- tm_map(myCorpus, removePunctuation)
 # remove numbers
myCorpus <- tm_map(myCorpus, removeNumbers)
# myStopwords <- c(stopwords('english'), "rt", "co","samsungtomorrow")
 # remove stopwords from corpus
#myCorpus <- tm_map(myCorpus, removeWords, myStopwords)

removeTwit <- function(x) {gsub("@[[:alnum:]]*", "", x)}
myCorpus <- tm_map(myCorpus, removeTwit)

removeURL <- function(x) { gsub("http[[:alnum:]]*", "", x)}
myCorpus <- tm_map(myCorpus, removeURL)

remove삼성<- function(x) { gsub("삼성", "", x)}
myCorpus <- tm_map(myCorpus, remove삼성)

remove전자 <- function(x) { gsub("전자", "", x)}
myCorpus <- tm_map(myCorpus, remove전자)

remove폰앤케이스 <- function(x) { gsub("폰앤케이스?", "", x)}
myCorpus <- tm_map(myCorpus, remove폰앤케이스)

remove한국투데이 <- function(x) { gsub("한국투데이", "", x)}
myCorpus <- tm_map(myCorpus, remove한국투데이)

remove개국에서 <- function(x) { gsub("개국에서", "", x)}
myCorpus <- tm_map(myCorpus, remove개국에서)

tdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(2,Inf)))
 
m <- as.matrix(tdm)

wordFreq <- sort(rowSums(m), decreasing=TRUE)
 # word cloud
set.seed(1000) # to make it reproducible
pal <- brewer.pal(8,"Dark2")
windowsFonts(malgun=windowsFont("맑은 고딕"))
wordcloud(words=names(wordFreq), freq=wordFreq, scale=c(5,.5), min.freq=5,  colors=pal, random.order=F,family="malgun")

