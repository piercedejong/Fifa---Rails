class User < ApplicationRecord

  default_scope { order(created_at: :asc) }

  has_many :teams


  def total
    total = 0
    self.teams.all.each do |t|
      total += t.value
    end

    return total
  end

end
