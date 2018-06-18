class User < ApplicationRecord

  has_many :teams


  def total
    total = 0
    self.teams.all.each do |t|
      total += t.value
    end

    return total
  end

end
