library(wordcloud)
library(wordcloud2)
setwd("/cloud/project/report-6")


#abeの所信
path <- "http://mjin.doshisha.ac.jp/data/abe.csv"
data <- read.csv(path, row.names = 1, fileEncoding = "cp932")
head(data)
data2 <- data.frame(word = rownames(data), data)
wordcloud2(data2)

# suga の cloud
suga <- read.csv("./suga.csv", fileEncoding = "cp932")
head(suga)
suga <- data.frame(word = suga$Word1, freq = suga$菅2020)
wordcloud2(suga)



# 所信表明の比較
kishida_suga <- read.csv("./kishida_suga.csv", row.names = 1, fileEncoding = "cp932")
comparison.cloud(kishida_suga, title.size=1.5, max.words=300)

