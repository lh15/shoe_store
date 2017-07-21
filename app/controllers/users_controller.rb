class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create authenticate]

  def new
    redirect_to '/products' if !!logged_in_user
  end

  def show
    @products_selling = Product.where(buyer_id: nil).where(seller: @logged_in_user)
    @products_bought = Product.where(buyer_id: @logged_in_user.id)
    @purchases = Product.where(buyer_id: @logged_in_user.id).sum('amount')
    @products_sold = Product.where(seller_id: @logged_in_user.id).where.not(buyer_id: nil)
    @sales = Product.where(seller_id: @logged_in_user.id).where.not(buyer_id: nil).sum('amount')
    
  end


  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
    else
      flash[:errors] = user.errors.full_messages
    end
    redirect_to '/products'
  end

  def authenticate
    user = User.find_by(email: login_params[:email])
    if user.nil?
      flash[:errors] = ['User not found']
      redirect_to '/users/login'
    elsif user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to '/products'
    else
      flash[:errors] = ['Incorrect Password']
      redirect_to '/users/login'
    end
  end

  def logout
    reset_session
    redirect_to '/users/login'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
