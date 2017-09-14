
library(shiny); library(stringr); library(tm)

##Load ngram look-up tables 
bg <- readRDS("bigram.RData")
tg <- readRDS("trigram.RData")
qg <- readRDS("quadgram.RData")

message <- "" ## cleaning message

predictWord <- function(the_text) {
  text_cleaned <- stripWhitespace(removeNumbers(removePunctuation(tolower(the_text),preserve_intra_word_dashes = TRUE)))
  text_cleaned<- removeWords(text_cleaned,stopwords("English"))
  the_text <- strsplit(text_cleaned, " ")[[1]]
  n <- length(the_text)
  
  # check bigram
  if (n == 1) {the_text <- as.character(tail(the_text,1)); UseBigram(the_text)}
  
  # check trigram
  else if (n == 2) {the_text <- as.character(tail(the_text,2)); UseTrigram(the_text)}
  
  # check quadgram
  else if (n >= 3) {the_text <- as.character(tail(the_text,3)); UseQuadgram(the_text)}
}

#use bigram to predict 
UseBigram <- function(the_text) {
  if (identical(character(0),as.character(head(bg[bg$firstwd == the_text[1], 2], 1)))) {
    message<<-"If No Word Found, 'can not predict next word' is Returned" 
    as.character("can not predict next word")
  }
  else {
    message <<- "Trying to Predict Next Word Using Bigram"
    as.character(head(bg[bg$firstwd == the_text[1],2], 1))
  }
}
#use trigram to predict 
UseTrigram <- function(the_text) {
  if (identical(character(0),as.character(head(tg[tg$firstwd == the_text[1]
                                                  & tg$secondwd == the_text[2], 3], 1)))) {
    as.character(predictWord(the_text[2]))
  }
  else {
    message<<- "Trying to Predict Next Word Using Trigram"
    as.character(head(tg[tg$firstwd == the_text[1]
                         & tg$secondwd == the_text[2], 3], 1))
  }
}
#use quadragram to predict 
UseQuadgram <- function(the_text) {
  if (identical(character(0),as.character(head(qg[qg$firstwd == the_text[1]
                                                  & qg$secondwd == the_text[2]
                                                  & qg$thirdwd == the_text[3], 4], 1)))) {
    as.character(predictWord(paste(the_text[2],the_text[3],sep=" ")))
  }
  else {
    message <<- "Trying to Predict Next Word Using 4-gram"
    as.character(head(qg[qg$firstwd == the_text[1] 
                         & qg$secondwd == the_text[2]
                         & qg$thirdwd == the_text[3], 4], 1))
  } 
}

shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- predictWord(input$inputText)
    output$sentence2 <- renderText({message})
    result
  });
  output$sentence1 <- renderText({
    input$inputText});
}
)
