class CreateBadgesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
      t.string :device_id
      t.string :badge
      t.string :description

      t.index [:device_id, :badge], unique: true
    end
  end
end
