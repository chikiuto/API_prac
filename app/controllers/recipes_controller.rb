class RecipesController < ApplicationController
  def index
    # recipe_title
    # recipe_url
    # food_image_url
    # recipe_material
    # recipe_cost
    # recipe_indication

    if params[:zairyou]
      @recipes = Recipe.where("recipe_material LIKE ?", "%#{params[:zairyou]}%")
      if params[:jikan]
        @recipes = @recipes.where("recipe_indication LIKE ?", "%#{params[:jikan]}%")
      end
    end
  end
end
