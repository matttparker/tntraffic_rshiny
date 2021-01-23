shinyUI(
    dashboardPage(skin = "red",
        
        # Application title
        dashboardHeader(title = "Traffic in Tennessee"),
        
        # Sidebar to Select County
        
        dashboardSidebar(
            sidebarMenu(id = "menu_1",
                menuItem("Home", tabName = "home"),
                menuItem("State Trends", tabName = "tn_map"),
                menuItem("County Traffic Counts", tabName = "county_map"),
                menuItem("Top Roads", tabName = "top_roads")
            ),
            
            conditionalPanel(condition = "input.menu_1 == 'tn_map'",
                sliderInput("year",
                            "Select a Year:",
                            value = 2011,
                            min = 2011,
                            max = 2018,
                            sep = "",
                            animate = TRUE
                ),
                selectInput("variable",
                            "Select a Variable:",
                            choices = c("Population" = "population", 
                                        "Percent Population Change" = "pct_pop_change",
                                        "Average Commute Time" = "avg_commute_mins", 
                                        "Percent Commute Change" = "pct_comm_change", 
                                        "Weighted Change in Traffic Volume" = "traffic_growth_rate")
                )
            ),
            
            conditionalPanel(condition = "input.menu_1 == 'county_map'",
                             selectInput("county",
                                         "Select Your County:",
                                         unique(traffic$county)
                             ),
                             sliderInput("year1",
                                         "Select a Year:",
                                         value = 2011,
                                         min = 2011,
                                         max = 2018,
                                         sep = "",
                                         animate = TRUE
                             ),
                             sliderInput("ntoproads1",
                                         "Select Minimum Daily Traffic:",
                                         value = 1,
                                         min = 1,
                                         max = max(20000)
                             )
            ),
            
            conditionalPanel(condition = "input.menu_1 == 'top_roads'",
                             sliderInput("year2",
                                         "Select a Year:",
                                         value = 2011,
                                         min = 2011,
                                         max = 2018,
                                         sep = "",
                                         animate = TRUE
                             ),
                             sliderInput("toproads",
                                         "Select # of Fastest Growing Roads:",
                                         value = 50,
                                         min = 1,
                                         max = 200
                             ),
                             sliderInput("ntoproads2",
                                         "Select Minimum Daily Traffic:",
                                         value = 1000,
                                         min = 1,
                                         max = max(20000)
                             )
            )
        ),
        
        # Show a plot of the generated distribution
        dashboardBody(
             tabItems(
                 tabItem( 
                     tabName = "home",
                     fluidPage( 
                         h3("About This App"),
                         p("
                             I’ve had a lifelong passion for the built environment, and how humans have made the Earth more suitable for them. 
                             A canyon vista is beautiful - but so, to me, is a city streetscape that echoes the artistic, intellectual, and social DNA of a diverse group of people whose lives have led them to live in close proximity."),
                         p("    
                             It is easy to identify the problems of a growing population and the strains we are putting on the natural world, but it is much more difficult to find solutions for these problems. 
                             It is my goal to build a tool that will help us to grow efficiently and avoid spending resources unnecessarily. 
                             Now, I will be the first to tell you that building more roads is not the way to do that. 
                             However, we live in the reality that roads are what we’ve got to work with in the state of Tennessee - so until we are able to better diversify our methods of transportation, it is my goal to miminize our waste as much as possible."), 
                         
                         h3("How to Use This App"),
                         p("
                           The best place to begin will be the \"State Trends\" tab. Here you will see visuals of several trends across the state that may affect strain on our roads. 
                           You can follow up on  \"County Traffic Counts\" to more closely inspect all of the traffic counts within a chosen county. 
                           Finally, \"Top Roads\" will give you a visual of the roads with the highest levels of increase in traffic growth from 2010-2018, identifying regions in the state that are most likely experiencing a high impact from traffic growth."),
                         
                         h3("Context and Sources"),
                         p("Click the link below for brief PowerPoint slides with context for road construction in Tennessee, along with all data and research sources used for this project."),
                         downloadButton("downloadPDF", "Presentation"),
                         
                         h3("Future Study"),
                         h4("Road Capacity and Condition"),
                         p("Two major influences on the need for road construction are a road’s capacity limits for traffic, as well as the condition of the road. 
                           Employees at TDOT were remarkably kind and helpful in providing extremely thorough details of every road segment in the state. 
                           I would love to revisit and incorporate this data to give more accurate diagnoses."),
                         h4("Transit Solutions"),
                         p("A problem of most Tennessee cities, especially Nashville and its surrounding areas, is that they experienced their highest growth after the advent of cars. 
                           Because of this, we do not have existing infrastructure to allow for easily implemented mass transit. 
                           Notably, many residential streets in Nashville do not even have sidewalks. 
                           I am interested in solving the “last-mile” problem in Nashville - how can we create a comfortable experience for transit users to travel that final segment from the transit station to their front door?")
                     )
                 ),
                 tabItem(tabName = "tn_map",
                   fluidRow(
                       box(width = NULL, plotlyOutput("tn_map")),
                       box(width = NULL, plotOutput("bar_plot"))
                    )
                ),
                tabItem(tabName = "county_map",
                    fluidRow(
                        box(width = NULL, leafletOutput("map")),
                        h4("Draw a rectangle to select in map visualization."),
                        h4("Double-click to clear selection."),
                        box(width = NULL, plotlyOutput("scatter_plot"))
                    )
                ),
                tabItem(tabName = "top_roads",
                    fluidRow(
                        box(width = NULL, leafletOutput("state_map")),
                        h4("Draw a rectangle to select in map visualization."),
                        h4("Double-click to clear selection."),
                        box(width = NULL, plotlyOutput("state_scatter_plot"))
                    )
                )
            )
        )
        
    )
)
