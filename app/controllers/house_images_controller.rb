class HouseImagesController < ApplicationController
  before_action :authenticate!, only: [:create, :index]
  before_action :write_file_to_tmp, only: [:create]

  after_action :file_cleanup, only: [:create]

  skip_before_action :verify_authenticity_token

  def create
    if new_house_image.save
      render json: { status: 200 }
    else
      render json: { error: "Image could not be created. Please try again.", status: :unprocessable_entity }
    end
  end

  def show
    @house_image = HouseImage.last
  end

  def index
    @house_images = HouseImage.order(created_at: :desc).page(params[:page])
  end

  private

  def new_house_image
    @house_image = HouseImage.new.tap { |image| image.image = Rails.root.join("public/#{file_name}").open }
  end

  def file_cleanup
    File.delete("./public/#{file_name}")
  end

  def file_name
    @file_name ||= "#{Time.now.to_i}.jpg"
  end

  def write_file_to_tmp
    File.open(File.join('./public', file_name), 'wb') { |f| f.puts base_64_decoded_image }
  end

  def base_64_decoded_image
    Base64.decode64(house_image_params[:image])
  end

  def house_image_params
    params.require(:house_image).permit(:image)
  end
end
