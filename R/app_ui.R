#' The application User-Interface
#'
#' shinyMobile tabs layout template
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    f7Page(
      allowPWA = TRUE, #FALSE,
      options = list(
        theme = c("ios", "md", "auto", "aurora"),
        dark = FALSE, #TRUE,
        filled = FALSE,
        color = "#27990b", #"#007aff",
        touch = list(
          tapHold = TRUE,
          tapHoldDelay = 750,
          iosTouchRipple = FALSE
        ),
        iosTranslucentBars = FALSE,
        navbar = list(
          iosCenterTitle = TRUE,
          hideOnPageScroll = TRUE
        ),
        toolbar = list(hideOnPageScroll = FALSE),
        pullToRefresh = FALSE
      ),
      title = "Dynasam IAM",
      f7TabLayout(
        # panels = tagList(
        #   f7Panel(
        #     title = "Left Panel",
        #     side = "left",
        #     theme = "light",
        #     "Blabla",
        #     effect = "cover"
        #   ),
        #   f7Panel(
        #     title = "Right Panel",
        #     side = "right",
        #     theme = "dark",
        #     "Blabla",
        #     effect = "reveal"
        #   )
        # ),
        navbar = f7Navbar(
          title = "Dynasam Integrated assessment model",
          hairline = TRUE,
          shadow = TRUE#,
          #leftPanel = TRUE,
          #rightPanel = TRUE
        ),
        f7Tabs(
          animated = TRUE,
          # f7Tab(
          #   tabName = "SSP-scenario",
          #   icon = f7Icon("eye"),
          #   active = TRUE,
          #   # f7Picker(
          #   #   inputId = "picSSP",
          #   #   placeholder = "Some text here!",
          #   #   label = "Välj SSP-scenario",
          #   #   choices = c('SSP1', 'SSP2', 'SSP3', 'SSP4', 'SSP5')
          #   # ),
          #   # textOutput("picSSPval")
          # ),
          f7Tab(
            tabName = "Scenarier",
            icon = f7Icon("eye"),
            active = TRUE,
            #"Tab 2",
            f7Row(
              f7Block(
#                f7BlockHeader(),
                "Välj ett scenario, det bygger på föreställningar
                om befolkningsutveckling, tillväxt och förväntade
                utsläpp.",
                f7Select(
                  inputId = "picSSP",
                  #placeholder = "Some text here!",
                  label = "Välj SSP-scenario",
                  choices = c('SSP1', 'SSP2', 'SSP3', 'SSP4', 'SSP5')
                ),
#                f7BlockFooter(),
                "För en närmare beskrivning av scenariorna se nästa sida",
              ),
            ),
            f7Flex(
              f7Block(
#                f7BlockHeader(),
                "Valet av diskonteringen av framtiden
                    och om risker är avgörande för hur mycket
                    vi är beredda att offra konsumtion idag
                    för att öka förutsättningarna att nå
                    lägre utsläpp.",
                  f7Row(
                    f7Slider(
                      inputId = "rhoVal",
                      label = "Individuell tidspreferens",
                      max = 2.0,
                      min = 0.0,
                      step=0.25,
                      value = 1,
                      scaleSteps = 2,
                      scaleSubSteps = 4,
                      scale = TRUE,
                      color = "orange"#,
                      #labels = tagList("Min","Max"
                        #f7Icon("circle"),
                        #f7Icon("circle_fill")
                      #)
                      ),
                    f7Slider(
                      inputId = "etaVal",
                      label = "Konsumtionselasticitet",
                      max = 2.0,
                      min = 0.0,
                      step=0.25,
                      value = 0.5,
                      scaleSteps = 2,
                      scaleSubSteps = 4,
                      scale = TRUE,
                      color = "orange"#,
                      # labels = tagList(
                      #   f7Icon("circle"),
                      #   f7Icon("circle_fill")
                      # )
                    ),
                  ),
                ),
              ),
            #),
            f7Row(
              f7Block(
                f7BlockHeader(),
                "Slutligen välj den skadefunktion som är aktuell.
                Skadefunktionen är en bedömning av hur stora skador
                som en ökande temperatur förväntas medföra.",
                f7Select(
                  inputId = "damageFctn",
                  #placeholder = "Some text here!",
                  label = "Välj skadefunktion",
                  #choices = c('damageHowardTotal','damageHowardNonCatastrophic','damageBurkeWithLag', 'damageDICE')
                  choices = c('damageHowardTotal','damageBurkeWithLag', 'damageDICE')
                ),
              ),
            ),
              #f7Row(
                # f7Select(
                #   inputId = "abatementFctn",
                #   #placeholder = "Some text here!",
                #   label = "Välj reduktionsfunktion",
                #   choices = c('p05', 'p50', 'p95')
                # ),
              #),
            #),
            f7Block(
              f7BlockTitle("Resultat",size="medium")
            ),
            #verbatimTextOutput("rhoval"),
            plotOutput("allPlot")#,
#            plotOutput("emissionsPlot"),
#            plotOutput("temperaturePlot"),
#            plotOutput("sccPlot")
          ),
          f7Tab(
            tabName = "Berättelser",
            icon = f7Icon("doc_text"),
            active = FALSE,
            "Tab 3"
          )
        )
      )
    )
  )
}





#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'Dynasam IAM'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
