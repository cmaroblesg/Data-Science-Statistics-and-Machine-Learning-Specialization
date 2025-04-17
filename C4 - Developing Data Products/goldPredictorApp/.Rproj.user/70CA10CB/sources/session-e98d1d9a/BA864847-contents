library(shiny)
library(quantmod)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output, session) {
  # 1. Fetch daily GLD ETF prices from Yahoo
  gld_xts <- getSymbols("GLD", src = "yahoo", auto.assign = FALSE)
  
  # 2. Convert to a data.frame and compute annual average
  gld_df <- data.frame(
    date  = index(gld_xts),
    price = as.numeric(Cl(gld_xts))
  ) %>%
    mutate(year = as.integer(format(date, "%Y"))) %>%
    group_by(year) %>%
    summarize(price = mean(price, na.rm = TRUE)) %>%
    ungroup()
  
  # 3. Fit linear model once
  model <- lm(price ~ year, data = gld_df)
  
  # 4. Reactive prediction based on input$year
  pred_price <- reactive({
    newdata <- data.frame(year = input$year)
    round(predict(model, newdata), 2)
  })
  
  # 5. Render predicted price
  output$gold_pred <- renderText({
    pred_price()
  })
  
  # 6. Render plot of historical data + prediction point
  output$gold_plot <- renderPlot({
    # Base plot of historical averages
    p <- ggplot(gld_df, aes(x = year, y = price)) +
      geom_point(color = "goldenrod", size = 2) +
      geom_smooth(method = "lm", se = FALSE, color = "darkgoldenrod") +
      labs(
        title = "Annual Average GLD ETF Price vs Year",
        x     = "Year",
        y     = "GLD Avg. Close (USD)"
      ) +
      theme_minimal()
    
    # Add your single prediction point
    p + annotate(
      "point",
      x     = input$year,
      y     = pred_price(),
      color = "red",
      size  = 4
    )
  })
})