#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # create ML model 
    model <- train(Species~ .,data=iris[3:5],method="rf",prox=TRUE)
    
    # predict
    modelPred <- reactive({
      predict(model, newdata = data.frame(Petal.Length = input$petal_length/10,
                                          Petal.Width = input$petal_width/10))  
    })
    
    
    output$plot <- renderPlot({
        
        # plot data points
        p <- qplot(Petal.Width, Petal.Length, col=Species,data=iris)
       
        # add user point
        p <- p + geom_point(x = (input$petal_width)/10, y = (input$petal_length)/10, col = "black", size = 5, shape = 10)
        
        return(p)
    })
    
    output$species <- renderText({
        pred <- modelPred()
        if (pred=="setosa") {species <- "Setosa"}
        else if (pred == "versicolor") {species <- "Versicolor"}
        else if (pred == "virginica") {species <- "Virginica"}
        return(species)
    })
    

})
