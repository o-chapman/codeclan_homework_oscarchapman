library(shiny)
library(here)
library(tidyverse)
library(ggplot2)
library(shinythemes)

amazon_reviews <- read_csv(here("data/amazon_reviews.csv"))

product_list <- unique(amazon_reviews$name)

ui <- fluidPage(
  
  theme = shinytheme("yeti"),
  
  mainPanel(
    
    tabsetPanel(
      
      id = "name_input",
      
      tabPanel(title = "Amazon Kindle", value = "Kindle", plotOutput("plot")), 
      tabPanel(title = "Amazon Echo", value = "Echo", plotOutput("plot")), 
      tabPanel(title = "Amazon Fire Tablet", value = "Fire Tablet", plotOutput("plot"))

    )
  )
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    
    amazon_reviews %>%
      filter(name == input$name_input) %>%
      ggplot() +
      aes(x = date, y = rating) +
      geom_point() +
      # labs(x = "\nteam",
      #      y = "number of medals\n") +
      # scale_fill_manual(values = c("Gold" = "#FFD700", "Silver" = "#C0C0C0", "Bronze" = "#CD7F32")) +
      theme_minimal() +
      theme(legend.position = "none")
      
  })
}

shinyApp(ui, server)