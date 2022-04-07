library(shiny)
library(tidyverse)

amazon_reviews <- CodeClanData::amazon_reviews

product_list <- unique(amazon_reviews$name)

ui <- fluidPage(
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot")), 
      tabPanel("Summary", verbatimTextOutput("summary")), 
      tabPanel("Table", tableOutput("table"))
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)