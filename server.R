library(shiny)

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
        guess <- input$color
        isolate({
            curr <- sum(!is.na(actual$color)) + 1
            print(curr)
            if(curr <= n && (guess %in% c("red", "green"))) {
                curractual <<- sample(c("red", "green", "green", "green"), 1)
                actual$color[curr] <<- curractual
                prediction$color[curr] <<- guess
                
            }
            return(list(actual = na.omit(actual), prediction = na.omit(prediction)))
        })

    })

    output$counts <- renderText({
        all <- county()
        updateRadioButtons(session, "color", "Prediction of Next Color", c('(Please select an option below)' = 'none', 'Red' = 'red', 'Green' = 'green'), selected = '(Please select an option below)')

        isolate({
            len <-   sum(nrow(all$actual))
            correct <- sum(all$actual$color == all$prediction$color)
            pc <- round(correct*100/len)
            toprint <- paste0(ifelse(len >= n, "Game over.  Refresh your browser to play again.\n\n", ""),
                              "Total guesses: %i\nTotal correct: %i",
                              ifelse(len > 0, "\nPercentage correct: %i", ""))
            
            sprintf(toprint, len, correct, pc)

        })
        ## if(n > 0)
        ##     sprintf("Percentage correct: %i", pc)
    })

    output$predictionplot <- renderPlot({
        all <- county()
        
        isolate({
            plot(c(1,n +1), 0:1, type = "n", axes = F, xlab = NA, ylab = NA)
            axis(2, at = c(.25, .75), labels = c("Actual\nResult", "Your\nGuess"), tick = FALSE, las = 2)

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
        })
        
    }, width = 650, height = 400)

})
