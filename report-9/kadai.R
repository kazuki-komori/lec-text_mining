setwd("/cloud/project/report-9")

library(readr)
data.livedoor <- read_csv("./data/livedoor.csv", locale = locale(encoding = "SHIFT-JIS"))

data.lda <- data.frame(rbind(data.livedoor[1:500, ], data.livedoor[1501:2000, ], data.livedoor[2001:2500, ], data.livedoor[3501:4000, ]))
data.lda <- data.lda[, colnames(data.lda) != "OTHERS"]
data.lda <- data.lda[, -1]
data.lda <- data.lda[, colSums(data.lda) != 0]

# LDA実行
library(topicmodels)
res.lda <- LDA(data.lda, method = "Gibbs", k = 4)

# トピック数の確認
topics(res.lda)

terms(res.lda, 10)
terms <- posterior(res.lda)$term


library(LDAvis)
library(servr)

options(encoding = "UTF-8")
lda.phi <- as.matrix(posterior(res.lda)$terms) # 
lda.theta <- as.matrix(posterior(res.lda)$topics)
lda.vocab <- colnames(lda.phi)
lda.doc <- rowSums(data.lda)
lda.term <- colSums(data.lda)
lda.json <- createJSON(phi = lda.phi, theta = lda.theta, vocab = lda.vocab, term.frequency = lda.term, doc.length = lda.doc)

serVis(lda.json)

