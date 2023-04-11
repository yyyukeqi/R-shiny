server <- function(input, output, session) {
  
  # reactive variables----
  a <- reactiveValues(
    selA = NULL, #selected abnb property
    selS = NULL, #selected sbux store
    selP = NULL, #selected mosaic state pos
    selC = NULL, 
  )
  
  # about me----
  # _event desc1----
  observeEvent(
    eventExpr = input$desc1,
    {
      sendSweetAlert(
        title = "Grad Student at Columbia Univerisity in MSc Applied Analytics",
        text = "Self-professed Expert",
        type = "info"
      )
    }
  )
  
  # _event desc2----
  observeEvent(
    eventExpr = input$desc2,
    {
      sendSweetAlert(
        title = "Analytics Expert",
        text = "Self-professed Expert",
        type = "info"
      )
    }
  )
  # _event desc3----
  observeEvent(
    eventExpr = input$desc3,
    {
      sendSweetAlert(
        title = "Data Engineering learner",
        text = "Self-professed Expert",
        type = "info"
      )
    }
  )
  
  # ui abnb----
  output$uiAbnb <- renderUI(
    {
      div(
        style = 'padding-left:5%; padding-right:5%;',
        fluidRow(
          column(
            width = 6,
            wellPanel(
              style = 'background-color:rgba(10,10,10,0.5);',
              pickerInput(
                inputId = 'boro',
                label = 'NYC Borough',
                choices = c(
                  'Manhattan',
                  'Brooklyn',
                  'Queens',
                  'Bronx',
                  'Staten Island'
                ),
                selected = 'Manhattan'
              ),
              hr(),
              highchartOutput('abnbPrices', height = '45vh')
            )
          ),
          column(
            width = 6,
            leafletOutput(
              outputId = 'nycMap',
              height = '60vh'
            )
          )
        )
      )
    }
  )
  
  # _nyc map----
  output$nycMap <- renderLeaflet(
    {
      mapData <- abb |> 
        filter(boro == input$boro) |> 
        sample_n(20)
      aIcon <- makeIcon(
        iconUrl = ifelse(str_sub(mapData$room_type,1,1) == 'E', 'airbnb_blue.png',
                  ifelse(str_sub(mapData$room_type,1,1) == 'P', 'airbnb_green.png', 'airbnb_red.png')),
        iconWidth = 35,
        iconHeight = 40,
        iconAnchorX = 17.5,
        iconAnchorY = 0
      )
      leaflet(
        data = mapData
      ) |> 
        addProviderTiles(providers$CartoDB.DarkMatter) |> 
        addMarkers(
          lat = ~lat,
          lng = ~lng,
          icon = aIcon
        )
    }
  )
  
  # _prices chart----
  output$abnbPrices <- renderHighchart(
    if (!is.null(a$selA)) {
      z <- abb |> 
        filter(boro == a$selA$boro) |> 
        # filter(neighborhood == a$selA$neighborhood) |> 
        filter(room_type == a$selA$room_type)
      z <- z |>
        sample_n(min(10, nrow(z)))
      hchart(
        density(z$price),
        type = 'area',
        color = ifelse(str_sub(a$selA$room_type,1,1) == 'E', 'blue',
                ifelse(str_sub(a$selA$room_type,1,1) == 'P', 'green', 'red'))
      ) 
    }
  )
  
  # _event nycmap marker click----
  observeEvent(
    eventExpr = input$nycMap_marker_click,
    {
      x <- input$nycMap_marker_click
      a$selA <- abb |> 
        filter(lat == x$lat & lng == x$lng)
    }
  )
  
  # ui sbux----
  output$uiSbux <- renderUI(
    {
      div(
        style = 'padding-left:5%; padding-right:5%;',
        fluidRow(
          column(
            width = 6,
            leafletOutput(
              outputId = 'usMap',
              height = '65vh'
            )
          ),
          column(
            width = 6,
            wellPanel(
              highchartOutput('sbuxSales', height = '60vh')
            )
          )
        )
      )
    }
  )
  
  # _us map----
  output$usMap <- renderLeaflet(
    {
      mapData <- sbux |> sample_n(10)
      sIcon <- makeIcon(
        iconUrl = 'sbux_mrkr.png',
        iconWidth = 35,
        iconHeight = 40,
        iconAnchorX = 17.5,
        iconAnchorY = 0
      )
      leaflet(
        data = mapData
      ) |> 
        # addTiles() |> 
        addProviderTiles(providers$Stamen.TonerLite) |>
        addMarkers(
          lat = ~lat,
          lng = ~lng,
          popup = ~paste0(
            '<style>div.leaflet-popup-content {width:auto !important;}</style>',
            '<div style = "text-align:center;">',
            '<h5>', store_name, '</h5></div>',
            '<div style = "overflow:hidden; display:flex; ',
            'align-items:center; justify-content:bottom; ',
            'width:500px; max-height:300px;">',
            '<img src = "sbux', str_pad(1:10, 2, 'left', '0'), '.jpeg" ',
            'width = "500px" ',
            'style = "border-radius:5px;"></img></div>'
          ), 
          icon = sIcon
        )
    }
  )
  
  # _sales chart----
  output$sbuxSales <- renderHighchart(
    if (!is.null(a$selS)) {
      z <- sbux |> 
        filter(store_id == a$selS$store_id) |> 
        select(sales_b, sales_f, sales_o) |> 
        gather('category', 'pct', 1:3)
      hchart(
        z,
        type = 'bar',
        hcaes(
          x = category,
          y = pct,
          color = category
        )
      ) 
    }
  )
  
  # _event usmap marker click----
  observeEvent(
    eventExpr = input$usMap_marker_click,
    {
      x <- input$usMap_marker_click
      a$selS <- sbux |> 
        filter(lat == x$lat & lng == x$lng)
    }
  )
  
  # ui mosaic----
  output$uiMosaic <- renderUI(
    {
      div(
        style = 'padding-left:5%; padding-right:5%;',
        fluidRow(
          column(
            width = 6,
            uiOutput('mosMap')
            )
          ),
          column(
            width = 6,
            wellPanel(
              
            )
          )
        )
    }
  )
  
  # _mos map----
  output$mosMap <- renderUI(
    {
      div(
        h2('The USA'),
        hr(),  # a horizontal line
        lapply(
          0:7,
          function(i){
            fluidRow(
              lapply(
                1:12,
                function(j){
                  k <- i * 12 + j
                  s <- usa %>% filter(pos == k)
                  if (nrow(s) == 1){
                    column(
                      width = 1,
                      style = 'padding:1px;',
                      actionButton(
                        inputId = paste0('usa', k),
                        label = s$st,
                        style = 'fill',
                        color = sample(bootColors, 1),
                        block = TRUE
                      )
                    )
                  } else{
                    column(
                      width = 1
                    )
                  }
                }
              )
            )
          }
        )
    )
  }
 )
  # _events state----
  observeEvent(input$usa1, {a$selP <- 1})
  observeEvent(input$usa12, {a$selP <- 12})
  
  
  # _mosaic chart----
  output$mosCht <- renderHighchart(
    {
      z1 <- usa %>% 
        filter(pos == 1) %>% 
        gather('grp', 'pct', 5:23) %>% 
        mutate(cat = 's') %>% 
        select(grp, pct, cat)
      z2 <- mos %>% 
        filter(company == a$selC) %>% 
        gather('grp', 'pct', 2:20) %>% 
        mutate(cat = 'c') %>% 
        select(grp, pct, cat)
      z <- bind_rows(z1, z2)
      hchart(
        z,
        type = 'column',
        hcaes(
          x = grp,
          y = pct,
          group = cat,
          color = pct
        )
      )
    }
  )
  
  # _mosaic input----
  output$mosInput <- renderUI(
    {
      fluidRow(
        lapply(
          1:6,
          function(i){
            column(
              width = 2,
              tag$button(
                id = paste0('co', i),
                class = 'btn action-button',
                style = 'background-color:rgba(0,0,0,0);',
                img(
                  src = paste0(mos$company[i], '.png'),
                  width = '100%'
                )
              )
            )
          }
        )
      )
    }
  )
  
  # _events company----
  observeEvent(input$col, {a$selC <- mos$company[1]})
  observeEvent(input$col, {a$selC <- mos$company[2]})
  observeEvent(input$col, {a$selC <- mos$company[3]})
  observeEvent(input$col, {a$selC <- mos$company[4]})
  observeEvent(input$col, {a$selC <- mos$company[5]})
  observeEvent(input$col, {a$selC <- mos$company[6]})
  
  # _mosaic similarity calc----
  output$mosCalc <- renderUI(
    {
      z1 <- usa %>% 
        filter(pos == a$selP) %>% 
        gather('grp', 'pct', 5:23)
      z2 <- mos %>% 
        filter(pos == a$selC) %>% 
        gather('grp', 'pct', 2:20) 
      h4(
        paste0(
          'Similarity = ',
          round(1 - sqrt(sum(z1$pct - z2$pct)) ^2), 2)
        )
      )
    }
  )
}
