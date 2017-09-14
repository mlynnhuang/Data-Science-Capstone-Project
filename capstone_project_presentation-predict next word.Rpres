Data Science Capstone Project  - Predict Next Word using N-gram Lookup Tables
========================================================
author: Lynn Huang
date: September 13, 2017
autosize: true

Introduction
========================================================
The objective of the Data Science Capstone project is to build a data product that predicts next word when a smartphone user enters a text string (e.g. an incomplete phrase, or an incomplete sentence). An example of such application in commercial products is SwiftKey. 
The data product will be running on Shiny.io, a web application deployment environment. The data product shown in this project is by no means an impeccable product, but rather a simple application to show my efforts of learning and applying data science knowledge to solve a practical problem in Natural Language Processing (NLP).  


Data Exploration and Preprocessing
========================================================
The data provided by the Capstone project is a large corpus of text documents containing three files of blogs, news and twitters, all in English language, which has more than four million lines and more than 100 million words in total. Due to the machine's resource limitation, 10% of the corpus was sampled in this project.

  In order to make better prediction, the following data cleaning steps (transformations) are applied to the text.

- conversion to lower case
- removal of non-English characters
- removal of numbers
- removal of punctuation
- removal of stop words
- removal profinity words

Creation of N-gram document feature matrix (dfm)
========================================================
According to Wikipedia, N-gram is a contiguous sequence of n items from a given sequence of text or speech. Unigram, bigram, trigram, and quadgram refer to n-gram with n=1 (one word), 2 (two-word), 3 (three-word), 4 (four-word) respectively.  

   An intermediate step to tokenize the corpus while performing the above mentioned data cleanning was taken before an n-gram document frequency matrix was generated (also called document-feature matrix,which holds frequencies of ngram in the document).  The intermediate step has been observed to improve the speed of n-gram generation dramatically. Matrixes with bigram, trigram and quadgram with frequency > 1 (more than one occurance) are created and saved to disk for future manipulation.  These ngrams (1-4 grams) will become system dictionary for the next word prediction.  

Algorithm of Predicting Next Word
========================================================
A simple back-off model is used to predict the next word. 
  
  If the text entered by a user after the data cleaning has more than three words, the model will try to match the last three words in the quadgram (4-word) lookup table. If there is a match, the fourth word of the 4-word phrase with the highest frequency in the quadgram lookup table will be returned as the next word predicted. If such match does not exist, the model will back off to n-1 gram, the trigram (3-word) lookup table.  THe model will try to match the last two words in the trigram lookup table.  If the match is found, the third word in the 3-word phrase with highest frequency  in the trigram lookup table  will be returned as the next word predicted. If there is no such match, the model will back off to bigram (2-word) searching with the same procedure. If no match found, the system will return a message as "can not predict next word".  When the text a user enters has two words after the data cleanning, the model will start with trigram, then backoff to bigram if necessary.
  
  In order to compare the text entered by the user to the ngram lookup table, the text entered must be transformed using the same cleaning methods such as conversion to lower case, removal of numbers, punctuation, stopwords juar like the corpus.  In order for the match algorithm to work, the ngram matrix is transformed to a data table where n-gram (n-word) were split and converted to first n columns, with its frequency as the last column (column n+1).

Shiny App Demo
========================================================
The Shiny App is running on 

https://mlynnhuang.shinyapps.io/capstone-final/

  The title of the App is 

DATA SCIENCE CAPSTONE - PREDICT NEXT WORD
  
  
  The left panel consists of an instruction,
  
"ENTER TEXT HERE, WORD, PHRASE OR INCOMPLETE SENTENCE", 
  
  and a text box, with a label of "PLEASE ENTER:", where user can type the text. 
  
  
On the right panel (main panel),  
underneath the header of "WORD / TEXT / SENTENCE ENTERED:"
the text entered by the user (before data cleanning) is displayed in red


Underneath the header of "SEARCHING N-GRAMS TO SHOW NEXT WORD: "

If there is a match, a message with specific ngram used will be displayed in red, e.g, "Trying to Predict Next Word Using Bigram".

If no match, "can not predict next word" message will be displayed.

