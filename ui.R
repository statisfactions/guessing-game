library(shiny)
library(ggplot2)


shinyUI(pageWithSidebar(

    headerPanel("Guessing Game"),

    sidebarPanel(
        radioButtons('color', "Loading, please wait...", c(" "= "")),
        conditionalPanel(
            condition = "input.color == 'red' || input.color == 'green'",
            actionButton("counter", "Show Next")
            )      
        ),

    mainPanel(
        plotOutput("predictionplot")

        )
    ))
