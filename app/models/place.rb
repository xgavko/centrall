class Place < ApplicationRecord
  has_many :participations
  belongs_to :event

  validates :google_id, presence: true
  validates :name, presence: true

  def coordinates
    { lng: longitude, lat: latitude }
  end
end
