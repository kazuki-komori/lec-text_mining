library(dplyr)
library(data.table)

setwd("/cloud/project/中間レポート")

data.mb_akuta <- read.csv("./data/mb_akuta.csv")
akuta.rate <- data.mb_akuta[, -1] / apply(data.mb_akuta[, -1], 2, sum)
akuta.js <- data.frame(cbind(data.mb_akuta[, 1], apply(akuta.rate, 1, mean)))
colnames(akuta.js) <- c("word", "val")


data.mb_dazai <- read.csv("./data/mb_dazai.csv")
dazai.rate <- data.mb_dazai[, -1] / apply(data.mb_dazai[, -1], 2, sum)
dazai.js <- data.frame(cbind(data.mb_dazai[, 1], apply(dazai.rate, 1, mean)))


# 頻度によるデータフレームを作成
dt.dazai <- apply(data.mb_dazai[, -1], 1, sum) %>% data.frame(data.mb_dazai$Word1, .)
colnames(dt.dazai) <- c("word", "val")
dt.akuta <- apply(data.mb_akuta[, -1], 1, sum) %>% data.frame(data.mb_akuta$Word1, .)
colnames(dt.akuta) <- c("word", "val")

dt <- merge(dt.dazai, dt.akuta, by="word")
colnames(dt) <- c("word", "dazai", "akuta")
rownames(dt) <- dt$word
dt <- dt[, -1]

# fisher 統計量をデータフレームから計算
fishers <- function(df) {
  ps <- c()
  for(i in 1:nrow(df)) {
    oth <- rbind(df[-i ,], df)
    oth.sum <- apply(oth, 2, sum)
    fr <- chisq.test(rbind(df[i, ], oth.sum))$p.value
    ps <- c(ps, round(fr, 7))
  }
  res <- cbind(df, ps)
  return(res)
}

dt.fs <- fishers(dt)
dt.fs[dt.fs$ps < 0.05,]

# 出現率の要約
t(round(t(dt.fs[dt.fs$ps < 0.05,]) / colSums(dt.fs[dt.fs$ps < 0.05,]), 3))[, -3]


# ワードクラウド
library(wordcloud2)
mei_akuta <- read.csv("./data/mei_akuta.csv", fileEncoding = "SHIFT-JIS") 
mei_dazai <- read.csv("./data/mei_dazai.csv", fileEncoding = "SHIFT-JIS") 

View(mei_akuta)

akuta.cloud <- data.frame(word = mei_akuta[, 1], freq = rowSums(mei_akuta[, -1]))
akuta.cloud <- akuta.cloud[-nrow(akuta.cloud), ]
akuta.cloud <- akuta.cloud[-1, ]
wordcloud2(akuta.cloud)

dazai.cloud <- data.frame(word = mei_dazai[, 1], freq = rowSums(mei_dazai[, -1]))
dazai.cloud <- dazai.cloud[-nrow(dazai.cloud), ]
dazai.cloud <- dazai.cloud[-1, ]
wordcloud2(dazai.cloud)


#出現率を算出
#data.rate <- data.frame(merge(dazai.cloud, akuta.cloud, by = "word", all = T))
#colnames(data.rate) <- c("word", "dazai", "akuta")
#data.rate[is.na(data.rate)] <- 0
#rownames(data.rate) <- data.rate$word
#data.rate <- data.rate[, -1]
#data.rate <- t(t(data.rate) / colSums(data.rate))


library(psych)
data.fa <- merge(mei_akuta, mei_dazai, all = T, by = "Word1")
data.fa[is.na(data.fa)] <- 0
rownames(data.fa) <- data.fa$Word1
data.fa <- data.fa[-1, -1]

fa.parallel(cor(data.fa), fa = "pc")

res.pca <- prcomp(data.fa, scale = T)
summary(res.pca)
biplot(res.pca, main = "主成分分析", repel = T)

# 対応分析
library(MASS)
data.cor <- data.fa
#煙管の削除
data.cor <- data.cor[- (grep("煙管|鼻|トロッコ", rownames(data.cor))), ]
res.corresp <- corresp(data.cor, n = 2)
plot(res.corresp)
