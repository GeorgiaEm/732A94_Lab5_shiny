library(shiny)
library(shinythemes)
require(Val2014)
data_sets <- names(val2014())
shinyServer(function(input, output) {
  output$choose_dataset <- renderUI({
    selectInput("dataset", "Data set", data_sets)
    })
  output$choose_columns <- renderUI({
    dat <<- get(input$dataset)
    kommun <- dat$KOMMUN
    selectInput("columns", "Choose columns",choices  = kommun,selected = kommun)
  })
  output$data_table <- renderTable({
    dat <<- get(input$dataset)
    dat <<- dat[dat[,4]==input$columns,seq(6,20,2)]
    names(dat)<-str_sub(names(dat), start=1,end= -6)
    dat
  })
  output$distribution_plot <- renderPlot({
    titel<-paste("Fordelningen av rösterna i",as.character(input$columns),sep = " ")
    p<-ggplot()+ 
      aes(x = reorder(names(dat),as.numeric(as.character(dat))), y = as.numeric(as.character(dat))) + 
      geom_bar(stat="identity",fill = "dark orange", colour = "black")+
      theme_bw()+theme(axis.title.y = element_text(angle = 0, hjust = 1))+
      xlab("Parti") + ylab("Procent") + ggtitle(titel)+
      theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank())+
      theme(panel.grid.major.y = element_line(color = "dark grey"))
    p
  })
})
#runGitHub("GeorgiaEm/Lab5_shiny")
#devtools::install_github("GeorgiaEm/732A94_Lab5")
