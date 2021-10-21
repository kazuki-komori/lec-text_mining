## n-gram 分析

setwd("/cloud/project/第4回")

## MeCabで分析
data <- read.csv("./keitaiso.csv", row.names = 1)

akutagawa <- data[, 1:10]
dazai <- data[, 11:20]

## それぞれtop助詞の出現回数
sum(akutagawa[1, ])
sum(dazai[1, ])

## 上位5個の助詞の出現割合を集計

for(i in 1:5) {
  print("akutagawa")
  print(sum(akutagawa[i, ]) / sum(akutagawa))
  print("dazai")
  print(sum(dazai[i, ]) / sum(dazai))
  print("/////////////////////////")
}

# CaboChaで分析
data <- read.csv("./MT-cabocha.csv", row.names = 1)
akutagawa <- data[, 1:10]
dazai <- data[, 11:20]

# 最も多い文節
sum(data[1, ])

# 上位5個の文節
for(i in 1:5) {
  print("akutagawa")
  print(sum(akutagawa[i, ]) / sum(akutagawa))
  print("dazai")
  print(sum(dazai[i, ]) / sum(dazai))
  print("/////////////////////////")
}


