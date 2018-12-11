class FragmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate!, only: [:create]
  after_action :compose_house_image, only: [:create]

  def create
    if built_fragment.save
      render json: { status: 200 }
    else
      render json: { error: "Fragment could not be created. Please try again.", status: :unprocessable_entity }
    end
  end

  private

  def compose_house_image
    logger.info "FIND_LOGGER => Cluster Fragments: #{cluster.fragments.count} / Number of Fragments: #{number_of_fragments}"
    if cluster.fragments.count == number_of_fragments
      CreateHouseImageService.new(cluster: cluster).create
    end
  end

  def built_fragment
    cluster.fragments.build(fragment_hash)
  end

  def fragment_hash
    {
      cluster_order: cluster_order,
      content: content
    }
  end

  def cluster
    @cluster ||=
      Cluster.find_or_create_by(
        stamp: stamp,
        number_of_fragments: number_of_fragments,
        total_character_count: total_character_count
      )
  end

  def stamp
    @stamp ||= split_content[(split_content.index("stamp") + 1)]
  end

  def number_of_fragments
    @number_of_fragments ||= split_content[(split_content.index("number_of_fragments") + 1)].to_i
  end

  def total_character_count
    @total_character_count ||= split_content[(split_content.index("total_character_count") + 1)].to_i
  end

  def cluster_order
    @cluster_order ||= split_content[(split_content.index("cluster_order") + 1)].to_i
  end

  def content
    @content ||= split_content[(split_content.index("content") + 1)]
  end

  def split_content
    @split_content ||= decoded_content.split("_DIVIDER_")
  end

  def decoded_content
    @decoded_content ||= Base64.decode64(fragment_params[:base_64_content])
  end

  def fragment_params
    params.require(:fragment).permit(:base_64_content)
  end
end
