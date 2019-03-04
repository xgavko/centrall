class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :place, optional: true

  validates :user, uniqueness: { scope: :event }
  validate :address_on_acceptation

  enum status: { pending: 0, accepted: 1, declined: 2 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :lat_changed?

  private

  def lat_changed?
    if accepted? && !latitude_changed?
      errors.add(:address, 'You need to add a proper address')
    end
  end

  def address_on_acceptation
    if accepted? && address.blank?
      errors.add(:address, 'You need to add an address')
    end
  end
end
