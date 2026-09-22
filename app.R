
library(shiny)
library(bslib)
library(DT)
library(tidyverse)

# Load in data
player_stats_season <- read_csv("./data/player_stats_season.csv")

# Stats for each position
qb_stats <- c("player_name", "completions", "attempts", "passing_yards", "passing_tds", "passing_interceptions",
             "sacks_suffered", "sack_yards_lost", "sack_fumbles_lost", "passing_yards_after_catch",
             "passing_cpoe", "pacr", "carries", "rushing_yards", "rushing_tds", "rushing_fumbles",
             "rushing_epa")

position_player_stats <- c("player_name", "carries", "rushing_yards", "rushing_tds",
                           "rushing_fumbles", "rushing_epa", "receptions", "targets",
                           "receiving_yards", "receiving_tds", "receiving_fumbles",
                           "receiving_yards_after_catch", "receiving_epa", "racr",
                           "target_share", "air_yards_share", "wopr")

stats_season_qb <- player_stats_season |> 
  filter(position == "QB") |> 
  select(all_of(qb_stats))

stats_season_wr <- player_stats_season |> 
  filter(position == "WR") |> 
  select(all_of(position_player_stats))

stats_season_rb <- player_stats_season |> 
  filter(position == "RB") |> 
  select(all_of(position_player_stats))

stats_season_te <- player_stats_season |> 
  filter(position == "TE") |> 
  select(all_of(position_player_stats))


ui <- fluidPage(

    
    titlePanel("Final Fantasy Team Stats"),
    
    navset_tab(
      nav_panel(
        title = "Team Summary",
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
        p("Shows the stats of the opposing defense for the week")
      )
    )
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$QBSummary <- renderDataTable({
       datatable(stats_season_qb,
                 rownames = FALSE,
                 extensions = "FixedColumns",
                 options = list(scrollX = TRUE, dom = "t",
                                fixedColumns = list(leftColumns = 1)))
    })
    output$WRSummary <- renderDataTable({
      datatable(stats_season_wr,
                rownames = FALSE,
                extensions = "FixedColumns",
                options = list(scrollX = TRUE, dom = "t",
                               fixedColumns = list(leftColumns = 1)))
    })
    output$RBSummary <- renderDataTable({
      datatable(stats_season_rb,
                rownames = FALSE,
                extensions = "FixedColumns",
                options = list(scrollX = TRUE, dom = "t",
                               fixedColumns = list(leftColumns = 1)))
    })
    output$TESummary <- renderDataTable({
      datatable(stats_season_te,
                rownames = FALSE,
                extensions = "FixedColumns",
                options = list(scrollX = TRUE, dom = "t",
                               fixedColumns = list(leftColumns = 1)))
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
