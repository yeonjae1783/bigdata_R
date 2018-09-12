### log file 특정 키워드 분석 ###

setwd('C:/Users/yeonjae/Desktop/R라뷰/data')
library('KoNLP')
library('wordcloud')

log <- readLines('oracle_alert_testdb.log')
error_1 <- gsub(" ","_",log)
#head(unlist(error_1),30)

error2 <- unlist(error_1)
error2<-error2[nchar(error2)>=5]

error3 <- grep("^ORA-",error2,value=T)
head(unlist(error3),20)

errorcount<-table(error3)
head(sort(errorcount,decreasing=T),20)
palete <- brewer.pal(8,"Set2")
wordcloud(names(errorcount),freq=errorcount,scale=c(4,.5),rot.per=0.25,min.freq = 3,random.order = F,random.color=T,colors=palete)