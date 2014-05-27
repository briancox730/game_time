require 'csv'
require 'pry'

def stat_builder
  stats = []
  CSV.foreach('data/stats.csv',
              headers: true,
              header_converters: :symbol,
              converters: :all) do |row|
    stats << row.to_hash
  end
  stats
end

def leaderboard_builder(stats)
  leaderboard = {}
  stats.each do |game|
    if !leaderboard.has_key?(game[:home_team])
      leaderboard[game[:home_team]] = {:win => 0, :loss => 0}
    end
    if !leaderboard.has_key?(game[:away_team])
      leaderboard[game[:away_team]] = {:win => 0, :loss => 0}
    end
  end
  stats.each do |game|
    if game[:home_score] > game[:away_score]
      leaderboard[game[:home_team]][:win] += 1
      leaderboard[game[:away_team]][:loss] += 1
    else
      leaderboard[game[:away_team]][:win] += 1
      leaderboard[game[:home_team]][:loss] += 1
    end
  end

  leaderboard.sort_by {|team, stats| [-stats[:win], stats[:loss]]}
end

def team_info(team, stats)
  team_record = {}
  team_record[team] = []
  stats.each do |game|
    if team == game[:home_team]
      team_record[game[:home_team]] << [{ :score => game[:home_score],
                                              :score_away => game[:away_score],
                                              :op_team => game[:away_team]}]
    end

    if team == game[:away_team]
      team_record[game[:away_team]] << [{ :score => game[:away_score],
                                              :score_away => game[:home_score],
                                              :op_team => game[:home_team]}]
    end
  end
  team_record
end

