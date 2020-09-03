#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(ggplot2)
library(randomForest)
library(e1071)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Find the species!"),
    h5("This app helps you identify the species of your iris flower based on petal measurements.
       The underlying classification model has been created using a machine learning algorithm on the \"iris\" dataset. 
       Now, all you need to do is introduce the petal width and length values in the sliders below and click submit."),
    br(),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("petal_length",
                        "Petal length [mm] :",
                        min = 10,
                        max = 70,
                        value = 30),
            sliderInput("petal_width",
                        "Petal width [mm] :",
                        min = 0,
                        max = 25,
                        value = 15),
            submitButton("Submit")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            HTML('<center><img src="species.jpg" width="300"></center>'),
            br(),
            plotOutput("plot"),
            br(),
            h4("Your species is..."),
            h1(textOutput("species"))
        )
    ))
)
