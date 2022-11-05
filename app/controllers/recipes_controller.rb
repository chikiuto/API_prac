class RecipesController < ApplicationController
  def index
    if params[:zairyou]
      @recipes = Recipe.where("material LIKE ?", "%#{params[:zairyou]}%")
      if params[:jikan]
        @recipes = @recipes.where("indication LIKE ?", "%#{params[:jikan]}%")
      end
    end
  end
end
