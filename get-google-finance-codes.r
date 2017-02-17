

## 下载的话，这个办法也行
## library(downloader)
## download("https://www.quandl.com/api/v3/databases/GOOG/codes", dest="allcode.zip", mode="wb") 
## unzip ("allcode.zip", exdir = "./wstudio")


library(readr)
temp <- tempfile()
download.file("https://www.quandl.com/api/v3/databases/GOOG/codes",temp)
## unz是解压缩函数
## 这里解压后的文件名GOOG-datasets-codes.csv不是任意取的
## 通过原始数据链接https://www.quandl.com/api/v3/databases/GOOG/codes 下载压缩包，
## 压缩包解压出来的文件名就是GOOG-datasets-codes.csv
## 也就是说unz函数的第二个参数，必须与原始压缩包内的文件名一致
google_finace_codes = read_csv(unz(temp, "GOOG-datasets-codes.csv"),col_names = FALSE)
unlink(temp)

colnames(google_finace_codes) = c("code","name")

google_finace_codes$label = substr(google_finace_codes$code,1,8)

library(dplyr)
cn_stock_code = filter(google_finace_codes, label == "GOOG/SHA" | label == "GOOG/SHE") 


## 这里必须用cn_stock_code[,1]，而不能用cn_stock_code$code
## 因为cn_stock_code[,1]的结果是dataframe,而cn_stock_code$code的结果是向量
## 在后面生成majorcode的操作中，codelist必须要是dataframe才能有[]运算
codelist = cn_stock_code[,1]


## delete startup(300),B stock(200,900),index(399,000)
delcode = c("300","200","399","000","900")
majorcode = codelist[-which(substring(codelist$code,10,12) %in% delcode),]

## add shangzheng index
majorcode = rbind(majorcode,'GOOG/SHA_000001')
## add shenzheng index
majorcode = rbind(majorcode,'GOOG/SHE_399001')

save(majorcode,file="课程代码.csv")
