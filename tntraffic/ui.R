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
            selectInput("year",
                        "Select a Year:",
                        unique(traffic$year))
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
                       box(width = NULL, title = 'Map', plotOutput("tn_map"))
                    )
                )
            )
        )
        
    )
)
