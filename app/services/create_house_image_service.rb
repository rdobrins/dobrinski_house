class CreateHouseImageService
  def initialize(cluster:)
    @cluster = cluster
  end

  def create
    write_file_to_tmp

    file_cleanup if new_house_image.save
  end

  private

  attr_reader :cluster

  def new_house_image
    HouseImage.new.tap { |image| image.image = Rails.root.join("public/#{file_name}").open }
  end

  def file_name
    @file_name ||= "#{cluster.stamp}.jpg"
  end

  def file_cleanup
    File.delete("./public/#{file_name}")
  end

  def write_file_to_tmp
    File.open(File.join('./public', file_name), 'wb') { |f| f.puts base_64_decoded_image }
  end

  def base_64_decoded_image
    @base_64_decoded_image ||= Base64.decode64(base64_image)
  end

  def base64_image
    @base64_image ||= cluster.fragments.order(:cluster_order).map(&:content).join()
  end
end
