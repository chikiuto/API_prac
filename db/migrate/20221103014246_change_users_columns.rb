class ChangeUsersColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
    remove_column :users, :password
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
