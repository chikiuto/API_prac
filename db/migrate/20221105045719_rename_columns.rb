class RenameColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :recipes, :recipe_title, :title
    rename_column :recipes, :recipe_url, :url
    rename_column :recipes, :recipe_material, :material
    rename_column :recipes, :recipe_cost, :cost
    rename_column :recipes, :recipe_indication, :indication
  end
end
