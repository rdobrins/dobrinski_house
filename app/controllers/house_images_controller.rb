class HouseImagesController < ApplicationController
  # include ::Concerns::AddressRecordKeeping

  before_action :authenticate!, only: [:index]
  # before_action :record_ip_address!, only: [:show]

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
