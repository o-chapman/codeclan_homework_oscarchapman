library(tidyverse)
library(shinythemes)
library(shiny)

game_sales <- CodeClanData::game_sales

## MOST POPULAR PLATFORMS OVER THE PAST 20 YEARS
## tabPanel with graph of sales, critic, user score
## sidebar with choice of year range

get_means <- function(df) {
  df %>% 
  group_by(platform) %>% 
  summarise(mean_sales = mean(sales),
            mean_critic = mean(critic_score),
            mean_user = mean(user_score))
}


ui <- fluidPage(

    titlePanel("Most Popular Gaming Platforms"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("year_input",
                        "Range of years",
                        min = 1988,
                        max = 2016,
                        value = c(2000, 2004))
        ),

        mainPanel(
            tabsetPanel(
              tabPanel("Based on sales: ", plotOutput("sales_plot"))
              
              # tabPanel("Based on critic score: ", plotOutput("critic_plot")),
              # 
              # tabPanel("Based on user score: ", plotOutput("user_plot")),
              # 
              # tabPanel("Table", tableOutput("table_outpout"))
          )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  filtered_data <- reactive({
      game_sales %>%
        filter(year_of_release >= as.numeric(input$year_input[1]) &
               year_of_release <= as.numeric(input$year_input[2]))  
  })
  
  output$sales_plot <- renderPlot({
    get_means(filtered_data()) %>%
      ggplot() +
      aes(x = platform, y = mean_sales)
      geom_histogram()
  })
}

shinyApp(ui = ui, server = server)
