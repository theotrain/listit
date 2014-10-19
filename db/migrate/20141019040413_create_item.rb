class CreateItem < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :body
      t.integer :user_id
      t.boolean :active
      t.datetime :sms_time
      t.boolean :sms_sent
      t.integer :position
      t.timestamps
    end
  end
end
