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
        return(list(actual = actual, prediction = prediction))
    })

    output$predictionplot <- renderPlot({
        all <- county()
         
        plot(c(1,51), 0:1, type = "n")

        redpred <- all$prediction$number[prediction$color %in% "red"]
        redact <-  all$actual$number[actual$color %in% "red"]

        greenpred <- all$prediction$number[prediction$color %in% "green"]
        greenact <-  all$actual$number[actual$color %in% "green"]

        if(length(redpred) > 0)
            rect(redpred, 0.5, redpred+1, 1, col = "dark red")
        if(length(redact) > 0)
            rect(redact, 0, redact+1, 0.5,  col = "dark red")
        if(length(greenpred) > 0)
            rect(greenpred, 0.5, greenpred+1, 1,  col = "light green")
        if(length(greenact) > 0)
            rect(greenact, 0, greenact+1, 0.5,  col = "light green")
        
    }, width = 650, height = 400)

    })
