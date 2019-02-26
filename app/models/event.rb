class Event < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy

  validates :start_at, presence: true
  validates :name, presence: true
  validates :kind, presence: true

  enum status: { boarding: 0, voting: 1, display_result: 2 }
end
