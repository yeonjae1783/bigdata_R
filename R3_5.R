

setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석/데이터/제3장")
library(twitteR)
library(tm)
library(wordcloud)

load("rdmTweets.RData") #rdmTweets.RData이 파일 읽기

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

 myCorpusCopy <- myCorpus
 myCorpus <- tm_map(myCorpus, stemDocument)
 myCorpus <- tm_map(myCorpus, stemCompletion, dictionary=myCorpusCopy)
 myCorpus <- tm_map(myCorpus, gsub, pattern="miners", replacement="mining")

tdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(1,Inf)))


#특정 단어와 관련성이 있는 단어들을 알고자 할 때 사용
#findAssocs(Term Document 행렬 , 단어, 최소상관계수)
findAssocs(tdm, 'data', 0.25)
findAssocs(tdm, 'mining', 0.25)

