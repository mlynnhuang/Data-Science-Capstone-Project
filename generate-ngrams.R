##Down load the data and unzip

rm(list=ls())

sfile <-"https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(sfile, destfile='CS.zip')
unzip(zipfile = "CS.zip")

##Install required packages
install.packages("stringi")
install.packages("quanteda")
library(stringi)
library(quanteda)

##Go to the directory where the above files are saved
t1 <- Sys.time()
setwd("~/final/en_US")
con1 <- file("en_US.blogs.txt", open = "rb")
us_b <- readLines(con1, encoding = "UTF-8", skipNul = TRUE)
close(con1)
con2 <- file("en_US.news.txt", open = "rb")
us_n <- readLines(con2, encoding = "UTF-8", skipNul = TRUE)
close(con2)
con3 <- file("en_US.twitter.txt", open = "rb")
us_t <- readLines(con3, encoding = "UTF-8", skipNul = TRUE)
close(con3)

##Sample the files with percent variable, then combine the three files 
set.seed(12345)
percent <- 10/100
us_b_sub <- sample(us_b, size=length(us_b)*percent, replace=FALSE)  
us_n_sub <- sample(us_n, size=length(us_n)*percent, replace=FALSE)  
us_t_sub <- sample(us_t, size=length(us_t)*percent, replace=FALSE)  
us_sub <- c(us_b_sub, us_n_sub, us_t_sub)  
rm(us_b_sub)
rm(us_n_sub)
rm(us_t_sub)

##Write the big file to disk
writeLines(us_sub, "~/final/en_US/us_sub.txt")

##Start the clean-up process
setwd("~")
suppressMessages(library(quanteda))
#Remove the wierd words
us_sub <- iconv(us_sub, from="UTF-8", to="ASCII", sub="")
us_sub <- gsub("\\s"," ",us_sub) 
#Obtain the profanity list from a website
profanity <- read.table("http://www.bannedwordlist.com/lists/swearWords.txt")
profanity<-as.character(profanity[,1])

#Tokenize the text and Clean up the text before ngram
tokensAll <- tokens(char_tolower(us_sub), remove_punct =TRUE,remove_numbers=TRUE)
tokensNoStopwords <- removeFeatures(tokensAll, stopwords("english")) 

#Generate unigram and save to the disk
onegrams<-dfm(tokensNoStopwords)
onegrams <- dfm_select(onegrams, profanity, selection = "remove", 
                         valuetype = "fixed", verbose= FALSE)
saveRDS(onegrams,file = "~/final/en_US/myonegrams.RData")
rm(onegrams)

#Generate bigram and save to the disk
tokensNgramsNoStopwords_2 <- tokens_ngrams(tokensNoStopwords, n=2,concatenator = " " )
twograms<-dfm(tokensNgramsNoStopwords_2)
twograms <- dfm_select(twograms, profanity, selection = "remove", 
                                                valuetype = "fixed", verbose= FALSE)
saveRDS(twograms,file = "~/final/en_US/mytwograms.RData")
rm(twograms)

#Generate trigram and save to the disk
tokensNgramsNoStopwords_3 <- tokens_ngrams(tokensNoStopwords, n=3,concatenator = " " )
threegrams<-dfm(tokensNgramsNoStopwords_3)
threegrams <- dfm_select(threegrams, profanity, selection = "remove", 
                         valuetype = "fixed", verbose= FALSE)
saveRDS(threegrams,file = "~/final/en_US/mythreegrams.RData")
rm(threegrams)

#Generate qudragram and save to the disk 
tokensNgramsNoStopwords_4 <- tokens_ngrams(tokensNoStopwords, n=4,concatenator = " " )
fourgrams<-dfm(tokensNgramsNoStopwords_4)
fourgrams <- dfm_select(fourgrams, profanity, selection = "remove", 
                         valuetype = "fixed", verbose= FALSE)
saveRDS(fourgrams,file = "~/final/en_US/myfourgrams.RData")
rm(fourgrams)

print(difftime(Sys.time(), t1, units = 'sec'))


