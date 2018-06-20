class AddTimeToMatch < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :time, :dateTime
  end
end
