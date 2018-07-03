class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_leader
  helper_method :current_leader_knockout

  def current_leader
    top = 0
    User.all.each do |u|
      if u.total > top
        top = u.total
      end
    end
    leader = ""
    User.all.each do |u|
      if u.total.eql? top
        leader+=u.name+", "
      end
    end
    leader = leader[0...-2]
    return leader
  end

  def current_leader_knockout
    top = 0
    User.all.each do |u|
      if u.knockout_total > top
        top = u.knockout_total
      end
    end
    leader = ""
    User.all.each do |u|
      if u.knockout_total.eql? top
        leader+=u.name+", "
      end
    end
    leader = leader[0...-2]
    return leader
  end
end
