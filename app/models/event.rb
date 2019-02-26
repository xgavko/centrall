class Event < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destoy

  validates :start_date, presence: true
  validates :name, presence: true
  validates :kind, presence: true
end
