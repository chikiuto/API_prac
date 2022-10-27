class RecipesController < ApplicationController
  def index
    # recipe_title
    # recipe_url
    # food_image_url
    # recipe_material
    # recipe_cost
    # recipe_indication

    if params[:keyword]
      @recipes = Recipe.where("recipe_material LIKE ?", "%#{params[:keyword]}%")
    end
  end
end
