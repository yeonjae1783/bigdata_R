
#rm(list = ls())              
setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석/데이터/제3장")

library(twitteR)
library(tm)
library(wordcloud)

load("rdmTweets.RData")
#str(rdmTweets)

df <- do.call("rbind", lapply(rdmTweets, as.data.frame))
myCorpus <- Corpus(VectorSource(df$text))

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

 
 #word stemming 수행 후 어간들로 이루어진 워드 클라우드는 실제 단어와는 차이가 있어서
 #트윗에서 사용된 단어로 대체해야 한다. 어간 대신 완전한 단어(complete word)를 찾아 변환시켜주는 작업  
myCorpusCopy <- myCorpus 
myCorpus <- tm_map(myCorpus, stemDocument)
myCorpus <- tm_map(myCorpus, stemCompletion, dictionary=myCorpusCopy)

#myCorpus <- tm_map(myCorpus, PlainTextDocument)
tdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(1,Inf)))
m <- as.matrix(tdm)

 wordFreq <- sort(rowSums(m), decreasing=TRUE)
 # word cloud
 set.seed(375) # to make it reproducible
 wordcloud(words=names(wordFreq), freq=wordFreq, scale=c(8,.4), min.freq=2, random.order=F)
# dev.off()
