library(shiny)
library(dplyr)
library(readr)
library(ggvis)

source("../code/functions.R")

# load data set
mydat <- read_csv("../data/cleandata/cleanscores.csv")

# variable names for histogram
hist_name <- colnames(mydat)
# remove "Grade" variable
hist_name <- hist_name[-length(hist_name)]


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h5("X-axis variable"), 
                  choices = hist_name, selected = "HW1"),
      sliderInput("width",
                  "Bind Width",
                  min = 1,
                  max = 10,
                  value = 10)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      ggvisOutput("histogram"),
      
      h4("Summary Statistics"),
      verbatimTextOutput("summary")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  vis_histogram <- reactive({
    select <- prop("x", as.symbol(input$select))
    mydat %>%
      ggvis(x = select) %>%
      layer_histograms(fill := '#89a3a6', width = input$width)
  })
  
  vis_histogram %>% bind_shiny("histogram")
  
  output$summary <- renderPrint({
    i <- switch(input$select,
                HW1 = 1,
                HW2 = 2,
                HW3 = 3,
                HW4 = 4,
                HW5 = 5,
                HW6 = 6,
                HW7 = 7,
                HW8 = 8,
                HW9 = 9,
                ATT = 10,
                QZ1 = 11,
                QZ2 = 12,
                QZ3 = 13,
                QZ4 = 14,
                EX1 = 15,
                EX2 = 16,
                Test1 = 17,
                Test2 = 18,
                Lab = 19,
                Homework = 20,
                Quiz = 21,
                Overall = 22)
    print_stats(summary_stats(mydat[[i]]))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)