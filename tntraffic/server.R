shinyServer(function(input, output) {
    
    rval_traffic <- reactive({
        traffic %>%
            filter(county == input$county)  %>%
            filter(year == paste0(input$year1, "-01-01")) %>%
            filter(daily_traffic >= input$ntoproads1)
    })
    
    rval_counties <- reactive({
        counties %>%
            filter(county == input$county) %>%
            distinct(county, .keep_all = TRUE)
    })
    
    rval_counties_data <- reactive({
        #browser()
        counties_data %>%
            filter(year == paste0(input$year, "-01-01"))
    })
    
    rval_state_barplot <- reactive({
        counties_data %>%
            filter(year == paste0(input$year, "-01-01")) %>%
            mutate(variable = .data[[input$variable]])
            #factor(input$variable, levels = desc(input$variable))
            #select(c("county", "year", input$variable, "geometry"))
    })
    
    rval_top_traffic <- reactive({
        top_roads <- traffic %>%
            group_by(station_id) %>%
            filter(min(daily_traffic) >= input$ntoproads2) %>%
            mutate(ann_growth_rate = ((daily_traffic / lead(daily_traffic, 9L)) ** (1/9) - 1) * 100) %>%
            filter(year == "2018-01-01") %>%
            filter(!is.infinite(ann_growth_rate)) %>%
            arrange(desc(ann_growth_rate)) %>%
            head(input$toproads)
        top_roads_list <- top_roads %>%
            pull(station_id)
        traffic[traffic$station_id %in% top_roads_list, ] %>%
            filter(year == paste0(input$year2, "-01-01"))
        
        
    })
    
    output$downloadPDF <- downloadHandler(
        filename = 'TNTraffic_Presentation.pdf',
        content = function(file) {
            file.copy(from = 'tntraffic_app_presentation.pdf', to = file)
        })
    
    output$scatter_plot <- renderPlotly({
        #Define a key
        key <- row.names(rval_traffic())
        #Draw the scatter plot
        p <- rval_traffic() %>%
            ggplot(aes(x = daily_traffic, y = pct_change, label = location, key = key, color = "#ec3c3c", show.legend = FALSE)) + 
            geom_point() + scale_x_log10(labels = comma) +
            theme_classic() + theme(legend.position = 'none') +
            xlab('Annual Average Daily Traffic') + ylab('Percent Annual Change')
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
    
    
    output$tn_map <- renderPlotly({
        tn_map <- rval_counties_data() %>%
            ggplot(aes_string(fill= input$variable)) + geom_sf(color = "black", size = .2,
                aes(text = county)) +
            scale_fill_gradient(low = "#ec3c3c", high = "#740b0b", name = input$variable, labels = comma) +
            #theme_classic() 
            theme(axis.text.x = element_blank(),
                  axis.text.y = element_blank(),
                  axis.ticks = element_blank(),
                  rect = element_blank())
        ggplotly(tn_map)
    })
    
    output$bar_plot <- renderPlot({
        rval_state_barplot() %>%
            #filter(year == '2011-01-01') %>%
            #mutate(variable = parse(input$variable)) %>%
            arrange(desc(variable)) %>%
            head(10) %>%
            #factor(variable, levels = variable) %>%
            ggplot(aes(x= reorder(county, -variable), y = variable, fill = variable)) +
            geom_col() +
            scale_fill_gradient(low = "#ec3c3c", high = "#740b0b", name = input$variable, labels = comma) +
            scale_y_continuous(label=comma) +
            geom_text(aes(label = comma(variable)), vjust = -0.2) +
            theme_classic() +
            theme(axis.text.x = element_text(angle = 30, vjust=0.9, hjust=0.9), plot.title = element_text(hjust = 1)) +
            #ggtitle(expression(atop("Percent Change in Commute Time, 2010-2018", paste("(2018 Commute Time in mins)")))) +
            xlab('County') + ylab(input$variable)
    })
    
    output$state_scatter_plot <- renderPlotly({
        #Define a key
        key <- row.names(rval_top_traffic())
        #Draw the scatter plot
        p <- rval_top_traffic() %>%
            ggplot(aes(x = daily_traffic, y = pct_change, label = location, key = key, color = "#ec3c3c")) +
            geom_point() + scale_x_log10(labels = comma) +
            theme_classic() + theme(legend.position = 'none') +
            xlab('Annual Average Daily Traffic') + ylab('Percent Annual Change')
        #Remember the selection
        ggplotly(p) %>% layout(dragmode = "select")
        
    })
    
    output$state_map <- renderLeaflet({
        df <- rval_top_traffic()
        map_bins <- c(min(df$pct_change), -5, 0, 5, 10, 15, 20, 25, 30, max(df$pct_change)) 
        colors = c("#00b81c", "#fafa00", "#eb0000")
        pal = colorBin(palette=colors, bins=map_bins)
        
        # Get a subset data based on user selection
        if (!is.null(event_data("plotly_selected"))) {
            df <- df[event_data("plotly_selected")$key,] }
        
        leaflet(data = df) %>%
            setView(-86.5804, 35.5175, zoom = 7) %>%
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
    
})


# df$derma <- factor(df$derma, levels = df$derma)
# 
# # plot
# ggplot(data=df, aes(x=derma, y=prevalence)) + 
#     geom_bar(stat="identity") + coord_flip()
