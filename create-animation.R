library(animation)

dat <-  sample(c(FALSE, FALSE, FALSE, TRUE), size = 50, replace = T)

interv <- 0.1

saveGIF({
for(i in dat) {
    dev.hold()
    plot(0:1, 0:1, type = "n", axes = F, xlab = NA, ylab = NA)
    ani.pause(interv * 0.3)
    plot(0:1, 0:1, type = "n", axes = F, xlab = NA, ylab = NA)
    ani.pause(interv * 0.3)
    if(!i)
        rect(0, 0, 1, 1, col = "light green")
    else
        rect(0, 0, 1, 1, col = "dark red")
    ani.pause(interv * 0.7)
}
}, movie.name = "animation.gif")
