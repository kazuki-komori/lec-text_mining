setwd("/cloud/project")
getwd()

library(kernlab)
library(caret)

mei_akuta <- read.csv("./中間レポート/data/mei_akuta.csv", fileEncoding = "SHIFT-JIS") 
mei_dazai <- read.csv("./中間レポート/data/mei_dazai.csv", fileEncoding = "SHIFT-JIS") 

mb_akuta <- read.csv("./中間レポート/data/mb_akuta.csv") 
mb_dazai <- read.csv("./中間レポート/data/mb_dazai.csv")


titles <- c("a-鼻", "a-地獄変", "a-蛙", "a-貝殻", "a-枯野抄", "a-煙管", "a-女", "a-羅生門", "a-沙羅の花", "a-トロッコ", "d-兄たち", "d-朝", "d-あさましきもの", "d-走れメロス", "d-キリギリス", "d-人間失格", "d-女の決闘", "d-惜別", "d-創世記", "d-嘘")

data.mb <- merge(mb_akuta, mb_dazai, ID = "Word1", all = T)
data.mb[is.na(data.mb)] <- 0
rownames(data.mb) <- data.mb$Word1
data.mb$Word1 <- NULL
data.mb <- as.data.frame(t(data.mb))
data.mb$OTHERS1 <- NULL
data.mb$type <- as.factor(c(rep("akuta", 10), rep("dazai", 10)))
rownames(data.mb) <- titles
## SVM
res.ksvm <- ksvm(type ~ ., data.mb)
res.ksvm
# 正解率
table(data.mb$type, predict(res.ksvm, data.mb[, colnames(data.mb) != "type"]))

# svm 2変数バージョンでプロット
data2 <- cbind(data.mb[, 3:4], data.mb$type)
colnames(data2) <- c(colnames(data.mb[, 3:4]), "type")
res.ksvm2 <- ksvm(type ~ ., data2)
plot(res.ksvm2, data=data.mb[, 3:4])


# ロジステック
ctrl <- trainControl(method = "repeatedcv", repeats = 5, number=7)
res.log <- train(type ~ ., data = data.mb, method = "glmnet", trControl = ctrl)
table(data.mb$type, predict(res.log, data.mb[colnames(data.mb) != "type"]))
