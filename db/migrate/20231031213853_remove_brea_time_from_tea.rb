class RemoveBreaTimeFromTea < ActiveRecord::Migration[7.0]
  def change
    remove_column :teas, :brew_time, :integer
  end
end
