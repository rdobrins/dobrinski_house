class ApplicationController < ActionController::Base
  def authenticate!
    render json: 'User does not have access to this event'.to_json, status: :unauthorized and return unless valid_token?
  end

  private

  def valid_token?
    params[:access_token] == ENV.fetch('API_ACCESS_TOKEN')
  end
end
