class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def authenticate!
    render json: 'Access Denied, Invalid Token'.to_json, status: :unauthorized and return unless valid_token?
  end

  private

  def valid_token?
    if params[:action] == "index"
      modified_index_token == ENV.fetch('INDEX_ACCESS_TOKEN')
    else
      modified_api_token == ENV.fetch('API_ACCESS_TOKEN')
    end
  end

  def modified_api_token
    params[:client_token].gsub(ENV.fetch("REMOVE_TOKEN_SUBSTRING"), ENV.fetch("INSERT_TOKEN_SUBSTRING"))
  end

  def modified_index_token
    params[:client_token].gsub(ENV.fetch("REMOVE_INDEX_SUBSTRING"), ENV.fetch("INSERT_INDEX_SUBSTRING"))
  end
end
