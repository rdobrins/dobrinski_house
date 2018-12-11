class Cluster < ApplicationRecord
  has_many :fragments, dependent: :destroy
end
