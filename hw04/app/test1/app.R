library(shiny)
library(dplyr)
library(readr)
library(ggvis)

# load data set
mydat <- read_csv("../../data/cleandata/cleanscores.csv")

# creat grade data frame
grade <- mydat %>%
  group_by(Grade) %>%
  summarise(Freq = table(Grade))
grade$Prop <- round(prop.table(grade$Freq), digit = 2)

grade <- as.data.frame(grade)

# reorder rows of the data frame
grade_A <- grade[1,]
grade_B <- grade[4,]
grade_C <- grade[7,]
grade[1,] <- grade[3,]
grade[3,] <- grade[2,]
grade[2,] <- grade_A
grade[4,] <- grade[6,]
grade[6,] <- grade[5,]
grade[5,] <- grade_B
grade[7,] <- grade[9,]
grade[9,] <- grade[8,]
grade[8,] <- grade_C


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Grade Visualizer"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     
     sidebarPanel(
       h4("Grade distribution"),
       tableOutput("grade")
    
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         ggvisOutput("barchart")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   vis_barchart <- reactive({
     grade %>%
       ggvis(~Grade, ~Freq) %>%
       layer_bars(fill := '#89a3a6') %>%
       scale_ordinal('x', domain = c('A+', 'A', 'A-', 'B+', 'B', 'B-', 
                                     'C+', 'C', 'C-', 'D', 'F')) %>%
       add_axis('y', title = 'frequency')
   })
   
   vis_barchart %>% bind_shiny("barchart")
   
   output$grade <- renderTable({
     grade
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

