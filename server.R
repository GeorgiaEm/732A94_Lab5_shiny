library(shiny)
library(shinythemes)
require(Val2014)
val_data <- names(val2014())
shinyServer(function(input, output) {
    output$choose_data <- renderUI({
      selectInput("valdata", "Choose type of election", val_data)
    })
    output$choose_county <- renderUI({
      if(is.null(input$valdata))
        return()
      zz <- get(input$valdata)
      kommun <- zz$KOMMUN
      selectInput("county", "Choose county",kommun)
    })

    output$output_plot <- renderPlot({
      if(is.null(input$valdata) | is.null(input$county))
        return()
      zz <- get(input$valdata)
      valtyp_ <- input$valdata

      kommun_ <- zz[zz[,4]==input$county,4]
      zz <- zz[zz[,4]==input$county,seq(6,20,2)]
      names(zz)<-str_sub(names(zz), start=1,end= -6)
      
      titel<-paste("Distribution of the votes in",kommun_,"-",valtyp_,sep = " ")
      
      
      p<-ggplot()+
        aes(x = reorder(names(zz),as.numeric(as.character(zz))), y = as.numeric(as.character(zz))) +
        geom_bar(stat="identity",fill = "dark orange", colour = "black")+
        theme_bw()+ xlab("Party") + ylab("Percent") + ggtitle(titel)+
        theme(panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank(),
              panel.grid.major.y = element_line(color = "dark grey"),
              axis.title.y = element_text(angle = 0, hjust = 1),
              plot.title = element_text(hjust = 0.5,size=22))
      p
    })
    output$output_table <- renderTable({
      if(is.null(input$valdata) | is.null(input$county))
        return()
      zz <- get(input$valdata)

      kommun_ <- zz[zz[,4]==input$county,4]
      zz <- zz[zz[,4]==input$county,seq(6,20,2)]
      names(zz)<-str_sub(names(zz), start=1,end= -6)
      zz
    })
  })
