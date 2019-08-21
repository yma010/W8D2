class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.timestamps
    end
    add_index :users, :email
    #Ex:- add_index("admin_users", "username")
  end
end
