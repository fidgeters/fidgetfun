class Addeventsmodel < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :event_type
      t.timestamp :pressed_at
      t.timestamp :duration
      t.integer :value

      t.timestamps
    end
  end
end
