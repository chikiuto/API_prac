class CreateController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
  end

  def post
    # t.string "age"
    # t.string "sex"
    # t.string "user_id"
    # t.string "recipe_id"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false

    Report.create(sex: params[:sex],
                  age: params[:age],
                  user_id: params[:user_id],
                  recipe_id: params[:recipe_id],
                  # comment: params[:comment],
                  )
    redirect_to top_path
  end
end
