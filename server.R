library(shiny)
library(ggplot2)
n <- 50
colormap <- c(red = "dark red", green = "light green")


shinyServer(function(input, output, session) {

    actual <- data.frame(
        number = 1:n,
        color = NA,
        type = "actual",
        current = FALSE
        )

    prediction <- data.frame(
        number = 1:n,
        color = NA,
        type = "prediction",
        current = FALSE
        )

    county <- reactive(function() {
        curr <- input$counter
        if(curr <= n)
            isolate({
                curractual <<- sample(c("red", "green", "green", "green"), 1)
                actual$color[curr] <<- curractual
                prediction$color[curr] <<- input$color
                updateRadioButtons(session, "color", "Prediction of Next Color", c('(Please select an option below)' = 'none', 'Dark Red' = 'red', 'Light Green' = 'green'), selected = '(Please select an option below)')
            })
        return(rbind(actual, prediction))
    })

    output$predictionplot <- renderPlot({
        plot(c(1,50), 0:1, type = "n")
    }, width = 650, height = 400)

    })
