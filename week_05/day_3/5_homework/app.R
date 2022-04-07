library(shiny)
library(here)
library(tidyverse)
library(ggplot2)
library(shinythemes)

amazon_reviews <- read_csv(here("data/amazon_reviews.csv"))

product_list <- unique(amazon_reviews$name)

#### THERES A LOT TO DO FOR THE PLOTS, WAS FOCUSING MORE ON FUNCTIONALITY OF SHINY ####

ui <- fluidPage(
  
  theme = shinytheme("yeti"),
  
  titlePanel(
    "Reviews of Amazon products"
  ),
  
  br(),
  br(),
  
  sidebarLayout(
    
    sidebarPanel(
      
      plotOutput("plot_reviews")
      
    ),
    
    tabsetPanel(
      
      id = "name_input",
      
      tabPanel(title = "Amazon Kindle", value = "Kindle", plotOutput("plot_kindle")),
      tabPanel(title = "Amazon Echo", value = "Echo", plotOutput("plot_echo")),
      tabPanel(title = "Amazon Fire Tablet", value = "Fire Tablet", plotOutput("plot_fire"))

    )
  )
)

server <- function(input, output, session) {
  
  output$plot_reviews <- renderPlot({
    
    amazon_reviews %>%
      filter(name == input$name_input) %>%
      ggplot() +
      aes(x = date, y = rating) +
      geom_smooth() +
      theme_minimal()
    
  })
  
  output$plot_kindle <- renderPlot({
    
    amazon_reviews %>%
      filter(name == "Kindle") %>%
      ggplot() +
      aes(x = date) +
      geom_histogram() +
      labs(title = "number of reviews") +
      coord_flip() +
      # labs(x = "\nteam",
      #      y = "number of medals\n") +
      # scale_fill_manual(values = c("Gold" = "#FFD700", "Silver" = "#C0C0C0", "Bronze" = "#CD7F32")) +
      theme_minimal()
    
  })
    
  output$plot_echo <- renderPlot({
    
    amazon_reviews %>%
      filter(name == "Echo") %>%
      ggplot() +
      aes(x = date) +
      geom_histogram() +
      labs(title = "number of reviews") +
      coord_flip() +
      # labs(x = "\nteam",
      #      y = "number of medals\n") +
      # scale_fill_manual(values = c("Gold" = "#FFD700", "Silver" = "#C0C0C0", "Bronze" = "#CD7F32")) +
      theme_minimal()
    
  })
  
  output$plot_fire <- renderPlot({
    
    amazon_reviews %>%
      filter(name == "Fire Tablet") %>%
      ggplot() +
      aes(x = date) +
      geom_histogram() +
      labs(title = "number of reviews") +
      coord_flip() +
      # labs(x = "\nteam",
      #      y = "number of medals\n") +
      # scale_fill_manual(values = c("Gold" = "#FFD700", "Silver" = "#C0C0C0", "Bronze" = "#CD7F32")) +
      theme_minimal()
    
  })
  
}

shinyApp(ui, server)