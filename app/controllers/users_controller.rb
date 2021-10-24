class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_current_user, {only:[:edit,:update,:destroy]}

  def new
    @book = Book.new
    @user = User.new(user_params)
    if @user.saved
      redirect_to user_path(crrent_user.id)
    else
      render "uses/sign_up"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render:"edit"
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end




  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = @user.books
  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def  ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
