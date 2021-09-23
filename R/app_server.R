#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @noRd
#'
library(dplyr)
library(ggplot2)
app_server <- function( input, output, session ) {

  file1 <- read.csv("data-raw/experiment_allcba.csv", header=TRUE) %>%
    mutate(
      Period=as.Date(paste0(year,"-01-01"))
    )

  #Skapa en reactive som håller i filtrerade data.
  data <- reactive({
    file1 %>% #select(year,damage,r,elasmu,TCRE,cost_level,SSP,p,temp) %>%
      filter(r==0.001 & elasmu==1.001 & TCRE==0.00062 & cost_level=="p50" & SSP==input$picSSP,
             maxReductParam==2.2, Period<"2105-01-01")
  })

  output$picSSPval <- renderPrint(input$picSSP)
  output$rhoval <- renderText({input$rhoVal})
  #Lägg till några diagram som är enkla
  output$emissionsPlot <- renderPlot({
    #print(names(file1))
    #print(data())
    ggplot(data(), aes(x=Period,y=E,color=damage)) + geom_line()+ ylab("Utsläpp")# + facet_grid(vars(maxReductParam))
  })
  output$temperaturePlot <- renderPlot({
    #print(names(file1))
    #print(data())
    ggplot(data(), aes(x=Period,y=temp,color=damage)) + geom_line()+ ylab("Temperatur")# + facet_grid(vars(maxReductParam))
  })
  output$sccPlot <- renderPlot({
    #print(names(file1))
    #print(data())
    ggplot(data(), aes(x=Period,y=p*9,color=damage)) + geom_line() + ylab("SCC") # + facet_grid(vars(maxReductParam))
  })

}
