class WelcomeController < ApplicationController

  def index
    @load = true
    @change = true
  end


  def create_user
    @change = false
    require 'rest_client'
    begin
      # Get the API data
      response = RestClient.get 'http://worldcup.sfg.io/teams/results', {:accept => :json}
      @load = true
      response = JSON.parse(response)
      # Loop through all of the teams
      response.each do |r|
      #   # Loop through all of the users
        User.all.each do |u|
      #     # Check if the user has the team
          if u.teams.find_by(name: r["country"])
      #       # If so calc the teams new value
            points = r["wins"] - r["losses"]
            if !points.eql? u.teams.find_by(name: r["country"]).value
              u.teams.find_by(name: r["country"]).update(value: points)
              @change = true
            end
          end
        end
      end
    rescue
      @load = false
    ensure
    end
    if request.xhr?
      render :json => {
        load: @load,
        change: @change,
      }
    end
  end

end
