shinyUI(
    dashboardPage(
        
        # Application title
        dashboardHeader(title = "Traffic in Tennessee"),
        
        # Sidebar to Select County
        
        dashboardSidebar(
            sidebarMenu(
                menuItem("View Your County", tabName = "county_map"),
                menuItem("View the State", tabName = "tn_map")
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
                        animate = TRUE)
        ),
        
        # Show a plot of the generated distribution
        dashboardBody(
             tabItems(
                tabItem(tabName = "county_map",
                    fluidRow(
                        box(width = NULL, title = 'Map', leafletOutput("map")),
                        box(width = NULL, plotlyOutput("scatter_plot"))
                    )
                ),
                tabItem(tabName = "tn_map",
                   fluidRow(
                       box(width = NULL, title = 'Map', plotlyOutput("tn_map"))
                    )
                )
            )
        )
        
    )
)
