class RemoveSubscriptionIdFromTeas < ActiveRecord::Migration[7.0]
  def change
    remove_reference :teas, :subscription, index: true, foreign_key: true
  end
end
