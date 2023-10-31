class ChangeTemperatureColumnTypeInTeas < ActiveRecord::Migration[7.0]
  def change
    change_column :teas, :temperature, :string
  end
end
