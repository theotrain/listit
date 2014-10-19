class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :slug
      t.string :minified
      t.string :time_zone
      t.timestamps
    end
  end
end
