library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  titlePanel("Drawing Balls Experiment"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput("num",
                  "Number of repetitions:",
                  min = 1,
                  max = 5000,
                  value = 100),
      
      sliderInput("prob",
                  "Threshold for choosing boxes:",
                  min = 0,
                  max = 1,
                  value = 0.5),
      
      numericInput("seed",
                   "Choose a random seed",
                   min = 1,
                   max = 100000,
                   value = 12345)
    ),
    mainPanel(
      plotOutput("disPlot")
    )
  )
)

server <- function(input, output) {
  
  output$disPlot <- renderPlot({
    
    
    box1 <- c(rep("blue", 2), "red")
    box2 <- c(rep("blue", 2), rep("red", 3), "white")
    
    drawn_balls <- matrix(rep("", n = input$num * 4), ncol = 4, nrow = input$num)
    
    set.seed(input$seed)
    boxes <- c("box1", "box2")
    sample <- sample(boxes, size = 1, prob = c(input$prob, 1 - input$prob))
    
    set.seed(input$seed)
    for (i in 1 : input$num) {
      if (sample == "box1") {
        drawn_balls[i,] <- sample(box1, size = 4, replace = TRUE)
      } else {
        drawn_balls[i,] <- sample(box2, size = 4)
      }
    }
    blue0 <- rep(0, input$num) 
    blue1 <- rep(0, input$num)
    blue2 <- rep(0, input$num)
    blue3 <- rep(0, input$num)
    blue4 <- rep(0, input$num)
    
    prop_blue0 <- rep(0, input$num)
    prop_blue1 <- rep(0, input$num)
    prop_blue2 <- rep(0, input$num)
    prop_blue3 <- rep(0, input$num)
    prop_blue4 <- rep(0, input$num)
    
    for (i in 1:input$num) {
      
      sum <- sum(drawn_balls[i, ] == "blue") + 1
      
      switch(sum,
             blue0[i] <- 1,
             blue1[i] <- 1,
             blue2[i] <- 1,
             blue3[i] <- 1,
             blue4[i] <- 1
      )
      
      prop_blue0[i] <- sum(blue0) / i
      prop_blue1[i] <- sum(blue1) / i
      prop_blue2[i] <- sum(blue2) / i
      prop_blue3[i] <- sum(blue3) / i
      prop_blue4[i] <- sum(blue4) / i
    }
    
    dat <- data.frame(
      reps = 1 : input$num,
      prop_blue0,
      prop_blue1,
      prop_blue2,
      prop_blue3,
      prop_blue4
    )
    
    ggplot(dat, aes(x = reps)) +
      ggtitle("Relative frequencies of number of blue balls") +
      ylab("freqs") +
      geom_line(aes(y = prop_blue0, col = "red")) +
      geom_line(aes(y = prop_blue1, col = "blue")) +
      geom_line(aes(y = prop_blue2, col = "green")) +
      geom_line(aes(y = prop_blue3, col = "purple")) +
      geom_line(aes(y = prop_blue4, col = "yellow")) +
      scale_color_discrete(name = "number", labels = c("0", "1", "2", "3", "4"))
  })
}

shinyApp(ui = ui, server = server)

