library(shiny)
library(ggplot2)
n <- 50
colormap <- c(red = "dark red", green = "light green")


shinyServer(function(input, output, session) {

    actual <- data.frame(
        number = 1:n,
        color = NA,
        type = "actual"
        )

    prediction <- data.frame(
        number = 1:n,
        color = NA,
        type = "prediction"
        )

    p <- ggplot(rbind(actual, prediction), aes(fill = color, xmin = 0, xmax = 1, ymin = 0, ymax = 1)) +
        geom_rect() + 
            coord_cartesian(0:1, 0:1) +
                facet_grid(type ~ number) +
                    scale_fill_manual(values = colormap) +
                        theme_bw() +
                            theme(legend.position = "none", axis.line=element_blank(),axis.text.x=element_blank(),
                                  axis.text.y=element_blank(),axis.ticks=element_blank(),
                                  axis.title.x=element_blank(),
                                  axis.title.y=element_blank()) 


    county <- reactive(function() {
        curr <- input$counter
        if(curr <= n)
            isolate({
                
                actual$color[curr] <<- sample(c("red", "green", "green", "green"), 1)
                prediction$color[curr] <<- input$color
                updateRadioButtons(session, "color", "Prediction of Next Color", c('(Please select an option below)' = 'none', 'Dark Red' = 'red', 'Light Green' = 'green'), selected = '(Please select an option below)')
            })
        return(rbind(actual, prediction))
    })

    output$predictionplot <- renderPlot({
        print(p %+% county())
    }, width = 650, height = 400)

    })
