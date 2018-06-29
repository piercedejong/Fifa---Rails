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
      # Get the API data
      # response = RestClient.get 'http://worldcup.sfg.io/teams/results', {:accept => :json}
      # response = JSON.parse(response)
      # User.all.each do |u|
      #   u.teams.all.each do |t|
      #     @team = response.find{|key| key["country"] == t.name }
      #     if @team != nil
      #       points = @team["wins"] - @team["losses"]
      #       if t.value != points
      #         t.update(value:points)
      #         @change = true
      #       end
      #     end
      #   end
      # end
      @group_table = RestClient.get 'https://worldcup.sfg.io/teams/group_results', {:accept => :json}
      @group_table = JSON.parse(@group_table)

      @team_table = RestClient.get 'https://worldcup.sfg.io/teams/results', {:accept => :json}
      @team_table = JSON.parse(@team_table)
      User.all.each do |u|
        u.teams.all.each do |t|
          @group = @group_table.find{|key| key["letter"] == t.group}["ordered_teams"]
          @team = @group.find{|key| key["country"] == t.name}
          @team2 = @team_table.find{|key| key["country"] == t.name}
          if @team != nil
            knockoutWins = (@team2["wins"] - @team["wins"]) * 2
            points = knockoutWins + @team["wins"] - @team["losses"]
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
end
