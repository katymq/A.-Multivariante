library(shiny)
library(readxl)
library(data.table)
library(bit)
library(bit64)
library(ggplot2)
library(ggdendro)
library(cluster)
dir()
shinyUI(fixedPage( 
  HTML("<body style=background:##FAFAFA> </body>"),
  fixedRow(
    HTML("<hr color=SteelBlue noshade=noshade />"),
    column(width=12,offset = 0,
           HTML("<div align=center> <font color=SteelBlue face=Verdana size=3> I N <IMPACT/FONT>  
                <font color=SteelBlue face=Verdana size=4> F O </font> 
                <font color=SteelBlue face=Verdana size=5> R M </font> 
                <font color=SteelBlue face=Verdana size=6> E   </font> 
                <font color=SteelBlue face=Verdana size=7> S   B </font> 
                <font color=SteelBlue face=Verdana size=6> E </font>
                <font color=SteelBlue face=Verdana size=5> M E </font>
                <font color=SteelBlue face=Verdana size=4> R C </font> 
                <font color=SteelBlue face=Verdana size=3> A R </font>  </div> ")
           ),
    column(width=3,offset = 0,
           tags$img(src = "logo12.jpg", width = "300px", height = "100px",border="2")
    ),
    column(width=6,offset = 0,
           HTML("<div align=center> <b> <font color=SkyBlue face=Cambria size=5>
                CONSULTORA ESTADÍSTICA </font> </b> </div>")
           ),
    
    column(width=3,offset = 0,
           tags$img(src = "logo21.jpg", width = "300px", height = "100px",border="3") 
    )
    ),    
  HTML("<hr color=SteelBlue noshade=noshade />"),
  
  
  fixedRow(
    
    column(width=10,offset = 1,
           HTML("<div align=justify> <b> <font color=SteelBlue face=Cambria size=3> 
                Nuestra aplicación tiene por objetivo realizar una análisis descriptivo de  bases de datos referentes al sistema de  servicios en
                los talleres automovilísticos para la compañía BemerCar. Dando así una visión general del comportamiento de los talleres y clientes. </font> </b> </div>"),
           HTML("<div align=justify> <b> <font color=SteelBlue face=Cambria size=3> 
                Además deseamos ofrecer un método estadístico para la interpretación adecuada de los datos 
                presentados por parte del analista mediante un informe generado. </font> </b> </div>"),tags$br(),
           tags$br()),
    
    
    
    column(width=8,offset = 1,
           HTML("<div align=center> <b> <font color=SkyBlue face=Cambria size=5>
                AVISO </font> </b> </div>"),
           
           HTML("<div align=justify> <font color=SteelBlue face=Arial size=3> 
                Se deben tener en cuenta la forma de ingresar la 
                base de datos para que nuestra aplicación no presente problemas al realizar  
                el análisis, para ello se debe considerar ciertas características. </font> </div> "),
           
           HTML("<div align=justify> <font color=SteelBlue face=Arial size=3> 
                <UL>
                <LI>Presentar un formato de tipo <b> .xls .xlsx .csv </b> </LI>
                <LI>Estar depurada</LI>
                <LI>No exceder el tamaño de 5MG</LI>
                </UL> </font> </div> ")
           
           ),
    
    
    sidebarPanel(width=3
                 ,offset = 0,
                 fileInput(inputId="data", label="SUBIR LA BASE", multiple = FALSE, 
                           accept = c(".xls",".xlsx", ".csv")),
                 helpText(HTML("<font color=SteelBlue face=Verdana size=2> Max 5MG </font> </div>"))
    )
           ),
  
  
  mainPanel(
    
    uiOutput("tb"),
    HTML("<hr color=SteelBlue noshade=noshade />"),           
    tags$br(),
    tags$br(),
    
    HTML("<a href=https://www.facebook.com/ConsulEstadis.S.A> <img src=facebook.png width = 50 height = 35> </a> 
         <font color=SteelBlue face=Arial size=1.7>  ConsulEstadis.S.A </font>"),
    HTML("<a href=https://twitter.com/SourceStatLab> <img src=twitter.jpg width = 50 height = 45> </a>
         <font color=SteelBlue face=Arial size=1.7> @ConsulEstadis.S.A  </font>"),
    HTML("<hr color=SteelBlue noshade=noshade />")
    
    )
  
  
  
  
  )
    )
