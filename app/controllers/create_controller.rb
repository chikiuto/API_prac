class CreateController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    # t.string :age
    # t.string :sex
    # t.string :recipe_title
    # t.string :recipe_url
    # t.string :food_image_url

    @post = Timeline.create(age: params[:age], sex: params[:sex], recipe_title: params[:recipe_title], recipe_url: params[:recipe_url], food_image_url: params[:food_image_url])
    redirect_to top_path
  end
end
