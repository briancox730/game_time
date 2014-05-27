require 'sinatra'
require_relative 'helper'

get '/' do
  @title = "Game Time"
  @stats = stat_builder

  erb :index
end

get '/leaderboard' do
  @title = "Leaderboard"
  @stats = stat_builder
  @leaderboard = leaderboard_builder(@stats)

  erb :leaderboard
end

get '/teams/:team_name' do
  @title = params[:team_name]
  @team_name = params[:team_name]
  @stats = stat_builder
  @leaderboard = leaderboard_builder(@stats)
  @team_stats = team_info(@team_name, @stats)
  erb :team_page
end
