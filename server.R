library(shiny)
library(shinythemes)
require(Val2014)
data_sets <- names(val2014())
shinyServer(function(input, output) {
    output$choose_dataset <- renderUI({
      selectInput("dataset", "Data set", data_sets)
    })
    output$choose_columns <- renderUI({
      if(is.null(input$dataset))
        return()
      dat <<- get(input$dataset)
      kommun <<- dat$KOMMUN
      selectInput("columns", "Choose columns",choices  = kommun,selected = kommun)
    })
    output$data_table <- renderTable({
      if(is.null(input$dataset))
        return()
      dat <<- get(input$dataset)
      if (is.null(input$columns) || !(input$columns %in% dat$KOMMUN))
        return()
      dat <<- dat[dat[,4]==input$columns,seq(6,20,2)]
      names(dat)<<-str_sub(names(dat), start=1,end= -6)
      dat
    })
    output$distribution_plot <- renderPlot({
      if(is.null(input$dataset))
        return()
      dat <<- get(input$dataset)
      if (is.null(input$columns) || !(input$columns %in% dat$KOMMUN))
        return()
      kommun_ <<- dat[dat[,4]==input$columns,4]
      dat <<- dat[dat[,4]==input$columns,seq(6,20,2)]
      names(dat)<<-str_sub(names(dat), start=1,end= -6)
      
      titel<-paste("Fordelningen av rösterna i",kommun_,sep = " ")
      
      
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
