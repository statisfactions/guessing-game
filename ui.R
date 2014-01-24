library(shiny)


shinyUI(pageWithSidebar(

    headerPanel("Guessing Game"),

    sidebarPanel(
        radioButtons( "color", "Prediction of Next Color", c('(Please select an option below)' = 'none', 'Dark Red' = 'red', 'Light Green' = 'green'), selected = '(Please select an option below)')
        ),

    mainPanel(
        verbatimTextOutput("counts"),
        plotOutput("predictionplot")
        )
    ))
