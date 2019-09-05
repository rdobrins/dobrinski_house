class HouseImagesController < ApplicationController
  # include ::Concerns::AddressRecordKeeping

  before_action :authenticate!, only: [:index]
  # before_action :record_ip_address!, only: [:show]

  def show
    @show_images = params[:progress] ? progress_images : show_images
  end

  def index
    @house_images = HouseImage.order(created_at: :desc).page(params[:page])
  end

  private

  def show_images
    HouseImage.limit(2).order('created_at desc')
  end

  def date_sorted_images
    @date_sorted_images ||= HouseImage.order('created_at asc')
  end

  def progress_images
    image_interval = 20
    num_of_images = HouseImage.count / image_interval
    last_image_id = date_sorted_images.last.id

    image_ids = []

    num_of_images.times { |i| image_ids << date_sorted_images[(i * image_interval)].id }

    if !image_ids.include?(last_image_id)
      image_ids << last_image_id
    end

    HouseImage.find(image_ids)
  end
end
