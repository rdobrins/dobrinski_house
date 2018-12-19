class HouseImagesController < ApplicationController
  before_action :authenticate!, only: [:index]

  def show
    @show_images = show_images
  end

  def index
    @house_images = HouseImage.order(created_at: :desc).page(params[:page])
  end

  private

  def show_images
    HouseImage.limit(2).order('id desc')
  end
end
