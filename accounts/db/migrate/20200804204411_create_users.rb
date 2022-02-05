class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false, primary_key: :username do |t|
      t.string :username, unique: true
      t.string :password_digest

      t.timestamps
    end
  end
end
