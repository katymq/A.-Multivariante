library(shiny)
library(readxl)
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
  

  
  # This reactive output contains the dataset and display the dataset in table format
  output$table <- renderTable({
    if(is.null(data())){return ()}
    data()
  })
  output$suma <- renderPrint({

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
     print(class(covarianza))
    print(max(covarianza))
    covarianza
  })
  output$Analisis <- renderPlot({
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
    print(hist(covarianza))
    
  })
  
  
  
  output$tb <- renderUI({
    if(is.null(data())){
      fixedRow(
        HTML("<hr color=SteelBlue noshade=noshade />"),
        column(width=12,offset = 2,
               HTML("<div align=Center> <em> <font color=#4682b4 face=Arial size=7>    B E M E R C A R  </font> </em> </div>"),
               tags$br(),
               tags$br(),
               HTML("<div align=justify> <font color=#4682b4 face=Arial size=3> La base de datos presentada tiene las siguientes variables
                    <UL><LI>VIN: Código de identificación del automovil al cual se presto el servicio
                    <LI>PROVINCIA: Provincia en la que se encuentra el taller.</LI>
                    <LI>NOMBRE DEL ASESOR: Persona que asesoró el servicio</LI>
                    <LI>FORMA DE PAGO: Crédito o Contado</LI>
                    <LI>FAMILIA: Familia a la que pertenece el auto que ingreso a los talleres</LI>
                    <LI>Odómetro: Kilometraje con el que ingreso </LI>
                    <LI>GASTOS: Total a pagar por el servicio</LI>
                    <LI>FECHA: Fecha que ingresa el taller </LI>

                    </UL></font>"),
               tags$br(),
               tags$br(),
               HTML("<div align=justify> <font color=#4682b4 face=Arial size=4>  OBJETIVOS     </font> </div>"),
               tags$br(),
               HTML("<div align=justify> <font color=#4682b4 face=Arial size=3> 
                  <OL><LI>Identificar las familias que presentan mayor frecuencia en retornar a
                    los talleres
                    <LI>Analizar las variables y presentar un análisis descriptivo general de BemerCar.</LI>
                    <LI>Reducir la dimensión del número de  variables, las cuales explican de
                    mejor manera el modelo.</LI>
                    <LI>Aplicar el método de análisis de correspondencias</LI> </OL>  </font> </div>"),
               HTML("<div align=justify> <font color=#4682b4 face=Arial size=3>       </font> </div>")
               )
        )
    }

    
     else
      tabsetPanel(
        tabPanel("ANTECEDENTES",
                 fixedRow(
                   
                   column(width=12,offset = 1,
                          HTML("<font color=#4682b4 face=Arial size=3> Tipos de servicios que presta BEEMERCAR </font>")),
                 #imagen 1, cambian el nombre en la parte de logo
                   column(width=12,offset = 0,
                          tags$img(src = "logo12.jpg", width = "1000px", height = "600px",border="2")
                   ),
                   
                   column(width=6,offset =0,
                        HTML("<font color=#4682b4 face=Arial size=3> Cantidad de 
                             automóviles que van al mantenimiento </font>")),
                 
                  column(width=6,offset = 0,
                        HTML("<font color=#4682b4 face=Arial size=3> Porcentaje de
                             automóviles que van al mantenimiento </font>")),
                 #imagen 2
                  column(width=6,offset = 0,
                        tags$img(src = "logo12.jpg", width = "600px", height = "300px",border="2")
                  ),
                 #imagen 3
                  column(width=6,offset = 0,
                        tags$img(src = "logo12.jpg", width = "600px", height = "300px",border="2")
                  ),
                  column(width=6,offset = 0,
                        HTML("<font color=#4682b4 face=Arial size=3> Porcentaje de 
                              mantenimiento cumplido </font>"))),
                 #imagen 4
                 column(width=12,offset = 0,
                        tags$img(src = "logo12.jpg", width = "1000px", height = "600px",border="2")
                 )
        
                 
                 ),
                 
        tabPanel("BASE DE DATOS",
                 HTML("<font color=#4682b4 face=Arial size=3> .</font>"),
                 tags$br(),
                 tags$br(),
              
                 tableOutput("table")),
        
        tabPanel("DATOS GENERALES", 
                 
                 tableOutput("analisis")),
        
        tabPanel("ANÁLISIS DE COMPONENTES PRINCIPALES", 
                 #Crear una función
                 tableOutput("#CREAR FUNCION")) )
  })
})