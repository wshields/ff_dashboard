library(dplyr)
library(readr)
library(nflreadr)

# Edit this to have the full names of the players on your roster
# Requires full name, might need to check player_display_name in the results of all_player_stats
my_players <- list("Jaxson Dart", "Bucky Irving", "Travis Etienne", "CeeDee Lamb",
               "Nico Collins", "AJ Barner", "Devaughn Vele", "Jakobi Meyers",
               "Malik Willis", "Tyrone Tracy Jr.", "Kyle Monangai", "Adonai Mitchell",
               "Makai Lemon", "George Kittle")

# Edit this to be the team abbreviations for each players opponent this week
# Should be in the same corresponding order as the player list, INCLUDE dupes
my_player_opps <- list("LAR", "CLE", "BAL", "WAS", "CIN", "ARI", "BAL", "DEN", "SF",
                   "LAR", "MIN", "GB", "TEN", "MIA")


# Edit this to have the list of player stats you want - THIS SHOULD BE FOR ALL POSITIONS
# See: https://nflreadr.nflverse.com/articles/dictionary_player_stats.html for columns
wanted_player_stats <- c("player_name", "position", "completions", "attempts", 
                           "passing_yards", "passing_tds", "passing_interceptions",
                           "sacks_suffered", "sack_yards_lost", "sack_fumbles_lost",
                           "passing_yards_after_catch", "passing_cpoe", "pacr", 
                           "carries", "rushing_yards", "rushing_tds", "rushing_fumbles",
                           "rushing_epa", "receptions", "targets", "receiving_yards",
                           "receiving_tds", "receiving_fumbles", "receiving_yards_after_catch",
                           "receiving_epa", "racr", "target_share", "air_yards_share",
                           "wopr")

# Edit this to have the list of defense stats you want for opponents
# See: https://nflreadr.nflverse.com/articles/dictionary_team_stats.html for columns
wanted_team_stats <- c("team", "def_tackles_solo", "def_tackles_with_assist",
                         "def_tackles_for_loss", "def_tackles_for_loss_yards",
                         "def_fumbles_forced", "def_sacks", "def_qb_hits", 
                         "def_interceptions", "def_pass_defended")

wanted_next_gen_stats_pass <- list("week", "player_display_name", "avg_time_to_throw",
                                  "avg_completed_air_yards", "avg_intended_air_yards",
                                  "avg_air_yards_differential", "aggressiveness",
                                  "avg_air_yards_to_sticks", "passser_rating", 
                                  "completion_percentage", "expected_completion_percentage",
                                  "avg_air_distance")

wanted_next_gen_stats_rec 

all_player_stats_season <- load_player_stats(season = most_recent_season(), 
                                     summary_level = "reg")

all_player_stats_week <- load_player_stats(season = most_recent_season(), 
                                            summary_level = "week")

all_player_next_stats_pass <- load_nextgen_stats(season = most_recent_season(),
                                           stat_type = "passing")

all_player_next_stats_rec <- load_nextgen_stats(season = most_recent_season(),
                                              stat_type = "receiving")

all_player_next_stats_rush <- load_nextgen_stats(season = most_recent_season(),
                                              stat_type = "rushing")

all_team_stats_season <- load_team_stats(season = most_recent_season(),
                                        summary_level = "reg")

all_team_stats_week <- load_team_stats(season = most_recent_season(),
                                        summary_level = "week")

ff_player_stats_season <- all_player_stats_season |> 
  filter(player_display_name %in% my_players) |> 
  select(all_of(wanted_player_stats))

ff_player_stats_week <- all_player_stats_week |> 
  filter(player_display_name %in% my_players) |> 
  select(c("week", all_of(wanted_player_stats)))

ff_player_opps_stats_season <- all_team_stats_season |> 
  filter(team %in% my_player_opps) |> 
  select(all_of(wanted_team_stats))

ff_player_opps_stats_week <- all_team_stats_week |> 
  filter(team %in% my_player_opps) |> 
  select(c("week", all_of(wanted_team_stats)))

write_csv(ff_player_stats_season, "./data/player_stats_season.csv")
write_csv(ff_player_stats_week, "./data/player_stats_week.csv")
write_csv(ff_player_opps_stats_season, "./data/team_stats_season.csv")
write_csv(ff_player_opps_stats_week, "./data/team_stats_week.csv")





