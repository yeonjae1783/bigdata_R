### complaints text mining ###

setwd("C:/Users/yeonjae/Desktop/R라뷰/data")
library(KoNLP)
library(wordcloud)
useSejongDic()

txt<-readLines("new_myray.txt")
txt<-sapply(txt, extractNoun,USE.NAMES = F)

txt<-unlist(txt)
txt<-txt[nchar(txt)>=2]

#txt
txt <- gsub("\\d+","",txt) #숫자제거
txt <- gsub(" ","",txt)
txt <- gsub("ㅠㅠ","",txt)
txt <- gsub("ㅜㅜ","",txt)
txt <- gsub("^질문+","",txt)
txt <- gsub("^문의+","",txt)
txt <- gsub("\\W","",txt)
#pal<-brewer.pal(6,"Dark2")
pal<-brewer.pal(10,"Spectral")
wf <- sort(table(txt),decreasing=T)
#wf<-table(txt)

#head(sort(wf,decreasing = T),20)
windowsFonts(malgun=windowsFont("맑은 고딕"))
set.seed(1234)
#wordcloud(words=names(wf),freq=wf,scale=c(10,1),colors=pal,min.freq = 2,random.order = F)#random.color = T,colors=pal)

#wordcloud(words=names(wf),freq=wf,scale=c(3,0.5),colors=pal,min.freq = 2,
 #         random.order = F,family="malgun")
wordcloud(names(wf),freq=wf,scale=c(10,1),min.freq=2,
          max.words=Inf, random.order=F, rot.per=.1,colors=pal)
