class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[cart home]

  def home
    @restaurants = Restaurant.all
  end

  def dashboard_admin
    generate_qr_codes
  end

  def dashboard_user
  end

  def generate_qr_codes
    @restaurant = Restaurant.find(params[:restaurant_id])
    @array_qr_codes = []
    @restaurant.tables.each do |table|
      @qr_code = RQRCode::QRCode.new("http://localhost:3000/restaurants/#{@restaurant.id}?table=#{table.name}")
      @svg = @qr_code.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 11,
        standalone: true,
        use_path: true
      )
      @array_qr_codes << @svg
    end
  end
end
