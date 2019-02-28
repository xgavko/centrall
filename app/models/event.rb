class Event < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :places

  validates :start_at, presence: true
  validates :name, presence: true
  validates :kind, presence: true

  geocoded_by :address
  enum status: { boarding: 0, voting: 1, display_result: 2 }
end
