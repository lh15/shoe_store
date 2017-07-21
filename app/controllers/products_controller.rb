class ProductsController < ApplicationController
  def index
    @products = Product.where(buyer_id: nil).where.not(seller: @logged_in_user)
  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:errors] = product.errors.full_messages
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to "/users/#{session[:user_id]}#purchases"
  end

  def buy
    product = Product.find(params[:id])
    if product.update(:buyer_id => @logged_in_user.id, :date_purchased => Time.now)
      redirect_to "/users/#{session[:user_id]}#purchases"
    else
      flash[:errors] = product.errors.full_messages
      redirect_to "/products"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :amount).merge(seller: logged_in_user)
  end
end
