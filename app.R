#' ---
#' title: 'Data Product'
#' author: "Joel John"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' ## Shiny App 
#' This script creates a Shiny App that takes a word or phrase input in a text box
#' and outputs the a predicted next word. 

library(shiny)
suppressPackageStartupMessages({
   library(tidyverse)
   library(stringr)
  library(shinyWidgets)
 })

#' Source ngram matching function
source("ngram.R")

#' Define UI for application that draws a histogram
ui <- fluidPage(
  # use a gradient in background
  setBackgroundColor(
    color = c("#F7FBFF", "#2171B5"),
    gradient = "linear",
    direction = "bottom"
  ),
   
   # Application title
   titlePanel("Prediction App"),
   p("Design and Development: Joel John"),
   p("As part of the Johns Hopkins University - Swiftkey Partnership Capstone Project"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h2("Follow simple steps to use this:"), 
        h5("1. Enter a word or words in the text box."),
        h5("2. The predicted next word prints below it in blue."),
        h5("3. No need to hit enter of submit."),
        h5("4. A question mark means no prediction, typically due to mis-spelling"),
        br(),
        a("Source Code", href = "https://github.com/jjx007/capstone")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("predict",
            textInput("user_input", h3("Input here:"), 
                    value = "Your words"),
            h3("Your next word should be:"),
            h4(em(span(textOutput("ngram_output"), style="color:darkblue")))),
        
          tabPanel("top quadgrams",
            br(),
            img(src = "quadgrams.png", height = 500, width = 700)),
        
          tabPanel("top trigrams",
            br(),       
            img(src = "trigrams.png", height = 500, width = 700)),
      
          tabPanel("top bigrams",
            br(),
            img(src = "bigrams.png", height = 500, width = 700))
          )   
    )
  )
)
#' Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$ngram_output <- renderText({
      ngrams(input$user_input)
  })
  
}
  
#' Run the application 
shinyApp(ui = ui, server = server)

