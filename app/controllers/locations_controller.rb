class LocationsController < ApplicationController
  def index
    respond_to do |f|
      f.json { render :json => { locations: ip_locations } }
    end
  end

  private

  def ip_locations
    AddressRecord.all.map { |a| Geocoder.search(a.ip_address) }
  end
end
