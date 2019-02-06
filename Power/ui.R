#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The Parameters of Power"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("n",
                   "Number of samples:",
                   min = 10,
                   max = 100,
                   value = 30),
       sliderInput("alpha",
                   "One-sided alpha value",
                   min = 0.001,
                   max = 0.20,
                   value = 0.05),
       sliderInput("sigma",
                   "Standard deviation",
                   min = 0.01,
                   max = 10,
                   value = 5),
       sliderInput("mu",
                   "Alternative hypothesis mean",
                   min = 0.5,
                   max = 10,
                   value = 4)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       p("Understanding what power actually refers to is notoriously complicated, with many parameters at play. Here, you can play with the parameters and see the results yourself."),
       strong("Instructions"),
       p("1. From the sliders on the left, set the parameters you wish to use to calculate power. The highlighted portion of the rightmost distribution indicates the power of the alternative hypothesis."),
       p("2. The power is also given numerically below the plot."),
       HTML("<p>Confused? It might be worthwhile to brush up on <a href='https://www.coursera.org/learn/statistical-inference/'>Coursera's stats course.</a>"),
       plotOutput("powerPlot"),
       textOutput("power")
    ),
  )
))
