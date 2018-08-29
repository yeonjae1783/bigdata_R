############################
#어간 추출 (word stemming) #
#어간이 같은 단어 통합하기 #
############################

#rm(list = ls())              
setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석/데이터/제3장")
library(twitteR)
library(tm)
library(wordcloud)

load("rdmTweets.RData")
#str(rdmTweets)

df <- do.call("rbind", lapply(rdmTweets, as.data.frame))
myCorpus <- Corpus(VectorSource(df$text))
#tm_map 함수 : corpus에 있는 모든 문서에 변환을 위한 함수
 # convert to lower case
 myCorpus <- tm_map(myCorpus, tolower)
 # remove punctuation
 myCorpus <- tm_map(myCorpus, removePunctuation)
 # remove numbers
 myCorpus <- tm_map(myCorpus, removeNumbers)
 
 # remove stopwords from corpus
  myCorpus <- tm_map(myCorpus, removeWords, stopwords('english'))

# remove URLs
 removeURL <- function(x) gsub("http[[:alnum:]]*", "", x)
 myCorpus <- tm_map(myCorpus, removeURL)

 
 #어간이 같은 단어를 하나의 단어로 통합합
 # ex) update, updated updating 을 updat로 통합
 
 myCorpus <- tm_map(myCorpus, stemDocument)
wordFreq[1:20]
# myCorpus <- tm_map(myCorpus, PlainTextDocument)
 tdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(1,Inf)))
 m <- as.matrix(tdm)

 # calculate the frequency of words and sort it descendingly by frequency
 wordFreq <- sort(rowSums(m), decreasing=TRUE)

 set.seed(375) # to make it reproducible
 wordcloud(words=names(wordFreq), freq=wordFreq, scale=c(8,.4), min.freq=2, random.order=F)
# dev.off()
