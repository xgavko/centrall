require "open-uri"

class Event < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :places

  validates :start_at, presence: true
  validates :name, presence: true
  validates :kind, presence: true

  enum status: { boarding: 0, voting: 1, display_result: 2 }

  def final_result
    place1_votes = participations.where(place: places[0])
    place2_votes = participations.where(place: places[1])
    place3_votes = participations.where(place: places[2])
    self.selected_place = [place1_votes, place2_votes, place3_votes].sort_by { |votes| votes.length }.last.first.place
  end

  def barycenter
    latitudes = []
    longitudes = []
    participations.each do |participation|
      next if participation.latitude.nil?
      next if participation.longitude.nil?

      latitudes << participation.latitude
      longitudes << participation.longitude
    end
    return nil if latitudes.empty?

    [(latitudes.sum / latitudes.size), (longitudes.sum / longitudes.size)].join(',')
  end

  def set_places
    location = "location=#{barycenter}"
    rankby = "&rankby=distance"
    type = "&type=#{kind}"
    key = "&key=#{ENV['GOOGLE_PLACES_API_KEY']}"

    parameters = "#{location}#{rankby}#{type}#{key}"

    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?#{parameters}"

    places_serialized = open(url).read
    places_parsed = JSON.parse(places_serialized)

    places = places_parsed["results"].first(3)
    places.each do |place|
      data = {
        google_id: place["place_id"],
        name: place["name"],
        rating: place["rating"]
      }
      create_place(data)
    end
  end

  def create_place(data)
    place = places.new(data)
    details = get_details(place)
    place.address = details["result"]["formatted_address"]
    place.save
  end

  def get_details(establishment)
    key = "&key=#{ENV['GOOGLE_PLACES_API_KEY']}"
    fields = "&fields=formatted_address,icon,formatted_phone_number,website,reviews"

    parameters2 = "place_id=#{establishment.google_id}#{fields}#{key}"

    url_detail = "https://maps.googleapis.com/maps/api/place/details/json?#{parameters2}"

    details_serialized = open(url_detail).read
    JSON.parse(details_serialized)
  end
end
