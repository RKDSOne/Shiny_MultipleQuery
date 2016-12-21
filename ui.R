library(shiny)

shinyUI(fluidPage(theme = 'bootstrap.css',
  titlePanel('MultipleQuery'),
                  
  sidebarLayout(position = 'left',
    sidebarPanel(p(h3('Please, remember to properly format your 
                      input file.')),
                 br(),
                 p('Upload file with names you are interested in, 
                   with button below.'),
                 br(),
                 fileInput('datafile', label = 'Upload your list here',
                           accept = c('text/plain')),
#                optional checkbox
#                checkboxGroupInput('checkboxname', label =, choices = 
#                selected =),
                 br(),
                 p('Please provide file in plain text format. All names 
                   in separate rows.'),
                 br(),
                 p('This Search Engine was built with', 
                 a('Shiny', href = 'http://www.rstudio.com/shiny'), 'for', 
                 a('R Studio', href = 'http://www.rstudio.com'))),
  mainPanel(h2('Search databases for a list of names'), 
    tabsetPanel(
      tabPanel('Query list', dataTableOutput('filetable')),
      tabPanel('Match', dataTableOutput('present.table')),
      tabPanel('Not on list', dataTableOutput('not.on.list'))
)))))