setwd("/cloud/project/report-9")

library(readr)
data.livedoor <- read_csv("./data/livedoor.csv", locale = locale(encoding = "SHIFT-JIS"))

data.lda <- data.frame(rbind(data.livedoor[1:500, ], data.livedoor[1501:2000, ], data.livedoor[2001:2500, ], data.livedoor[3501:4000, ]))
data.lda[1100, ]$Words
data.lda <- data.lda[, colnames(data.lda) != "OTHERS"] # OTHERSの数が多いため削除
data.lda <- data.lda[, -1] # 単語が列として不要なので削除
data.lda <- data.lda[, colSums(data.lda) != 0] # 出現数がトータル0の単語を削除


# LDA実行
library(topicmodels)
res.lda <- LDA(data.lda, method = "Gibbs", k = 4)

# トピック数の確認
topics(res.lda)

terms(res.lda, 10)
terms <- posterior(res.lda)$term

# 可視化
library(LDAvis)
library(servr)

options(encoding = "UTF-8") # 文字コード設定
lda.phi <- as.matrix(posterior(res.lda)$terms) # 単語の推測確率
lda.theta <- as.matrix(posterior(res.lda)$topics) # topicの推測確率
lda.vocab <- colnames(lda.phi) # 単語ベクトル
lda.doc <- rowSums(data.lda) # 各文書の単語数
lda.term <- colSums(data.lda) # 各単語の出現数
lda.json <- createJSON(phi = lda.phi, theta = lda.theta, vocab = lda.vocab, term.frequency = lda.term, doc.length = lda.doc) # JSONの作成

serVis(lda.json)

