## create crean txt

setwd("/cloud/project/txt_cleaner/data/row")

# 芥川龍之介
# 女, 地獄変, 沙羅の花, トロッコ, 鼻, 羅生門, 枯野抄, 蛙, 貝殻, 煙管
book1 = c(
  "https://www.aozora.gr.jp/cards/000879/files/120_ruby_1011.zip",
  "https://www.aozora.gr.jp/cards/000879/files/60_ruby_821.zip",
  "https://www.aozora.gr.jp/cards/000879/files/3820_ruby_27216.zip",
  "https://www.aozora.gr.jp/cards/000879/files/43016_ruby_16663.zip",
  "https://www.aozora.gr.jp/cards/000879/files/42_ruby_154.zip",
  "https://www.aozora.gr.jp/cards/000879/files/127_ruby_150.zip",
  "https://www.aozora.gr.jp/cards/000879/files/72_ruby_362.zip",
  "https://www.aozora.gr.jp/cards/000879/files/3800_ruby_27201.zip",
  "https://www.aozora.gr.jp/cards/000879/files/65_ruby_1386.zip",
  "https://www.aozora.gr.jp/cards/000879/files/80_ruby_753.zip"
)

# 太宰治
# 朝, あさましきもの, 兄たち, 嘘, 女の決闘, きりぎりす, 走れメロス, 人間失格, 創世記, 惜別
book2 = c(
  "https://www.aozora.gr.jp/cards/000035/files/1562_ruby_14574.zip",
  "https://www.aozora.gr.jp/cards/000035/files/240_ruby_2332.zip",
  "https://www.aozora.gr.jp/cards/000035/files/239_ruby_20002.zip",
  "https://www.aozora.gr.jp/cards/000035/files/2254_ruby_20133.zip",
  "https://www.aozora.gr.jp/cards/000035/files/304_ruby_2876.zip",
  "https://www.aozora.gr.jp/cards/000035/files/1571_ruby_20539.zip",
  "https://www.aozora.gr.jp/cards/000035/files/1567_ruby_4948.zip",
  "https://www.aozora.gr.jp/cards/000035/files/301_ruby_5915.zip",
  "https://www.aozora.gr.jp/cards/000035/files/2279_ruby_2241.zip",
  "https://www.aozora.gr.jp/cards/000035/files/2277_ruby_4166.zip"
)



source("http://rmecab.jp/R/Aozora.R")
# 本の内容を取得
get_data <- function(books) {
  for(b in 1:length(books)) {
    Aozora(books[b])
  }
}

get_data(book2)
