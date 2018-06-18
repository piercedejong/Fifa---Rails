class WelcomeController < ApplicationController

  def index
    require 'rest_client'
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
  end


  def create_user
    Team.all.each do |a|
      a.destroy
    end

    User.all.each do |u|
      u.destroy
    end

    user = [
      {uid: 0, name:"EdCruise"},
      {uid: 1, name:"El Presidente"},
      {uid: 2, name:"Dentista"},
      {uid: 3, name:"Shark Sieloff"},
      {uid: 4, name:"EdTeach"},
      {uid: 5, name:"The Undergrad"},
      {uid: 6, name:"Zimon Ibrah"},
    ]

    user.each do |u|
      User.create(u)
    end

    edward = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Belgium"},
      {value: 0, name:"Columbia"},
      {value: 0, name:"Egypt"},
      {value: 0, name:"England"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Mexico"},
      {value: 0, name:"Portugal"},
      {value: 0, name:"Serbia"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"Senegal"},
    ]

    frank = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Belgium"},
      {value: 0, name:"Brazil"},
      {value: 0, name:"Croatia"},
      {value: 0, name:"Denmark"},
      {value: 0, name:"England"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Poland"},
      {value: 0, name:"Spain"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"Korea Republic"},
    ]

    andrew = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Belgium"},
      {value: 0, name:"Brazil"},
      {value: 0, name:"Columbia"},
      {value: 0, name:"Denmark"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Nigeria"},
      {value: 0, name:"Portugal"},
      {value: 0, name:"Spain"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"Costa Rica"},
    ]

    rob = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Belgium"},
      {value: 0, name:"Brazil"},
      {value: 0, name:"Columbia"},
      {value: 0, name:"England"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Poland"},
      {value: 0, name:"Russia"},
      {value: 0, name:"Spain"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"Switzerland"},
    ]

    ed = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Brazil"},
      {value: 0, name:"Columbia"},
      {value: 0, name:"Croatia"},
      {value: 0, name:"England"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Poland"},
      {value: 0, name:"Portugal"},
      {value: 0, name:"Spain"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"Switzerland"},
    ]

    pierce = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Belgium"},
      {value: 0, name:"Brazil"},
      {value: 0, name:"England"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Peru"},
      {value: 0, name:"Poland"},
      {value: 0, name:"Portugal"},
      {value: 0, name:"Spain"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"Switzerland"},
    ]

    simon = [
      {value: 0, name:"Argentina"},
      {value: 0, name:"Belgium"},
      {value: 0, name:"Brazil"},
      {value: 0, name:"Croatia"},
      {value: 0, name:"Egypt"},
      {value: 0, name:"England"},
      {value: 0, name:"France"},
      {value: 0, name:"Germany"},
      {value: 0, name:"Portugal"},
      {value: 0, name:"Spain"},
      {value: 0, name:"Uruguay"},
      {value: 0, name:"No Bonus Team"},
    ]

    teams = [edward,frank,andrew,rob,ed,pierce,simon]

    User.all.each do |x|
      team = teams[x.uid]
      team.each do |t|
        x.teams.create(t)
      end
    end

  end

end
