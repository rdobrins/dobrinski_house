class HouseImagesController < ApplicationController
  def create

  end

  def Index
    @house_images = HouseImage.all
  end

  private

  def house_image_params
    params.require(:house_image).permit(:image)
  end
end
