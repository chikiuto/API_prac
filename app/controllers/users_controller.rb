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
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to recipes_index_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/signin_form")
    end
  end

  def signout
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to recipes_index_path
  end

  
end
