shinyUI(
    dashboardPage(
        
        # Application title
        dashboardHeader(title = "Traffic in Tennessee"),
        
        # Sidebar to Select County
        
        dashboardSidebar(
            sidebarMenu(
                menuItem("Home", tabName = "home"),
                menuItem("State Trends", tabName = "tn_map"),
                menuItem("County Traffic Counts", tabName = "county_map"),
                menuItem("Top Roads", tabName = "top_roads")
            ),
            
            selectInput("county",
                        "Select Your County:",
                        unique(traffic$county)
            
            ),
            sliderInput("year",
                        "Select a Year:",
                        value = 2011,
                        min = 2011,
                        max = 2018,
                        animate = TRUE
            ),
            selectInput("variable",
                        "Select a Variable:",
                        choices = c("Population" = "population", 
                                    "Percent Population Change" = "pct_pop_change",
                                    "Average Commute Time" = "avg_commute_mins", 
                                    "Percent Commute Change" = "pct_comm_change", 
                                    "Weighted Change in Traffic Volume" = "traffic_growth_rate")
            ),
            sliderInput("toproads",
                        "Select # of Fastest Growing Roads:",
                        value = 50,
                        min = 1,
                        max = 200
            )
        ),
        
        # Show a plot of the generated distribution
        dashboardBody(
             tabItems(
                tabItem(tabName = "tn_map",
                   fluidRow(
                       box(width = NULL, title = 'Map', plotlyOutput("tn_map")),
                       box(width = NULL, title = 'Plot', plotOutput("bar_plot"))
                    )
                ),
                tabItem(tabName = "county_map",
                    fluidRow(
                        box(width = NULL, title = 'Map', leafletOutput("map")),
                        box(width = NULL, title = 'Plot', plotlyOutput("scatter_plot"))
                    )
                ),
                tabItem(tabName = "top_roads",
                        fluidRow(
                            box(width = NULL, title = 'Map', leafletOutput("state_map")),
                            box(width = NULL, title = 'Plot', plotlyOutput("state_scatter_plot"))
                        )
                )
            )
        )
        
    )
)
