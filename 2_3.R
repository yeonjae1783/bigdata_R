setwd("C:/Users/yeonjae/Desktop/R을 이용한 빅데이터 분석")
#install.packages("tm")
library(tm)
library(wordcloud)

textMining = readLines("textmining.txt")
myCorpus<- Corpus(VectorSource(textMining)) #corpus 생성

myCorpus <- tm_map(myCorpus,stripWhitespace) #공백제거
myCorpus <- tm_map(myCorpus,tolower) #소문자로 변환
myCorpus <- tm_map(myCorpus,removePunctuation) #구두점제거
myCorpus <- tm_map(myCorpus,removeNumbers) #숫자제거
myCorpus <- tm_map(myCorpus,removeWords,stopwords("english")) #관사제거

#myCorpus <- tm_map(myCorpus,PlainTextDocument)
tdm <- TermDocumentMatrix(myCorpus) #빈도수를 위한 행렬 생ㅅ
m<-as.matrix(tdm)

wordFreq<-sort(rowSums(m),decreasing=TRUE)
pal=brewer.pal(8,"Dark2")

set.seed(1234)
wordcloud(words=names(wordFreq),freq=wordFreq,scale=c(7,0.5),min.freq=2,colors=pal,
          random.order = F)

