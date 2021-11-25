setwd("/cloud/project/report-9")

library(readr)
data.livedoor <- read_csv("./data/livedoor.csv", locale = locale(encoding = "SHIFT-JIS"))

data.lda <- data.frame(rbind(data.livedoor[1:500, ], data.livedoor[1501:2000, ], data.livedoor[2001:2500, ], data.livedoor[3501:4000, ]))
data.lda <- data.lda[, -1]
data.lda[,1]
sum(data.lda[colSums(data.lda) == 0, ])
help(grep)
head(data.livedoor)


# LDA実行
library(topicmodels)

data.lda <- data.livedoor[, -1]
res.lda <- LDA(data.lda, method = "Gibbs", k = 4)

# トピック数の確認
topics(res.lda)

terms(res.lda, 10)
terms <- posterior(res.lda)$term




library(LDAvis)
buildVisdata1 <- function(corpus, fit, doc_term) {
  phi <- posterior(fit)$terms %>% as.matrix
  theta <- posterior(fit)$topics %>% as.matrix
  vocab <- colnames(phi)
  doc_length <- vector()
  for (i in 1:length(corpus)) {
    temp <- paste(corpus[[i]]$content, collapse = ' ')
    doc_length <- c(doc_length, stri_count(temp, regex = '\\S+'))
  }
  term.frequency <- colSums(as.matrix(doc_term))
  params <- list(phi = phi,
                 theta = theta,
                 doc.length = doc_length,
                 vocab = vocab,
                 term.frequency = term.frequency)
  return(params)
}

VisualizeModel <- function(fit, doc_term, dir) {
  params <- buildVisdata1(fit, doc_term)
  json <- createJSON(phi = params$phi,
                     theta = params$theta,
                     doc.length = params$doc.length,
                     vocab = params$vocab,
                     term.frequency = params$term.frequency,
                     mds.method = svd_tsne
  )
  serVis(json, out.dir = dir, open.browser = TRUE)
}
help(createJSON, package = "LDAvis")

VisualizeModel(res.lda, data.lda, "./opt")
