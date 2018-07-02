class WelcomeController < ApplicationController

  def index
    @load = true
    @change = true
  end


  def update
    @change = false
    require 'rest_client'
    start = Time.now
    begin
      @group_table = RestClient.get 'https://worldcup.sfg.io/teams/group_results', {:accept => :json}
      @group_table = JSON.parse(@group_table)

      @match_table = RestClient.get 'https://worldcup.sfg.io/matches', {:accept => :json}
      @match_table = JSON.parse(@match_table)
      @knockout_table = @match_table.select {|key| key["stage_name"] != "First stage"}
      User.all.each do |u|
        u.teams.all.each do |t|
          @group = @group_table.find{|key| key["letter"] == t.group}["ordered_teams"]
          @team = @group.find{|key| key["country"] == t.name}
          @knockout = @knockout_table.select {|key| key["winner"]== t.name}
          if @team != nil
            points = @team["wins"] + @knockout.length - @team["losses"]
            if t.value != points
              t.update(value:points)
              @change = true
            end
            if @team != @group.first and @team != @group.second or t.name.eql? "Senegal"
              t.update(eliminated:true)
            end
          end
        end
      end
      @load = true
    rescue
      @load = false
    end
    stop = Time.now
    puts(stop-start)
    if request.xhr?
      render :json => {
        load: @load,
        change: @change,
      }
    end
  end

  def knockout
    reset_extra
  end

  def reset_extra
    User.all.each do |u|
      session[u.name] = 0
    end
  end

  def knockout_team
    # @team = params["team"].capitalize
    # require 'rest_client'
    # @matches = RestClient.get 'https://worldcup.sfg.io/matches', {:accept => :json}
    # @matches = JSON.parse(@matches)
    # @stage = @matches.select {|key| key["stage_name"] == params["round"]}
    # if @stage.find {|key| key["home_team_country"] == nil }
    #   knockout_future
    # else
    #   @match = @stage.find {|key| key["home_team_country"].include? @team}
    #   if @match == nil
    #     @match = @stage.find {|key| key["away_team_country"].include? @team}
    #     @winner = @match["away_team_country"]
    #     @loser = @match["home_team_country"]
    #   else
    #     @loser = @match["away_team_country"]
    #     @winner = @match["home_team_country"]
    #   end
    #   @array = []
    #   User.all.each do |u|
    #     u.teams.all.each do |t|
    #       if t.name.include? @winner
    #         session[u.name] += 2
    #       end
    #       if t.name.include? @loser
    #         session[u.name] -= 1
    #       end
    #     end
    #     @array.push(u.total+session[u.name])
    #   end
    #   @winner = @winner[0..2].upcase
    #   @loser = @loser[0..2].upcase
    #   if params["round"].include? "16"
    #     @round = "16"
    #   else
    #     @round = "8"
    #   end
    # end
    # if request.xhr?
    #   render :json => {
    #     points: @array,
    #     winner: @winner,
    #     loser: @loser,
    #     round: @round
    #   }
    # end
  end

  def knockout_future
    binding.pry
  end
end
