### needs text mining ###

setwd('C:/Users/yeonjae/Desktop/R라뷰/data')
library('KoNLP')
library('wordcloud')
useSejongDic()

txt <- readLines('yeca_1.txt')
txt <- sapply(txt,extractNoun,USE.NAMES = F)
txt2 <- unlist(txt)
txt2 <- txt2[nchar(txt2)>=2]

txt2 <- gsub("\\d+","",txt2)
txt2 <- gsub(" ","",txt2)
txt2 <- gsub("^공구+","",txt2)
txt2 <- gsub("조회수","",txt2)
txt2 <- gsub("추천수","",txt2)
txt2 <- gsub("답변수","",txt2)
txt2 <- gsub("^드려요","",txt2)
txt2 <- gsub("부탁","",txt2)
txt2 <- gsub("공동구매","",txt2)
txt2 <- gsub("^부탁+","",txt2)
txt2 <- gsub("^다시+","",txt2)
txt2 <- gsub("^해주+","",txt2)
txt2 <- gsub("^세요+","",txt2)
txt2 <- gsub("\\n","",txt2)
txt2 <- gsub("\\W","",txt2)
txt2 <- gsub("","",txt2)

# .을 지우려고 txt2 <- gsub(".","",txt2)하니까 모든 단어가 사라짐 
# .은 정규식에서 엔터를 제외한 모든문자이기 때문에 다사라짐
# .을 제외하려면 txt2 <- gsub("\\W","",txt2) 사용 \\W는 단어가 아닌것 의미
head(unlist(txt2),30)

wordcount <-table(txt2)
head(sort(wordcount,decreasing=T),20)

palete = brewer.pal(6,"Dark2")
wordcloud(names(wordcount),freq=wordcount,scale = c(10,1),rot.per = 0.25
          ,min.freq = 1,random.order = F,random.color = T,colors=palete)
