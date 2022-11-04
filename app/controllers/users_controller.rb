class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def signup
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to recipes_index_path
    else
      render("users/new")
    end
  end

  def signin_form
  end

  def signin
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user $$ @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      redirect_to recipes_index_path
    else
      render recipes_index_path
    end
  end

  
end
