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
      @match_table = @match_table.select {|key| key["stage_name"] == "First stage"}
      User.all.each do |u|
        u.teams.all.each do |t|
          if !t.knockout
            # @group = @group_table.find{|key| key["letter"] == t.group}["ordered_teams"]
            # @team = @group.find{|key| key["country"] == t.name}
            @match_home = @match_table.select {|key| key["home_team_country"] == t.name}
            @match_away = @match_table.select {|key| key["away_team_country"] == t.name}
            @knockout_home = @knockout_table.select {|key| key["home_team_country"] == t.name}
            @knockout_away = @knockout_table.select {|key| key["away_team_country"] == t.name}
            if @match_home != [] and @match_away != []
              points = @match_home.select {|key| key["winner"] == t.name}.length + @match_away.select {|key| key["winner"] == t.name}.length
              draws = @match_home.select {|key| key["winner"] == "Draw"}.length + @match_away.select {|key| key["winner"] == "Draw"}.length
              loss = 3 - points - draws
              @score = points - loss

              points = @knockout_home.select {|key| key["winner"] == t.name}.length + @knockout_away.select {|key| key["winner"] == t.name}.length
              loss = @knockout_home.select {|key| key["winner"] != t.name and key["winner"] != nil}.length + @knockout_away.select {|key| key["winner"] != t.name and key["winner"] != nil}.length
              if points < loss or @knockout_away == [] and @knockout_home == []
                t.update(eliminated:true)
              end
              @score = @score + points*2 - loss
              if t.value != @score
                t.update(value:@score)
                @change = true
              end
              #if @team != @group.first and @team != @group.second or t.name.eql? "Senegal"
              #  t.update(eliminated:true)
              #end
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
    @load = true
    @change = true
  end

  def knockout_update
    @change = false
    require 'rest_client'
    start = Time.now
    begin
      @match_table = RestClient.get 'https://worldcup.sfg.io/matches', {:accept => :json}
      @match_table = JSON.parse(@match_table)
      @knockout_table = @match_table.select {|key| key["stage_name"] != "First stage"}
      @round_16_table = @knockout_table.select {|key| key["stage_name"] == "Round of 16"}
      @quarter_table = @knockout_table.select {|key| key["stage_name"] == "Quarter-finals"}
      @semi_table = @knockout_table.select {|key| key["stage_name"] == "Semi-finals"}
      @final_table = @knockout_table.select {|key| key["stage_name"] == "Final"}
      @third_table = @knockout_table.select {|key| key["stage_name"] == "Play-off for third place"}
      User.all.each do |u|
        u.teams.all.each do |t|
          if t.knockout
            @knockout_home = @knockout_table.select {|key| key["home_team_country"] == t.name}
            @knockout_away = @knockout_table.select {|key| key["away_team_country"] == t.name}
            @score = @round_16_table.select {|key| key["winner"] == t.name}.length * 2
            @score += @quarter_table.select {|key| key["winner"] == t.name}.length * 3
            @score += @semi_table.select {|key| key["winner"] == t.name}.length * 4
            @score += @third_table.select {|key| key["winner"] == t.name}.length * 5
            @score += @final_table.select {|key| key["winner"] == t.name}.length * 6

            points = @knockout_home.select {|key| key["winner"] == t.name}.length + @knockout_away.select {|key| key["winner"] == t.name}.length
            loss = @knockout_home.select {|key| key["winner"] != t.name and key["winner"] != nil}.length + @knockout_away.select {|key| key["winner"] != t.name and key["winner"] != nil}.length
            if points < loss
              t.update(eliminated:true)
            end
            @score -= loss*2

            if t.value != @score
              t.update(value:@score)
              @change = true
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

  def knockout_future
    binding.pry
  end
end
