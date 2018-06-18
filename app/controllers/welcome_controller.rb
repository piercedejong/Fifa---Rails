class WelcomeController < ApplicationController
  def index
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
      {value: 0, name:"South Korea"},
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
