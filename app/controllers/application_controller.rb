class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_leader

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
end
