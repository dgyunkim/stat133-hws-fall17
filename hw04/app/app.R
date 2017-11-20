library(shiny)
library(dplyr)
library(readr)
library(ggvis)

# load functions
source("../code/functions.R")

# load data set
mydat <- read_csv("../data/cleandata/cleanscores.csv")


# variable names for barchart, histogram, and scatterplot
var_name <- colnames(mydat)
# remove "Grade" variable
var_name <- var_name[-length(var_name)]

# create a new list for grade distribution
grade <- mydat %>%
  group_by(Grade) %>%
  count()
# add new Prop variable
grade$Prop <- round(prop.table(grade$n), digits = 2)
# convert list into data frame
grade <- as.data.frame(grade)
# change column name
colnames(grade) <- c("Grade", "Freq", "Prop")

# reorder rows of the data frame using temporary lists
grade_A <- grade[1,] # temporary list
grade_B <- grade[4,] # temporary list
grade_C <- grade[7,] # temporary list
grade[1,] <- grade[3,]
grade[3,] <- grade[2,]
grade[2,] <- grade_A
grade[4,] <- grade[6,]
grade[6,] <- grade[5,]
grade[5,] <- grade_B
grade[7,] <- grade[9,]
grade[9,] <- grade[8,]
grade[8,] <- grade_C

# remove temporary lists
rm(grade_A)
rm(grade_B)
rm(grade_C)


# define UI for application 
ui <- fluidPage(
  
  # application title
  titlePanel("Grade Visualizer"),
  
  # sidebar with conditional panels
  sidebarLayout(
    
    sidebarPanel(
      
      # sidebar panel of the first tab that shows grade distribution table
      conditionalPanel(condition = "input.tab==1",
                       h4("Grade Distribution"),
                       tableOutput("grade")),
      
      # sidebar panel of the second tab where users can select x variable of 
      # histogram and bin width
      conditionalPanel(condition = "input.tab==2",
                       selectInput(inputId = "select1", 
                                   label = h4("X-axis variable"),
                                   choices = var_name,
                                   selected = "HW1"),
                       sliderInput(inputId = "width",
                                   label = h4("Bin Width"),
                                   min = 1,
                                   max = 10,
                                   value = 10)),
      
      # sidebar panel of the third tab where users can select x and y variables
      # of scatter plot, value of opacity, and lines.
      conditionalPanel(condition = "input.tab==3",
                       selectInput(inputId = "select2",
                                   label = h4("X-axis variable"),
                                   choices = var_name,
                                   selected = "Test1"),
                       selectInput(inputId = "select3",
                                   label = h4("Y-axis variable"),
                                   choices = var_name,
                                   selected = "Overall"),
                       sliderInput(inputId = "opacity",
                                   label = h4("Opacity"),
                                   min = 0,
                                   max = 1,
                                   value = 0.5),
                       radioButtons(inputId = "line",
                                    label = h4("Show line"),
                                    choices = c("none",
                                                "lm",
                                                "loess"),
                                    selected = "lm"))
      ),
    
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  
                  # main panel of the first tab that shows barchart of grade distribution
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")),
                  
                  # mian panel of the second tab that shows histogram and summary statistics
                  tabPanel("Histogram", value = 2,
                           ggvisOutput("histogram"),
                           h4("Summary Statistics"),
                           verbatimTextOutput("summary")),
                  
                  # main panel of the third tab that shows scatterplot and correlation coefficient
                  tabPanel("Scatterplot", value = 3,
                           ggvisOutput("scatterplot"),
                           h4("Correlation"),
                           verbatimTextOutput("correlation")),
                  id = "tab")
      )
    )
)


server <- function(input, output) {
  
  # create table of grade distribution
  output$grade <- renderTable({
    grade
  })
  
  # create barchart of grade distribution
  vis_barchart <- reactive({
    
    grade %>%
      ggvis(~Grade, ~Freq) %>%
      layer_bars(fill := "#89a3a6") %>%
      add_axis("y", title = "frequency") %>%
      # reorder x variables
      scale_ordinal("x", domain = c("A+", "A", "A-", "B+", "B", "B-", 
                                    "C+", "C", "C-", "D", "F"))
    
  })
  
  # connect barchart with outputId "barchart"
  vis_barchart %>% bind_shiny("barchart")
  
  # create histogram of data variables
  vis_histogram <- reactive({
    
    select1 <- prop("x", as.symbol(input$select1))
    
    mydat %>%
      ggvis(x = select1) %>%
      layer_histograms(fill := "#89a3a6", width = input$width)
    
  })
  
  # connect histogram with outputId "histogram"
  vis_histogram %>% bind_shiny("histogram")
  
  # print summary statistics of data variables via outputId "summary"
  output$summary <- renderPrint({
   
    i <- switch(input$select1,
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
    
    print_stats(summary_stats(mydat[[i]]))})
    
  # create scatterplot of data variables
    vis_scatterplot <- reactive({
      
      select2 <- prop("x", as.symbol(input$select2))
      select3 <- prop("y", as.symbol(input$select3))
      
      if (input$line == "none") {
        
        mydat %>%
          ggvis(x = select2, y = select3) %>%
          layer_points(fill := "#89a3a6", opacity := input$opacity)
        
      } else {
        
        mydat %>%
          ggvis(x = select2, y = select3) %>%
          layer_points(fill := "#89a3a6", opacity := input$opacity) %>%
          layer_model_predictions(model = input$line, stroke := "#893a6a")
      }
      
    })
    
    # connect scatterplot with outputId "scatterplot"
    vis_scatterplot %>% bind_shiny("scatterplot")
    
    # print correlation coefficient via outputId "correlation"
    output$correlation <- renderPrint({
      
      cat(cov(mydat[[input$select2]], mydat[[input$select3]]) /
            (sd(mydat[[input$select2]]) * sd(mydat[[input$select3]])))
    })
  
}

# run the application
shinyApp(ui = ui, server = server)