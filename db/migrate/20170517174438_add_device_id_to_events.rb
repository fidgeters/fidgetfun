class AddDeviceIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :device_id, :string
  end
end
