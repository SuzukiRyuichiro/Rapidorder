class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    if @review.save
      format.html { redirect_to restaurants_path, notice: "Review successfully created" }
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def render_confirmation
  confirmation = params['_json']

  cart.map! do |order|
    { product: Product.find(product[:id]),
    amount: order[:amount] }
  end
  respond_to do |format|
    format.text {
      render partial: "shared/confirmation", locals: {cart: cart}, formats: [:html]
    }
  end
end

  private

  def review_params
    params.require(:review).permit(:rating)
  end
end
