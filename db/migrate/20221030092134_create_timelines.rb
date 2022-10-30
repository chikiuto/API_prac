class CreateTimelines < ActiveRecord::Migration[7.0]
  def change
    create_table :timelines do |t|
      t.string :age
      t.string :sex
      t.string :recipe_title
      t.string :recipe_url
      t.string :food_image_url

      t.timestamps
    end
  end
end
