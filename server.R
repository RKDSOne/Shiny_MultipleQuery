library(shiny)
#variables deffinitions----
#define your variables and databases here
#in server functions your database to want to search is refered as
#and database[,1] wich means you need to change it for proper name and address
#proper column number, also add informative name for names.list
#check for files----
#in addition you can use script below to check if you have downloaded databases
#and if they are up to date
#for (i in 1:length(destination.files)) {
#  if (!file.exists(destination.files[i]) | difftime(Sys.time(),
#                   file.info(destination.files[i])$mtime, units='days') > 7)
#    download.file(url = files.url[i], destfile = destination.files[i],
#                  method='curl')
#}

#server functions----
shinyServer(function(input, output, session) {
  #turn input file into df----
  names.list <- function () {
    infile <-input$datafile
    if (is.null(infile)) {
      return(NULL)
    }
    dfinput <- read.delim(infile$datapath, header = F, stringsAsFactors = F,
                          sep = '/', strip.white = T)
    names(dfinput) <- c('Names list')
    list(df = dfinput)
  }
  
  #check which namess from input are on list and which are not----
  onList <- function() {
    #code below can be used with optional checkbox in ui.R
    #    if(class(input$checkboxname) == 'character'){
    #      database <- database[database$column_name %in% 
    #                                   unlist(input$checkboxname),]
    #    }
    onValues.list <- sapply(names.list()$df[,1], grep, database[,1])
    onvalues <- database[unlist(onValues.list), ]
    onLength <- c(1:length(onValues.list))
    for (i in 1:length(onValues.list)) {
      onLength[i] <- length(onValues.list[[i]] == 0)
    }
    novalues <- as.data.frame(pest.list()$df[which(onLength == 0), 1])
    names(novalues) <- c('Absent names')
    list(onValues = onvalues, noOnValues = novalues)
  }
  
  #output definitions----
  output$filetable <- renderDataTable ({
    names.list()$df
  })
  output$present.table <- renderDataTable({
    onList()$onValues
  })
  output$not.on.list <- renderDataTable({
    onList()$noOnValues
  })
})