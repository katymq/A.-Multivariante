library(shiny)
library(readxl)


shinyServer(function(input,output){
  
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    read.table(file=file1$datapath, sep=input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
    
  })
  
  output$filedf <- renderUI({
    p(align='justify',"Análisis de nuestra base",br(),"*Explicación de nuestras variables.",br())
    
    
  })
  
  # This reactive output contains the dataset and display the dataset in table format
  output$table <- renderTable({
    if(is.null(data())){return ()}
    data()
  })
  output$suma <- renderPrint({
    if(is.null(data())){return ()}
    summary(data())
  })
  
  
  # the following renderUI is used to dynamically generate the tabsets when the file is loaded. Until the file is loaded, app will not show the tabset.
  output$tb <- renderUI({
    if(is.null(data()))
      h5("Datos Generales de la Base",br(), tags$img(src='bases.png', heigth=1000, width=1000))
    else
      tabsetPanel(tabPanel("Antecedentes", tableOutput("filedf")),tabPanel("Data", tableOutput("table")),tabPanel("Summary", tableOutput("suma")),
                  tabPanel("Análisis de componentes principales", tableOutput("filedf")))
  })
})
  