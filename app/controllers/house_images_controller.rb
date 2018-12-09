class HouseImagesController < ApplicationController
  before_action :authenticate!, only: [:create]

  skip_before_action :verify_authenticity_token

  def create
    @house_image = HouseImage.new(house_image_params)

    if @house_image.save
      render json: { status: 200 }
    else
      render json: { error: "Image could not be created. Please try again.", status: :unprocessable_entity }
    end
  end

  def index
    @house_images = HouseImage.all
  end

  private

  def house_image_params
    params.require(:house_image).permit(:image)
  end
end
