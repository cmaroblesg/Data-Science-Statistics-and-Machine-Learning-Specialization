library(shiny)

shinyUI(fluidPage(
  titlePanel("Gold Price Predictor"),
  sidebarLayout(
    sidebarPanel(
      helpText("Predict the average annual gold price (USD per ounce)."),
      numericInput("year", "Year:", 
                   value = 2022, min = 2000, 
                   max = as.numeric(format(Sys.Date(), "%Y")), step = 1)
    ),
    mainPanel(
      h3("Predicted Gold Price (USD/oz):"),
      verbatimTextOutput("gold_pred"),
      plotOutput("gold_plot"),
      br(),
      p("App created on ", strong(format(Sys.Date(), "%B %d, %Y")), ".")
    )
  )
))
