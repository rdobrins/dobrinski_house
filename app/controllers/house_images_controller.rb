class HouseImagesController < ApplicationController
  before_action :authenticate!, only: [:create, :index]

  skip_before_action :verify_authenticity_token

  def create
    @house_image = HouseImage.new(house_image_params)

    if @house_image.save
      render json: { status: 200 }
    else
      render json: { error: "Image could not be created. Please try again.", status: :unprocessable_entity }
    end
  end

  def show
    @house_image = HouseImage.last
  end

  def index
    @house_images = HouseImage.order(:created_at).page(params[:page])
  end

  private

  def house_image_params
    params.require(:house_image).permit(:image)
  end
end
