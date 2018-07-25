class CreateServiceHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :service_histories do |t|
      t.boolean :status
      t.text :status_text
      t.boolean :notification_sent
      t.belongs_to :service, foreign_key: true

      t.timestamps
    end
  end
end
