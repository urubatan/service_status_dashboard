class StatusFieldsForService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :current_status, :boolean
    add_column :services, :current_text, :text
  end
end
