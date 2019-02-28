class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :place, optional: true

  validates :user, uniqueness: { scope: :event }

  enum status: { pending: 0, accepted: 1, declined: 2 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
