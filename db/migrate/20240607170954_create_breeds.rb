class CreateBreeds < ActiveRecord::Migration[7.1]
  def change
    create_table :breeds do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description, null: false
      t.integer :life_min, null: false
      t.integer :life_max, null: false
      t.integer :male_weight_min, null: false
      t.integer :male_weight_max, null: false
      t.integer :female_weight_min, null: false
      t.integer :female_weight_max, null: false
      t.boolean :hypoallergenic, null: false, default: false

      t.timestamps
    end
  end
end
