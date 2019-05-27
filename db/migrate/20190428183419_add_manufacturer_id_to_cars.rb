class AddManufacturerIdToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :manufacturer_id, :integer
  end
end
