# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "G", value: 0, name:"Belgium"},
  {group: "H", value: 0, name:"Colombia"},
  {group: "A", value: 0, name:"Egypt"},
  {group: "G", value: 0, name:"England"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "F", value: 0, name:"Mexico", single: true},
  {group: "B", value: 0, name:"Portugal"},
  {group: "E", value: 0, name:"Serbia", single: true},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "H", value: 0, name:"Senegal", single: true},
]

frank = [
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "G", value: 0, name:"Belgium"},
  {group: "E", value: 0, name:"Brazil"},
  {group: "D", value: 0, name:"Croatia"},
  {group: "C", value: 0, name:"Denmark"},
  {group: "G", value: 0, name:"England"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "H", value: 0, name:"Poland"},
  {group: "B", value: 0, name:"Spain"},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "F", value: 0, name:"Korea Republic", single: true},
]

andrew = [
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "G", value: 0, name:"Belgium"},
  {group: "E", value: 0, name:"Brazil"},
  {group: "H", value: 0, name:"Colombia"},
  {group: "C", value: 0, name:"Denmark"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "D", value: 0, name:"Nigeria", single: true},
  {group: "B", value: 0, name:"Portugal"},
  {group: "B", value: 0, name:"Spain"},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "E", value: 0, name:"Costa Rica", single: true},
]

rob = [
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "G", value: 0, name:"Belgium"},
  {group: "E", value: 0, name:"Brazil"},
  {group: "H", value: 0, name:"Colombia"},
  {group: "G", value: 0, name:"England"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "H", value: 0, name:"Poland"},
  {group: "A", value: 0, name:"Russia", single: true},
  {group: "B", value: 0, name:"Spain"},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "E", value: 0, name:"Switzerland"},
]

ed = [
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "E", value: 0, name:"Brazil"},
  {group: "H", value: 0, name:"Colombia"},
  {group: "D", value: 0, name:"Croatia"},
  {group: "G", value: 0, name:"England"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "H", value: 0, name:"Poland"},
  {group: "B", value: 0, name:"Portugal"},
  {group: "B", value: 0, name:"Spain"},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "E", value: 0, name:"Switzerland"},
]

pierce = [
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "G", value: 0, name:"Belgium"},
  {group: "E", value: 0, name:"Brazil"},
  {group: "G", value: 0, name:"England"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "C", value: 0, name:"Peru", single: true},
  {group: "H", value: 0, name:"Poland"},
  {group: "B", value: 0, name:"Portugal"},
  {group: "B", value: 0, name:"Spain"},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "E", value: 0, name:"Switzerland"},
]

simon = [
  {group: "D", value: 0, name:"Argentina", everyone: true},
  {group: "G", value: 0, name:"Belgium"},
  {group: "E", value: 0, name:"Brazil"},
  {group: "D", value: 0, name:"Croatia"},
  {group: "A", value: 0, name:"Egypt"},
  {group: "G", value: 0, name:"England"},
  {group: "C", value: 0, name:"France", everyone: true},
  {group: "F", value: 0, name:"Germany", everyone: true},
  {group: "B", value: 0, name:"Portugal"},
  {group: "B", value: 0, name:"Spain"},
  {group: "A", value: 0, name:"Uruguay", everyone: true},
  {group: "A", value: 0, name:"No Bonus Team"},
]

teams = [edward,frank,andrew,rob,ed,pierce,simon]

User.all.each do |x|
  team = teams[x.uid]
  team.each do |t|
    x.teams.create(t)
  end
end
