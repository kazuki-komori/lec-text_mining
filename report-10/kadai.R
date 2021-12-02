setwd("/cloud/project")
getwd()

mei_akuta <- read.csv("./中間レポート/data/mei_akuta.csv", fileEncoding = "SHIFT-JIS") 
mei_dazai <- read.csv("./中間レポート/data/mei_dazai.csv", fileEncoding = "SHIFT-JIS") 

mb_akuta <- read.csv("./中間レポート/data/mb_akuta.csv") 
mb_dazai <- read.csv("./中間レポート/data/mb_dazai.csv")


# JSD の算出関数
jsdist<-function(x){
  x<-x+1e-006 #ゼロである値の対数演算のため
  x<-(x/apply(x,1,sum))
  apply(x, 1, function(y){ # 各行に次の関数を適用する
    apply(x, 1, function(z){
      sqrt(sum((y*log(2*y/(y+z))+z*log(2*z/(y+z)))/2))
    })
  })
}

# タイトル修正
titles <- c("a-鼻", "a-地獄変", "a-蛙", "a-貝殻", "a-枯野抄", "a-煙管", "a-女", "a-羅生門", "a-沙羅の花", "a-トロッコ", "d-兄たち", "d-朝", "d-あさましきもの", "d-走れメロス", "d-キリギリス", "d-人間失格", "d-女の決闘", "d-惜別", "d-創世記", "d-嘘")

# 名詞データの分析
data.mei <- merge(mei_akuta, mei_dazai, all = T, ID = "Word1")
data.mei[is.na(data.mei)] <- 0
data.mei <- data.mei[-1, ]
rownames(data.mei) <- data.mei$Word1
data.mei$Word1 <- NULL
colnames(data.mei) <- titles

# クラスター描画
dist.mei <- jsdist(t(data.mei))
hc.mei <- hclust(as.dist(dist.mei), "ward.D2")
plot(hc.mei, hang = -1, main = "太宰治と芥川龍之介の作品 JSDクラスター")

# 助詞データの分析
data.mb <- merge(mb_akuta, mb_dazai, all = T, ID = "Word1")
data.mb[is.na(data.mb)] <- 0
data.mb <- data.mb[-1, ]
rownames(data.mb) <- data.mb$Word1
data.mb$Word1 <- NULL
colnames(data.mb) <- titles

# クラスター描画
dist.mb <- jsdist(t(data.mb))
hc.mb <- hclust(as.dist(dist.mb), "ward.D2")
plot(hc.mb, hang = -1, main = "太宰治と芥川龍之介の作品 JSDクラスター")



