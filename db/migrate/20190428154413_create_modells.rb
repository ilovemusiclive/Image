class CreateModells < ActiveRecord::Migration[5.2]
  def change
    create_table :modells do |t|
      t.string :name

      t.timestamps
    end
  end
end
