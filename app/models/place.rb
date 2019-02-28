class Place < ApplicationRecord
  has_many :participations
  belongs_to :event

  validates :gootle_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :address, presence: true,
end
