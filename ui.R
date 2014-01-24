library(shiny)
library(ggplot2)


shinyUI(pageWithSidebar(

    headerPanel("Guessing Game"),

    sidebarPanel(
        radioButtons( "color", "Prediction of Next Color", c('(Please select an option below)' = 'none', 'Dark Red' = 'red', 'Light Green' = 'green'), selected = '(Please select an option below)'),
        conditionalPanel(
            condition = "input.color == 'red' || input.color == 'green'",
            actionButton("counter", "Show Next")
            )      
        ),

    mainPanel(
        plotOutput("predictionplot")

        )
    ))
