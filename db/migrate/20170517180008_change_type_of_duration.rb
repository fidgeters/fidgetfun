class ChangeTypeOfDuration < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :duration
    add_column :events, :duration, :int
  end
end
