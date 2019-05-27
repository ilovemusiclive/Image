class AddEventIdToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :event_id, :integer
  end
end
