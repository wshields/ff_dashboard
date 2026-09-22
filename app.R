
library(shiny)
library(bslib)
library(DT)
library(tidyverse)

# Load in data
qb_season_stats <- read_csv("./data/qb_season_stats.csv")
wr_season_stats <- read_csv("./data/wr_season_stats.csv")
rb_season_stats <- read_csv("./data/rb_season_stats.csv")
te_season_stats <- read_csv("./data/te_season_stats.csv")

qb_weekly_stats <- read_csv("./data/qb_weekly_stats.csv")
wr_weekly_stats <- read_csv("./data/wr_weekly_stats.csv")
rb_weekly_stats <- read_csv("./data/rb_weekly_stats.csv")
te_weekly_stats <- read_csv("./data/te_weekly_stats.csv")




ui <- fluidPage(

    
    titlePanel("Final Fantasy Team Stats"),
    
    navset_tab(
      nav_panel(
        title = "Team Summary",
        fluidRow(
          column(
            width = 1,
            radioButtons(
              inputId = "teamSeasonWeekly",
              label = "Season or Weekly Stats",
              choices = list("Season" = "season", "Weekly" = "weekly")
            )
          ),
          column(
            width = 11,
            br(),
            p(strong("QBs")),
            dataTableOutput("QBSummary"),
            br(),
            p(strong("WRs")),
            dataTableOutput("WRSummary"),
            br(),
            p(strong("RBs")),
            dataTableOutput("RBSummary"),
            br(),
            p(strong("TEs")),
            dataTableOutput("TESummary")
          ),
        )
      ),

      
      nav_panel(
        title = "Player Visualization",
        p("Plot a week by week stat of one player")
      ),
      
      nav_panel(
        title = "Player Comparison",
        p("Compare two players at the same position")
      ),
      
      nav_panel(
        title = "Upcoming Defense",
        p("Shows the stats of the selected player's opposing defense for the week")
      )
    )
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$QBSummary <- renderDataTable({
      if(input$teamSeasonWeekly == "season"){
        datatable(qb_season_stats,
                  rownames = FALSE,
                  extensions = "FixedColumns",
                  options = list(scrollX = TRUE, dom = "t", 
                                 fixedColumns = list(leftColumns = 1)))
      }else{
        datatable(qb_weekly_stats,
                  rownames = FALSE,
                  extensions = "FixedColumns",
                  options = list(scrollX = TRUE, dom = "t", 
                                 fixedColumns = list(leftColumns = 1)))
      }
       
    })
    output$WRSummary <- renderDataTable({
      if(input$teamSeasonWeekly == "season"){
        datatable(wr_season_stats,
                rownames = FALSE,
                extensions = "FixedColumns",
                options = list(scrollX = TRUE, dom = "t",
                               fixedColumns = list(leftColumns = 1)))
      }else{
        datatable(wr_weekly_stats,
                  rownames = FALSE,
                  extensions = "FixedColumns",
                  options = list(scrollX = TRUE, dom = "t", 
                                 fixedColumns = list(leftColumns = 1)))
      }
    })
    output$RBSummary <- renderDataTable({
      if(input$teamSeasonWeekly == "season"){
        datatable(rb_season_stats,
                rownames = FALSE,
                extensions = "FixedColumns",
                options = list(scrollX = TRUE, dom = "t",
                               fixedColumns = list(leftColumns = 1)))
      }else{
        datatable(rb_weekly_stats,
                  rownames = FALSE,
                  extensions = "FixedColumns",
                  options = list(scrollX = TRUE, dom = "t", 
                                 fixedColumns = list(leftColumns = 1)))
      }
    })
    output$TESummary <- renderDataTable({
      if(input$teamSeasonWeekly == "season"){
        datatable(te_season_stats,
                rownames = FALSE,
                extensions = "FixedColumns",
                options = list(scrollX = TRUE, dom = "t",
                               fixedColumns = list(leftColumns = 1)))
      }else{
        datatable(te_weekly_stats,
                  rownames = FALSE,
                  extensions = "FixedColumns",
                  options = list(scrollX = TRUE, dom = "t", 
                                 fixedColumns = list(leftColumns = 1)))
      }
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
