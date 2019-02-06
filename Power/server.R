#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(scales)

# Define server logic required to draw the power plot.
shinyServer(function(input, output) {
  
  output$power <- renderText({
    sem <- input$sigma / (input$n)^0.5
    z <- qnorm(1 - input$alpha, sd=sem, mean=0)  # Calculate from p-value for null hypothesis
    power <- pnorm(z, sd=sem, mean=input$mu, lower.tail = FALSE)
    return(paste("The power for this set of parameters is ", percent(power), "."))
  })
   
  output$powerPlot <- renderPlot({
    # Interpret our inputs
    sem <- input$sigma / (input$n)^0.5
    
    # Generate null and alternative hypothesis data
    x <- seq(-2, 8, 0.01)
    xrange <- c(-2, 8)
    yrange <- c(0, 1)
    null_hypo <- dnorm(x, sd = sem)
    alt_hypo <- dnorm(x, sd = sem, mean = input$mu)
    
    # Calculate the p value
    z <- qnorm(1 - input$alpha, mean=0, sd = sem)
    
    # Generate plot
    plot(xrange, yrange, xlim = xrange, col = rgb(red=1, green=1, blue=1, alpha=0),
         xlab = "X", ylab = "f(x)")
    lines(x = x, y = null_hypo)
    lines(x = x, y = alt_hypo)
    lines(x = x, y = x*0)
    title("Power as a result of parameters")
    
    # Create data for the area to shade
    cord.x <- c(z ,seq(z,8,0.01),8) 
    cord.y <- c(0, dnorm(seq(z,8,0.01), sd=sem, mean=input$mu), 0) 
  
    # Add the shaded area.
    polygon(cord.x,cord.y,col='skyblue')
  })
  
})
