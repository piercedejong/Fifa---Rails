class User < ApplicationRecord

  default_scope { order(created_at: :asc) }

  has_many :teams


  def total
    total = 0
    self.teams.all.each do |t|
      if !t.knockout
        total += t.value
      end
    end
    return total
  end


  def knockout_total
    total = 0
    self.teams.all.each do |t|
      if t.knockout
        total += t.value
      end
    end
    return total
  end
end
