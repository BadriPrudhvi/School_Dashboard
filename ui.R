library(shinydashboard)
library(shiny)
library(DT)
library(dygraphs)
library(ggplot2)
library(plotly)
library(highcharter)

ui <- dashboardPage(
  dashboardHeader(title = "School Dashboard")
  ,skin = 'yellow'
  ,dashboardSidebar(
    sidebarMenu(
      menuItem("School Information", tabName = "School", icon = icon("institution"))
      ,menuItem("Student Info", tabName = "Bio", icon = icon("id-badge"))
      ,menuItem("Student Performance", tabName = "Performance", icon = icon("line-chart"))
      ,menuItem("Teacher Analysis", tabName = "Teacher", icon = icon("vcard-o"))
      ,menuItem("Class Information", tabName = "Class", icon = icon("building"))
      ,menuItem("Attendence", tabName = "Present", icon = icon("book"))
    )
    ,dateRangeInput("daterange", "Date Range:")
  )
  ,dashboardBody(
    tabItems(
      tabItem(
        tabName = "School"
        ,fluidRow(
          valueBox(
            uiOutput("AllTeachers")
            , "Total Teachers"
            , color = "olive"
            , width = 3
          )
          ,valueBox(
            uiOutput("MaleTeachers")
            , "Male Teachers"
            , color = "maroon"
            , width = 3
          )
          ,valueBox(
            uiOutput("FemaleTeachers")
            , "Female Teachers"
            , color = "blue"
            , width = 3
          )
          ,valueBox(
            uiOutput("classes")
            , "Class Present"
            , color = "yellow"
            , width = 3
          )
        )
      )
      ,tabItem(
        tabName = "Performance"
        ,fluidRow(
          box(
            title = "Exam Summary"
            ,collapsible = TRUE
            ,status = "primary"
            ,dataTableOutput("SummaryTable")
          )
        )
      )
    )
  )
)