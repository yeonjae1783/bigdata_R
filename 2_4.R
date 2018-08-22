#영문 파일중 원하는 부분만 textmining

setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석/데이터/제2장")
library(tm)
library(wordcloud)

shakespeare = readLines("shakespeare.txt")
#length(shakespeare)
#head(shakespeare)
#tail(shakespeare)

shakespeare = shakespeare[-(124369:length(shakespeare))] #124369번째 줄부터 끝까지 제거

shakespeare = shakespeare[-(1:174)] #첫번째줄부터 174번째 줄까지 제거
#length(shakespeare)

shakespeare = paste(shakespeare, collapse = " ") #전체를 하나의 문자열로 묶고 줄과 줄 연결은 공백으로
#length(shakespeare)

shakespeare = strsplit(shakespeare, "<<[^>]*>>")[[1]] # <<로 시작하고 >>로 끝나는 문자열 제거되면서 분리 

(dramatis.personae <- grep("Dramatis Personae", shakespeare, ignore.case = TRUE)) #등장인물인 Dramatis Personae 대소문자 상관없이 위치 찾기
#length(dramatis.personae)
shakespeare = shakespeare[-dramatis.personae]

myCorpus <- Corpus(VectorSource(shakespeare))
myCorpus <- tm_map(myCorpus, tolower)
myCorpus <- tm_map(myCorpus, removePunctuation)
myCorpus <- tm_map(myCorpus, removeNumbers)
#myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))
myStopwords <- c(stopwords('english'), "thou", "let","shall",
 "thee", "thy", "will", "now", "sir", "now", "well", "upon", "one", "tis", "may", "yet", "must", "enter")
# remove stopwords(불용어(관사)) from corpus
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)
#myCorpus <- tm_map(myCorpus, PlainTextDocument)

tdm <- TermDocumentMatrix(myCorpus)
m <- as.matrix(tdm)

wordFreq <- sort(rowSums(m), decreasing=TRUE)

pal=brewer.pal(8,"Dark2")

set.seed(1234) # to make it reproducible
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=500, colors=pal, random.order=F)

