class HouseImagesController < ApplicationController
  before_action :authenticate!, only: [:index]

  skip_before_action :verify_authenticity_token

  def show
    @house_image = HouseImage.last
  end

  def index
    @house_images = HouseImage.order(created_at: :desc).page(params[:page])
  end
end
