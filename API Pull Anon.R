### TICKER FUNNESS -- 

# 2/21/2017 (CW) -- 


library(httr)
#library(RODBC) 
library(xlsx)

#dbhandle <- odbcDriverConnect('driver={SQL Server};server=meowmeowdb;database=LM;trusted_connection=true')
url <- "fakefakeURL.com"
key <- as.character("fake-fake-key")

# securities must be a data.frame with only 2 columns, idType and idValue - max 100 requests at a time
sec <- read.csv("task954corpstest.csv", header = TRUE)
securities <- sec[,1:2]

apirequest <- POST(url, body = securities, encode = "json", add_headers("X-OPENFIGI-APIKEY" = "fake-fakfe-key"), verbose())
apirequestP <- content(apirequest, as = "parsed")
sdata <- sapply(apirequestP,unlist)

#sdata[[1]][["data.ticker"]]

tickers <- c()
for (i in 1:length(sdata)) { 
  test <- try(sdata[[i]][["data.ticker"]], silent=T) 
  if(is(test,"try-error")) {test = NA} 
  tickers <- append(tickers,test)
} 

#tickers
tickerss <- sapply(strsplit(tickers, " "), "[", 1)

final <- cbind(sec, tickerss)

write.xlsx(final, "task954corpstest.xlsx")



