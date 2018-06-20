class WelcomeController < ApplicationController

  def index
    @load = true
    @change = true

    # require 'rest_client'
    #
    # begin
    #   response = RestClient.get 'http://worldcup.sfg.io/matches/today', {:accept => :json}
    #   # if no matches today
    #   if response == "[]"
    #     response = RestClient.get 'http://worldcup.sfg.io/matches/', {:accept => :json}
    #     response = JSON.parse(response)
    #     response.each do |r|
    #       if r["winner"] == nil
    #         binding.pry
    #         break
    #       end
    #     end
    #   # matches played today
    #   else
    #     response = JSON.parse(response)
    #     binding.pry
    #   end
    # rescue
    #
    # end
  end


  def update
    @change = false
    require 'rest_client'
    start = Time.now
    begin
      # Get the API data
      response = RestClient.get 'http://worldcup.sfg.io/teams/results', {:accept => :json}
      response = JSON.parse(response)
      User.all.each do |u|
        u.teams.all.each do |t|
          @team = response.find{|key, hash| key["country"] == t.name }
          if @team != nil
            points = @team["wins"] - @team["losses"]
            if t.value != points
              t.update(value:points)
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
end
