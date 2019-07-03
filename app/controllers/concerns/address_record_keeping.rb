module Concerns
  module AddressRecordKeeping
    extend ActiveSupport::Concern

    def record_ip_address!
      if record_exists?
        AddressRecord.find_by(ip_address: ip_address).update(last_visited: Time.now)
      else
        AddressRecord.create(ip_address: ip_address)
      end
    end

    def record_exists?
      AddressRecord.exists?(ip_address: ip_address)
    end

    def ip_address
      "#{request.remote_ip}"
    end
  end
end
