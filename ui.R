shinyUI(fluidPage(
  titlePanel("Distribution of the Swedish election 2014"),
    sidebarPanel(
      uiOutput("choose_data"),
      uiOutput("choose_county"),
      a(href = "http://www.val.se/val/val2014/statistik/", "Valmyndigheten 2017")),
    mainPanel(
      plotOutput("output_plot"),
      tableOutput("output_table")
   )
  )
)
