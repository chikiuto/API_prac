class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :age
      t.string :sex
      t.string :user_id
      t.string :recipe_id

      t.timestamps
    end
  end
end
