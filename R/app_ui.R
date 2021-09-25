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
      preloader=TRUE,
      options = list(
        theme = c("ios", "md", "auto", "aurora"),
        dark = FALSE, #TRUE,
        filled = TRUE,#FALSE,
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
            f7ExpandableCard(
              id = "SSP1",
              title = "SSP1: Sustainability – Taking the Green Road",
              color = "green",
              subtitle = "Low challenges to mitigation and adaptation",
              "The world shifts gradually, but pervasively, toward a more sustainable
              path, emphasizing more inclusive development that respects perceived
              environmental boundaries. Management of the global commons slowly
              improves, educational and health investments accelerate the demographic
              transition, and the emphasis on economic growth shifts toward a broader
              emphasis on human well-being. Driven by an increasing commitment to
              achieving development goals, inequality is reduced both across and
              within countries. Consumption is oriented toward low material growth
              and lower resource and energy intensity."
              ),
            f7ExpandableCard(
              id = "SSP2",
              title = "SSP2: Middle of the Road ",
              subtitle = "Medium challenges to mitigation and adaptation",
              color = "yellow",
              "The world follows a path in which social, economic, and technological
              trends do not shift markedly from historical patterns. Development and
              income growth proceeds unevenly, with some countries making relatively
              good progress while others fall short of expectations. Global and
              national institutions work toward but make slow progress in achieving
              sustainable development goals. Environmental systems experience
              degradation, although there are some improvements and overall the
              intensity of resource and energy use declines. Global population growth
              is moderate and levels off in the second half of the century. Income
              inequality persists or improves only slowly and challenges to reducing
              vulnerability to societal and environmental changes remain."
            ),
            f7ExpandableCard(
              id = "SSP3",
              title = "SSP3: Regional Rivalry – A Rocky Road",
              subtitle = "High challenges to mitigation and adaptation",
              color = "blue",
              #image = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
              "A resurgent nationalism, concerns about competitiveness and
              security, and regional conflicts push countries to increasingly
              focus on domestic or, at most, regional issues. Policies shift
              over time to become increasingly oriented toward national and
              regional security issues. Countries focus on achieving energy
              and food security goals within their own regions at the expense
              of broader-based development. Investments in education and
              technological development decline. Economic development is slow,
              consumption is material-intensive, and inequalities persist or
              worsen over time. Population growth is low in industrialized
              and high in developing countries. A low international priority
              for addressing environmental concerns leads to strong environmental
              degradation in some regions."
            ),
            f7ExpandableCard(
              id = "SSP4",
              title = "SSP4: Inequality - A road divided",
              subtitle = "Low challenges to mitigation, high challenges to adaptation",
              color = "red",
              #fullBackground = TRUE,
              #image = "https://i.ytimg.com/vi/8q_kmxwK5Rg/maxresdefault.jpg",
              "Highly unequal investments in human capital, combined with
              increasing disparities in economic opportunity and political
              power, lead to increasing inequalities and stratification both
              across and within countries. Over time, a gap widens between
              an internationally-connected society that contributes to knowledge
              - and capital-intensive sectors of the global economy, and a
              fragmented collection of lower-income, poorly educated societies
              that work in a labor intensive, low-tech economy. Social
              cohesion degrades and conflict and unrest become increasingly
              common. Technology development is high in the high-tech economy
              and sectors. The globally connected energy sector diversifies,
              with investments in both carbon-intensive fuels like coal and
              unconventional oil, but also low-carbon energy sources.
              Environmental policies focus on local issues around middle and
              high income areas."
            ),
            f7ExpandableCard(
              id = "SSP5",
              title = "SSP5: Fossil-fueled Development – Taking the Highway",
              subtitle = "High challenges to mitigation, low challenges to adaptation",
              color = "purple",
              #fullBackground = TRUE,
              #image = "https://i.ytimg.com/vi/8q_kmxwK5Rg/maxresdefault.jpg",
              "This world places increasing faith in competitive markets, innovation
              and participatory societies to produce rapid technological progress
              and development of human capital as the path to sustainable development.
              Global markets are increasingly integrated. There are also strong
              investments in health, education, and institutions to enhance human
              and social capital. At the same time, the push for economic and social
              development is coupled with the exploitation of abundant fossil fuel
              resources and the adoption of resource and energy intensive lifestyles
              around the world. All these factors lead to rapid growth of the global
              economy, while global population peaks and declines in the 21st century.
              Local environmental problems like air pollution are successfully managed.
              There is faith in the ability to effectively manage social and ecological
              systems, including by geo-engineering if necessary."
            )

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
