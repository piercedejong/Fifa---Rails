class WelcomeController < ApplicationController

  def index
    require 'rest_client'
    begin
      # Get the API data
      response = RestClient.get 'http://worldcup.sfg.io/teams/results', {:accept => :json}
      response = JSON.parse(response)

      # Loop through all of the teams
      response.each do |r|
        # Loop through all of the users
        User.all.each do |u|
          # Check if the user has the team
          if u.teams.find_by(name: r["country"])
            # If so calc the teams new value
            points = r["wins"] - r["losses"]
            u.teams.find_by(name: r["country"]).update(value: points)
          end
        end
      end
      @load = true
    # Error handle
    rescue
      logger.error("Failed To Read API")
      @load = false
    end
  end


  def create_user
  end

end
