shinyServer(function(input, output) {
    
    rval_traffic <- reactive({
        traffic %>%
            filter(county == input$county)  %>%
            filter(year == input$year)
    })
    
    rval_counties <- reactive({
        counties %>%
            filter(county == input$county) %>%
            distinct(county, .keep_all = TRUE)
    })
    
    rval_county_data <- reactive({
        counties %>%
            filter(year == as.Date(input$year))
    })
    
    output$scatter_plot <- renderPlotly({
        #Define a key
        key <- row.names(rval_traffic())
        #Draw the scatter plot
        p <- rval_traffic() %>%
            ggplot(aes(x = daily_traffic, y = pct_change, label = location, key = key)) + 
            geom_point() + scale_x_log10()
        #Remember the selection
        ggplotly(p) %>% layout(dragmode = "select")
        
    })
    
    output$map <- renderLeaflet({
        df <- rval_traffic()
        map_bins <- c(min(df$pct_change), -5, 0, 5, 10, 15, 20, 25, 30, max(df$pct_change)) 
        colors = c("#00b81c", "#fafa00", "#eb0000")
        pal = colorBin(palette=colors, bins=map_bins)
        
        # Get a subset data based on user selection
        if (!is.null(event_data("plotly_selected"))) {
            df <- df[event_data("plotly_selected")$key,] }
        
        leaflet(data = df) %>%
            setView(rval_counties()$long, rval_counties()$lat, zoom = 10) %>%
            addTiles() %>%
            addCircleMarkers(
                color = ~pal(pct_change),
                stroke = FALSE, fillOpacity = 0.5,
                lng = ~long,lat = ~lat,
                popup = ~paste0(location,
                                "<br/>Average Daily Traffic: ", daily_traffic,
                                "<br/>Percent Change: ", pct_change)) %>%
            addLegend(pal = pal, values = ~pct_change, title = "Percent Change", position = "bottomright")
    })
    
    output$tn_map <- renderPlot({
        rval_county_data() %>%
            ggplot() + geom_sf(data = rval_county_data(), color = "black", aes(fill = population, na.value="grey80"))
    })
    
})

