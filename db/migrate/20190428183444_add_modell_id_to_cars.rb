class AddModellIdToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :modell_id, :integer
  end
end
