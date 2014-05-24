require 'sinatra'
require_relative 'helper'

get '/' do
  @stats = stat_builder

  erb :index
end

get '/leaderboard' do
  @stats = stat_builder
  @leaderboard = leaderboard_builder(@stats)

  erb :leaderboard
end

get 'teams/:teamname' do
  @team_name = params[:teamname]
  erb :team_page
end
