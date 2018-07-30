class SetNotificationFlagInService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :last_notification_time, :datetime
  end
end
