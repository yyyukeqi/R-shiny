ui <- fullPage(
  
  opts = list(
    controlArrows = FALSE  
  ),
  
  menu = c(
    'About Me' = 'about',
    'Airbnb' = 'abnb',
    'Starbucks' = 'starbucks',
    'Mosaic' = 'mosaic'
  ),
  
  # about section----
  fullSectionImage(
    menu = 'about',
    img = 'columbia.jpeg',
    center = TRUE,
    # _slide1----
    fullSlide(
      fullButtonRight(
        h1(
          style = 'font-size:75px; color:black;',
          'Keqi Yu'
        )
      )
    ),
    # _slide2----
    fullSlide(
      div(
        style = 'padding:0 20% 0 20%;',
        wellPanel(
          style = 'background-color:rgba(240,240,240,0.7); border:0px;',
          fluidRow(
            column(
              width = 8,
              fluidRow(
                # __name----
                column(
                  align = 'right',
                  width = 6,
                  h3(
                    style = 'font-size:40px; color:black;',
                    'Keqi Yu'
                  )
                ),
                # __linkedin link----
                column(
                  width = 6,
                  align = 'right',
                  # style = 'padding-top:20px;',
                  tags$a(
                    href = 'https://www.linkedin.com/in/melissa-keqi-yu',
                    img(
                      src = 'linkedin.png',
                      height = '50px',
                      style = 'border-radius:3px;'
                    ),
                    target = '_blank'
                  )
                )
              ),
              hr(),
              # __description1----
              div(
                align = 'left',
                style = 'padding:10px 0 10px 40px;',
                actionBttn(
                  inputId = 'desc1',
                  label = 'Grad Student at Columbia Univerisity in MSc Applied Analytics',
                  style = 'stretch',
                  size = 'md',
                  color = 'primary',
                  icon = icon('graduation-cap')
                )
              ),
              # __description2----
              div(
                align = 'left',
                style = 'padding:10px 0 10px 40px;',
                actionBttn(
                  inputId = 'desc2',
                  label = 'Analytics Expert',
                  style = 'stretch',
                  size = 'md',
                  color = 'success',
                  icon = icon('chart-line')
                )
              ),
              # __description3----
              div(
                align = 'left',
                style = 'padding:10px 0 10px 40px;',
                actionBttn(
                  inputId = 'desc3',
                  label = 'Data Engineering learner',
                  style = 'stretch',
                  size = 'md',
                  color = 'royal',
                  icon = icon('laptop', lib = "font-awesome")
                )
              )
            ),
            column(
              width = 4,
              align = 'center',
              # __portrait image----
              img(
                src = 'portrait2.jpg',
                width = '100%'
              ),
              hr(),
              # __favorite links----
              fluidRow(
                column(
                  width = 4,
                  tags$a(
                    href = 'https://www.apple.com/',
                    img(src = 'Tesla.jpeg', height = '40px'),
                    target = '_blank'
                  )
                ),
                column(
                  width = 4,
                  tags$a(
                    href = 'https://www.blackpinkmusic.com/',
                    img(src = 'music.png', height = '40px'),
                    target = '_blank'
                  )
                ),
                column(
                  width = 4,
                  tags$a(
                    href = 'https://golf.com/',
                    img(src = 'golf.png', height = '40px'),
                    target = '_blank'
                  )
                )
              )
            )
          )
        ),
        fullButtonLeft(
          actionBttn(
            inputId = paste0('aboutLeft1'),
            label = 'Back',
            style = 'simple',
            size = 'md',
            color = 'warning',
            icon = icon('arrow-left')
          )
        )
      )
    )
  ),
  
  # airbnb section----
  fullSectionImage(
    menu = 'abnb',
    img = 'abnb.jpeg',
    center = TRUE,
    # _slide1----
    fullSlide(
      fullButtonRight(
        img(
          src = 'airbnb.png',
          width = '20%'
        )
      )
    ),
    # _slide2----
    fullSlide(
      uiOutput('uiAbnb')
    )
  ),
  
  # mosaic section----
  fullSectionImage(
    menu = 'mosaic',
    img = 'usa.jpeg',
    center = TRUE,
    # _slide1----
    fullSlide(
      fullButtonRight(
        img(
          src = 'usa.png',
          width = '10%'
        )
      )
    ),
    # _slide2----
    fullSlide(
      uiOutput('uiMosaic')
    )
  ),
  
  
  
)