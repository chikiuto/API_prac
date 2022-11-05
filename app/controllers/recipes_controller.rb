class RecipesController < ApplicationController
  def index
    # recipe_title
    # recipe_url
    # food_image_url
    # recipe_material
    # recipe_cost
    # recipe_indication

    if params[:zairyou]
      @recipes = Recipe.where("material LIKE ?", "%#{params[:zairyou]}%")
      if params[:jikan]
        @recipes = @recipes.where("indication LIKE ?", "%#{params[:jikan]}%")
      end
    end
  end
end
