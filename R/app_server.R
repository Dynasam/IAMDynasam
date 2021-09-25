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
library(tidyr)
library(gridExtra)
library(scales)
library(ggpubr)

app_server <- function( input, output, session ) {

  file1 <- read.csv("data-raw/experiment_allcba.csv", header=TRUE) %>%
    mutate(
      Period=as.Date(paste0(year,"-01-01"))
    )

  #Notera MAC = gamma*cost_level^beta
  #Skapa en reactive som håller i filtrerade data.
  data_long <- reactive({
    file1 %>% #select(year,damage,r,elasmu,TCRE,cost_level,SSP,p,temp) %>%
      filter(r==0.001 & elasmu==1.001 & TCRE==0.00062 & cost_level=="p50" & SSP==input$picSSP,
             maxReductParam==2.2, Period<"2105-01-01", damage==input$damageFctn) %>%
      select(Period,E,p,temp) %>%
      gather(key=variable, value=value, -c(Period))
  })

  data <- reactive({
    file1 %>% #select(year,damage,r,elasmu,TCRE,cost_level,SSP,p,temp) %>%
      filter(r==0.001 & elasmu==1.001 & TCRE==0.00062 & cost_level=="p50" & SSP==input$picSSP,
             maxReductParam==2.2, Period<"2105-01-01", damage==input$damageFctn)
    })

  output$picSSPval <- renderPrint(input$picSSP)
  output$rhoval <- renderText({input$rhoVal})
  #Lägg till några diagram som är enkla
  # output$allPlot <- renderPlot({
  #   #print(data())
  #   #print(data())
  #   ggplot(data_long(), aes(x=Period,y=value)) +
  #     geom_line()+ ylab("Utsläpp") +
  #     ylab(NULL) +
  #     facet_wrap(vars(variable),nrow = 2,scales="free",strip.position = "left",
  #                labeller = as_labeller(c(p = "Pris på koldioxid, kr",
  #                                         E = "Utsläpp GtCO2",
  #                                         temp="Temperaturförändring \nsedan 1850-1900, \u00B0C"))) +
  #     theme(strip.background = element_blank(), strip.placement = "outside") +
  #     theme_linedraw()
  # })

  #Använder CE=cumEmissions, men jag skulle hellre vilja använda CO2-koncentation. Kan jag
  #enkelt få fram den från körningarna?
  output$allPlot <- renderPlot({

    theme_set(theme_classic())

    th <-   theme(axis.title.y = element_text(face = "bold", size = 12),
                  plot.background = element_rect(fill = "#bcedaf"),
                  panel.grid.major = element_line(linetype = "dashed"),
                  panel.grid.minor = element_line(linetype = "dotted"))

    scg <- scale_color_gradientn(name="Temperatur", colours = terrain.colors(10),
                                 limits=c(1.0,2.5), values = rescale(c(-10, -3, 0, 3, 10)))

    #g1 <- ggplot(data_long() %>% filter(variable=="p"), aes(x=Period,y=value)) +
    g1 <- ggplot(data(), aes(x=Period,y=p,color=temp),size=2) +
          geom_line()+ ylab("Pris på koldioxid, kr") + scg + th
    #g2 <- ggplot(data_long() %>% filter(variable=="E"), aes(x=Period,y=value)) +
    g2 <- ggplot(data(), aes(x=Period,y=E,color=temp),size=2) +
          geom_line()+ ylab("Utsläpp GtCO2") + scg + th
    #g3 <- ggplot(data_long() %>% filter(variable=="temp"), aes(x=Period,y=value,color=value),size=2) +
    g3 <- ggplot(data(), aes(x=Period,y=temp,color=temp),size=2) +
      geom_line()+ ylab("Temperaturförändring \nsedan 1850-1900, \u00B0C") + scg + th
    g4 <- ggplot(data(), aes(x=Period,y=CE,color=temp),size=2) +
      geom_line()+ ylab("Kumulativa utsläpp") + scg + th

    ggarrange(g4, g2, g1, g3,nrow=2,ncol=2, common.legend = TRUE, legend="bottom")
  })
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
