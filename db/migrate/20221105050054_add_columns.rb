class AddColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :comment, :string,  :limit =>200
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
