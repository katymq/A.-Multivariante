library(shiny)
library(readxl)
library(qcr)
library(ggplot2)
library(ggdendro)
library(cluster)


shinyServer(function(input,output){
  
  data <- reactive({
    # file es df con: name, size, type, datapath (ruta archiv temp) del archio cargado
    file <- input$data
    if(is.null(file)) {return()}
    assign("x", file,envir = .GlobalEnv)
    if(file$type=="text/csv"){
      read.table(file$datapath, header = TRUE, sep = ";", dec=",",
                 colClasses = c("character", rep("numeric",2)))
    }else{
      # con read_xl no se reconoce el formato, le añado el formato .xlsx al nombre
      file.rename(file$datapath,
                  paste(file$datapath, ".xlsx", sep=""))
      read_excel(paste(file$datapath, ".xlsx", sep=""),sheet = 1,na = "")
    }
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
    class(data())
    names(data())
    dd <- data.frame(data())
    ddd<-dd[,2:5]
    d<-matrix(0,nrow(ddd),ncol(ddd))
    for(i in 1:ncol(ddd)){
      for(j in 1:nrow(ddd)){
        aui<-sub(",",".",ddd[j,i])
        d[j,i]<-as.numeric(aui)
      }
    }
    covarianza<-cov(d)
    correlaciones<-cor(d)
    #componentes principales
    pca<- prcomp(d)
    
    
  })
  output$Analisis <- renderPlot({
    p<-plot(pca)   
    print(p)
    
  })
  
  
  
  
  # the following renderUI is used to dynamically generate the tabsets when the file is loaded. Until the file is loaded, app will not show the tabset.
  output$tb <- renderUI({
    if(is.null(data()))
      h5(p(align='center',"INICIO"),br(), p(align='justify',"INTRODUCCIÓN. La aplicación a presentar, nos
                                            ayudará a poder realizar informes estadísticos de los talleres de
                                            BemerCar. Lo que facilitará el estudio y elanálisis de la entidad
                                            estudiada.
                                            Además presentará varios análisis multivariantes, que  estará enfocado
                                            atratar de pronosticar el número de automoviles que
                                            realizanmantenimiento, después de cierto kilometraje. Para realizar
                                            una campaña marketing sobre los grupos óptimos.
                                            OBJETIVOS
                                            Identificar las familias que presentan mayor frecuencia en retornar a
                                            los talleres.
                                            Analizar las variables y presentar un análisis descriptivo general de BemerCar.
                                            Reducir la dimensión del número de  variables, las cuales explican de
                                            mejor manera el modelo. Aplicando el método de componentes
                                            principales.
                                            "))
    else
      tabsetPanel(tabPanel("Antecedentes", tableOutput("filedf")),tabPanel("Data", tableOutput("table")),tabPanel("Summary", tableOutput("suma")),
                  tabPanel("Análisis de componentes principales", tableOutput("filedf")), tabPanel("Graf", tableOutput("analisis")))
  })
})