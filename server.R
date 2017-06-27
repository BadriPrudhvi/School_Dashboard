library(shiny)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(highcharter)
library(ggplot2)
library(plotly)
library(DT)
library(formattable)

teacherData <- reactiveFileReader(60000, session = NULL
                                  , filePath = '~/Documents/git_dir/School_Dashboard/data/teacher_data.csv', read.csv)

examData <- reactiveFileReader(60000, session = NULL
                               , filePath = '~/Documents/git_dir/School_Dashboard/data/student_exam_data.csv', read.csv)
server <- function(input, output, session) {
  
  
  output$AllTeachers <- renderText({
    format(nrow(teacherData() %>% data.frame()), big.mark=",")
  })
  
  output$MaleTeachers <- renderText({
    format(nrow(teacherData() %>% filter(gender == 'Male')), big.mark=",")
  })
  
  output$FemaleTeachers <- renderText({
    format(nrow(teacherData() %>% filter(gender == 'Female')), big.mark=",")
  })
  
  output$classes <- renderText({
    CL_Count <- examData() %>% summarise(class_count = n_distinct(Class))
    format(CL_Count$class_count, big.mark=",")
  })
  
  Exam_Summary <- reactive({
    examData() %>%
      group_by(
        Class, Subject, Examination
      ) %>%
      summarise( Count = n(),
                 Average_Marks = round(mean(Obtain_Mark,na.rm=T),2)
      )
  })
  
  output$SummaryTable <- renderDataTable({
    datatable(
      Exam_Summary()
      ,rownames=FALSE
      ,filter = "top"
      ,extensions = c("Buttons","FixedColumns")
      , options = list(
        dom = 'Bfrtip'
        , buttons = c('pageLength', 'colvis', 'csv')
        , lengthMenu = list(c(10, 15, 30, -1), c('10', '15', '30','All'))
        , pageLength = 10
        , searchHighlight = TRUE
        , width="100%"
        , scrollX = TRUE
        , fixedColumns = list(leftColumns = 1)
      )
    )
  })
}