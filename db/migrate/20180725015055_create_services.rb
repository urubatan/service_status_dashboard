class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name
      t.string :address
      t.integer :check_type
      t.text :check_script

      t.timestamps
    end
  end
end
