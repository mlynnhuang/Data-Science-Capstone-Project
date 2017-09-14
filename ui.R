library(shiny)
library(markdown)

## SHINY UI
shinyUI(
  fluidPage(
    titlePanel("DATA SCIENCE CAPSTONE - PREDICT NEXT WORD"),
    sidebarLayout(
      sidebarPanel(
        helpText("ENTER TEXT HERE, WORD, PHRASE OR INCOMPLETE SENTENCE"),
        hr(),
        textInput("inputText", "PLEASE ENTER:",value = ""),
        hr(),
        hr(),
        hr()
      ),
      mainPanel(
        strong("WORD / TEXT / SENTENCE ENTERED:"), 
        strong(code(textOutput('sentence1'))),
        br(),
        strong("SEARCHING N-GRAMS TO SHOW NEXT WORD:"),
        strong(code(textOutput('sentence2'))),
        br(),
        h2("DISPLAY THE PREDICTED NEXT WORD"),
        verbatimTextOutput("prediction"),
        hr(),
        hr(),
        hr()
      )
    )
  )
)
