shinyUI(
    dashboardPage(
        
        # Application title
        dashboardHeader(title = "Traffic in Tennessee"),
        
        # Sidebar to Select County
        
        dashboardSidebar(
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
            fluidRow(
                box(width = NULL, title = 'Map', leafletOutput("map")),
                box(width = NULL, plotlyOutput("scatter_plot"))
            )
        )
        
    )
)
