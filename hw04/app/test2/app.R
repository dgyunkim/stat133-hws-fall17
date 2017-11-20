library(shiny)
library(readr)
library(dplyr)
library(ggvis)

# load data set
mydat <- read_csv("../../data/cleandata/cleanscores.csv")

# variable names for scatterplot
plot_name <- colnames(mydat)

# remove "Grade" variable
plot_name <- plot_name[-length(plot_name)]

ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("select1", label = h4("X-axis variable"), 
                  choices = plot_name, selected = "Test1"),
      
      selectInput("select2", label = h4("Y-axis variable"), 
                  choices = plot_name, selected = "Overall"),
      
      sliderInput("opacity",
                  "Opacity",
                  min = 0.0,
                  max = 1.0,
                  value = 0.5),
      
      radioButtons("line", label = h4("Show line"),
                   choices = c("none", "lm", "loess"), 
                   selected = "lm")
    ),
    
    mainPanel(
      
      ggvisOutput("scatterPlot"),
      
      h4("Correlation"),
      verbatimTextOutput("correlation")
      
    )
  )
)

server <- function(input, output) {
  
  vis_scatterPlot <- reactive({
    
    select1 <- prop("x", as.symbol(input$select1))
    select2 <- prop("y", as.symbol(input$select2))
    
    if (input$line == "none"){
      
      mydat %>%
        ggvis(x = select1, y = select2) %>%
        layer_points(fill := "#89a3a6", opacity := input$opacity)
      
    } else {
      
      mydat %>%
        ggvis(x = select1, y = select2) %>%
        layer_points(fill := "#89a3a6", opacity := input$opacity) %>%
        layer_model_predictions(model = input$line, stroke := "#893a6a")
    }
      
  })
  
  vis_scatterPlot %>% bind_shiny("scatterPlot")
  
  output$correlation <- renderPrint({
    
    cat(cov(mydat[[input$select1]], mydat[[input$select2]]) /
      (sd(mydat[[input$select1]]) * sd(mydat[[input$select2]])))
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)