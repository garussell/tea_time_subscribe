class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :title
      t.text :description
      t.float :temperature
      t.integer :brew_time
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
