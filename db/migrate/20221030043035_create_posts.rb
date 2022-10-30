class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :age
      t.string :sex

      t.timestamps
    end
  end
end
