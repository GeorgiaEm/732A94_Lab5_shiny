shinyUI(fluidPage(
  titlePanel("Distribution of the election 2014"),
    sidebarPanel(
      uiOutput("choose_dataset"),
      uiOutput("choose_columns"),
      br(),
      a(href = "http://www.val.se/val/val2014/statistik/", "Valmyndigheten 2017")),
    mainPanel(
      tableOutput("data_table"),
      plotOutput("distribution_plot")
   )
  )
)
