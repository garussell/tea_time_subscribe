class AddImageAndLinkToTeas < ActiveRecord::Migration[7.0]
  def change
    add_column :teas, :image, :string
    add_column :teas, :link, :string
  end
end
