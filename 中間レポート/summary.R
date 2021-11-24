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

#出現率を算出
#colnames(dazai.js) <- c("word", "val")
#data.rate <- merge(dazai.js, akuta.js, by = "word")
#colnames(data.rate) <- c("word", "dazai", "akuta")
#data.rate <- data.rate[-1, ]


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

(fishers(dt))
