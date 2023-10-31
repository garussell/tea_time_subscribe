class ChangeSubscriptionStatusToEnum < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :status, :integer, using: 'CASE WHEN status = \'active\' THEN 1 ELSE 0 END', default: 1, null: false
  end
end
