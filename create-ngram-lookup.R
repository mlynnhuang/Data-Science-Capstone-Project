setwd("~/final/en_US")
install.packages("dplyr")
library(dplyr)

t1 <- Sys.time()

##Load ngrams from the disk
twograms<-readRDS("~/final/en_US/mytwograms.RData")
threegrams<-readRDS("~/final/en_US/mythreegrams.RData")
fourgrams<-readRDS("~/final/en_US/myfourgrams.RData")

##Generate Feature-Frequency Tables, save tables to 

docfreq2 <- quanteda::docfreq(twograms,  scheme = "count")
docfreq.two <-  data.table::as.data.table(docfreq2, key=names(docfreq2),  keep.rownames=T)
docfreq.two <- docfreq.two[order(-docfreq2)]
names(docfreq.two)[1]<-paste("word")
names(docfreq.two)[2]<-paste("freq")
#write.csv(docfreq.two[docfreq.two$freq > 1,],"~/final/en_US/twograms.csv",row.names=F)

docfreq3 <- quanteda::docfreq(threegrams,  scheme = "count")
docfreq.three <-  data.table::as.data.table(docfreq3, key=names(docfreq3),  keep.rownames=T)
docfreq.three <- docfreq.three[order(-docfreq3)]
names(docfreq.three)[1]<-paste("word")
names(docfreq.three)[2]<-paste("freq")
#write.csv(docfreq.three[docfreq.three$freq > 1,],"~/final/en_US/threegrams.csv",row.names=F)


docfreq4 <- quanteda::docfreq(fourgrams,  scheme = "count")
docfreq.four <-  data.table::as.data.table(docfreq4, key=names(docfreq4),  keep.rownames=T)
docfreq.four <- docfreq.four[order(-docfreq4)]
names(docfreq.four)[1]<-paste("word")
names(docfreq.four)[2]<-paste("freq")
#write.csv(docfreq.four[docfreq.four$freq > 1,],"~/final/en_US/fourgrams.csv",row.names=F)

##Split the the column of n-word phrases into n columns of individual words
bigram<-docfreq.two
bigram$word <- as.character(bigram$word)
bigram_split <- strsplit(as.character(bigram$word),split=" ")
bigram <- transform(bigram,firstwd = sapply(bigram_split,"[[",1),secondwd = sapply(bigram_split,"[[",2))
bigram <- data.frame(firstwd = bigram$firstwd,
                     secondwd = bigram$secondwd, 
                     freq = bigram$freq, stringsAsFactors=FALSE)
write.csv(bigram[bigram$freq > 1,],"~/final/en_US/bigram.csv",row.names=F)
bigram <- read.csv("~/final/en_US/bigram.csv",stringsAsFactors = F)
saveRDS(bigram,"~/final/en_US/bigram.RData")
rm(bigram)

trigram<-docfreq.three
trigram$word <- as.character(trigram$word)
trigram_split <- strsplit(as.character(trigram$word),split=" ")
trigram <- transform(trigram,firstwd = sapply(trigram_split,"[[",1),secondwd = sapply(trigram_split,"[[",2),thirdwd = sapply(trigram_split,"[[",3))
trigram <- data.frame(firstwd = trigram$firstwd,
                      secondwd = trigram$secondwd, 
                      thirdwd = trigram$thirdwd, 
                      freq = trigram$freq, stringsAsFactors=FALSE)
write.csv(trigram[trigram$freq > 1,],"~/final/en_US/trigram.csv",row.names=F)
trigram <- read.csv("~/final/en_US/trigram.csv",stringsAsFactors = F)
saveRDS(trigram,"~/final/en_US/trigram.RData")
rm(trigram)


quadgram<-docfreq.four
quadgram$word <- as.character(quadgram$word)
quadgram_split <- strsplit(as.character(quadgram$word),split=" ")
quadgram <- transform(quadgram,firstwd = sapply(quadgram_split,"[[",1),secondwd = sapply(quadgram_split,"[[",2),thirdwd = sapply(quadgram_split,"[[",3), fourthwd = sapply(quadgram_split,"[[",4))
quadgram <- data.frame(firstwd = quadgram$firstwd,
                       secondwd = quadgram$secondwd, 
                       thirdwd = quadgram$thirdwd, 
                       fourthwd = quadgram$fourthwd, 
                       freq = quadgram$freq, stringsAsFactors=FALSE)
write.csv(quadgram[quadgram$freq > 1,],"~/final/en_US/quadgram.csv",row.names=F)
quadgram <- read.csv("~/final/en_US/quadgram.csv",stringsAsFactors = F)
saveRDS(quadgram,"~/final/en_US/quadgram.RData")
rm(quadgram)


print(difftime(Sys.time(), t1, units = 'sec'))

