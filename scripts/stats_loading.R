library(dplyr)
library(readr)
library(nflreadr)

# Edit this to have the full names of the players on your roster
# Requires full name, might need to check player_display_name in the results of all_player_stats
my_players <- list("Jaxson Dart", "Bucky Irving", "Travis Etienne", "CeeDee Lamb",
               "Nico Collins", "AJ Barner", "Devaughn Vele", "Jakobi Meyers",
               "Malik Willis", "Devin Singletary", "Kyle Monangai", "Adonai Mitchell",
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
                           "receiving_epa", "racr", "target_share","wopr")

# Edit this to have the list of defense stats you want for opponents
# See: https://nflreadr.nflverse.com/articles/dictionary_team_stats.html for columns
wanted_team_stats <- c("team", "def_tackles_solo", "def_tackles_with_assist",
                         "def_tackles_for_loss", "def_tackles_for_loss_yards",
                         "def_fumbles_forced", "def_sacks", "def_qb_hits", 
                         "def_interceptions", "def_pass_defended")

wanted_next_gen_stats_pass <- c("week", "player_short_name", "avg_time_to_throw",
                                  "avg_completed_air_yards", "avg_intended_air_yards",
                                  "avg_air_yards_differential", "aggressiveness",
                                  "avg_air_yards_to_sticks", "passer_rating", 
                                  "completion_percentage", "expected_completion_percentage",
                                  "avg_air_distance")

wanted_next_gen_stats_rec <- c("week", "player_short_name", "avg_cushion", 
                                  "avg_separation", "avg_intended_air_yards",
                                  "percent_share_of_intended_air_yards", 
                                  "avg_yac", "avg_expected_yac", "avg_yac_above_expectation")

wanted_next_gen_stats_rush <- c("week", "player_short_name", "efficiency",
                                "percent_attempts_gte_eight_defenders", "avg_time_to_los",
                                "avg_rush_yards", "expected_rush_yards", 
                                "rush_yards_over_expected", "rush_yards_over_expected_per_att",
                                "rush_pct_over_expected")

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

# Filtering out to the players and stats we want
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

ff_qb_next_gen_stats <- all_player_next_stats_pass |> 
  filter(player_display_name %in% my_players, week != 0) |> 
  select(all_of(wanted_next_gen_stats_pass))

ff_rec_next_gen_stats <- all_player_next_stats_rec |> 
  filter(player_display_name %in% my_players, week != 0) |> 
  select(all_of(wanted_next_gen_stats_rec))

ff_rush_next_gen_stats <- all_player_next_stats_rush |> 
  filter(player_display_name %in% my_players, week != 0) |> 
  select(all_of(wanted_next_gen_stats_rush))


# Breaking out stats into qb and position players
qb_stats <- c("player_name", "completions", "attempts", "passing_yards", "passing_tds", "passing_interceptions",
              "sacks_suffered", "sack_yards_lost", "sack_fumbles_lost", "passing_yards_after_catch",
              "passing_cpoe", "pacr", "carries", "rushing_yards", "rushing_tds", "rushing_fumbles",
              "rushing_epa")

qb_stats_week <- c("week", "player_name", "completions", "attempts", "passing_yards", "passing_tds", "passing_interceptions",
              "sacks_suffered", "sack_yards_lost", "sack_fumbles_lost", "passing_yards_after_catch",
              "passing_cpoe", "pacr", "carries", "rushing_yards", "rushing_tds", "rushing_fumbles",
              "rushing_epa")

position_player_stats <- c("player_name", "carries", "rushing_yards", "rushing_tds",
                           "rushing_fumbles", "rushing_epa", "receptions", "targets",
                           "receiving_yards", "receiving_tds", "receiving_fumbles",
                           "receiving_yards_after_catch", "receiving_epa", "racr",
                           "target_share", "wopr")

position_player_stats_week <- c("week", "player_name", "carries", "rushing_yards", "rushing_tds",
                           "rushing_fumbles", "rushing_epa", "receptions", "targets",
                           "receiving_yards", "receiving_tds", "receiving_fumbles",
                           "receiving_yards_after_catch", "receiving_epa", "racr",
                           "target_share",  "wopr")

stats_season_qb <- ff_player_stats_season |> 
  filter(position == "QB") |> 
  select(all_of(qb_stats))

stats_season_wr <- ff_player_stats_season |> 
  filter(position == "WR") |> 
  select(all_of(position_player_stats))

stats_season_rb <- ff_player_stats_season |> 
  filter(position == "RB") |> 
  select(all_of(position_player_stats))

stats_season_te <- ff_player_stats_season |> 
  filter(position == "TE") |> 
  select(all_of(position_player_stats))

stats_week_qb <- ff_player_stats_week |> 
  filter(position == "QB") |> 
  select(all_of(qb_stats_week)) |> 
  left_join(ff_qb_next_gen_stats, by = join_by(player_name == player_short_name,
                                               week))

stats_week_wr <- ff_player_stats_week |> 
  filter(position == "WR") |> 
  select(all_of(position_player_stats_week)) |> 
  left_join(ff_rec_next_gen_stats, by = join_by(player_name == player_short_name,
                                                week))

stats_week_rb <- ff_player_stats_week |> 
  filter(position == "RB") |> 
  select(all_of(position_player_stats_week)) |> 
  left_join(ff_rush_next_gen_stats, by = join_by(player_name == player_short_name,
                                                week))

stats_week_te <- ff_player_stats_week |> 
  filter(position == "TE") |> 
  select(all_of(position_player_stats_week)) |> 
  left_join(ff_rec_next_gen_stats, by = join_by(player_name == player_short_name,
                                                 week))





# Saving data
write_csv(stats_season_qb, "data/qb_season_stats.csv")
write_csv(stats_season_wr, "data/wr_season_stats.csv")
write_csv(stats_season_te, "data/te_season_stats.csv")
write_csv(stats_season_rb, "data/rb_season_stats.csv")

write_csv(stats_week_qb, "data/qb_weekly_stats.csv")
write_csv(stats_week_wr, "data/wr_weekly_stats.csv")
write_csv(stats_week_te, "data/te_weekly_stats.csv")
write_csv(stats_week_rb, "data/rb_weekly_stats.csv")


write_csv(ff_player_opps_stats_season, "./data/team_stats_season.csv")
write_csv(ff_player_opps_stats_week, "./data/team_stats_week.csv")





