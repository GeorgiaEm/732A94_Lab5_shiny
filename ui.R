shinyUI(fluidPage(
  titlePanel("Distribution of the Swedish election 2014"),
    sidebarPanel(
      uiOutput("choose_data"),
      uiOutput("choose_county"),
      p(a(href = "http://www.val.se/val/val2014/statistik/", "Valmyndigheten 2017"))),
    mainPanel(
      tableOutput("output_table"),
      plotOutput("output_plot")
   )
  )
)
