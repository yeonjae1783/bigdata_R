
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

 myCorpusCopy <- myCorpus
 myCorpus <- tm_map(myCorpus, stemDocument)
 myCorpus <- tm_map(myCorpus, stemCompletion, dictionary=myCorpusCopy)
 myCorpus <- tm_map(myCorpus, gsub, pattern="miners", replacement="mining")

 tdm <- TermDocumentMatrix(myCorpus, control=list(wordLengths=c(1,Inf)))

 m <- as.matrix( tdm) 
 termFrequency <- rowSums(m)
 termFrequency <- subset( termFrequency,  termFrequency>= 10) 
 termFrequency 
 barplot(termFrequency, las=2) 

