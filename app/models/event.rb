require "open-uri"

class Event < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :places

  validates :name, presence: true
  validates :kind, presence: true
  validates_datetime :start_at, after: :now, after_message: "must be in the future"

  enum status: { boarding: 0, voting: 1, display_result: 2 }
  enum kind: { bar: 0, restaurant: 1 }

  def chosen_place
    places.find_by(chosen: true)
  end

  def final_result!
    place1_votes = participations.where(place: places[0])
    place2_votes = participations.where(place: places[1])
    place3_votes = participations.where(place: places[2])

    if place1_votes.empty? && place2_votes.empty? && place3_votes.empty?
      chosen_place = places.first
    else
      chosen_place = [place1_votes, place2_votes, place3_votes].sort_by { |votes| votes.length }.last.first.place
    end
    chosen_place.chosen = true
    chosen_place.save
  end

  def process_barycenter
    latitudes = []
    longitudes = []
    participations.each do |participation|
      next if participation.latitude.nil?
      next if participation.longitude.nil?

      latitudes << participation.latitude
      longitudes << participation.longitude
    end
    return nil if latitudes.empty?

    [(latitudes.sum / latitudes.size), (longitudes.sum / longitudes.size)]
  end

  def barycenter
    process_barycenter.join(',')
  end

  def set_places
    @client = GooglePlaces::Client.new(ENV['GOOGLE_PLACES_API_KEY'])
    spots = @client.spots(barycenter.split(",").first.to_f,barycenter.split(",").last.to_f, :types => kind, :rankby => 'distance')
    places = spots.select { |spot| !spot.rating.nil? }.first(3)
    places.each do |place|
      data = {
        google_id: place.place_id,
        name: place.name,
        rating: place.rating,
        latitude: place.lat,
        longitude: place.lng
      }
      create_place(data)
    end
  end

  def create_place(data)
    place = places.new(data)
    details = get_details(place)
    place.address = details.formatted_address
    if details.photos[0]
      place.photo = details.photos[0].fetch_url(800)
    else
      place.photo = "https://cl.buscafs.com/www.metatube.com/public/uploads/images/418337.jpg"
    end
    place.save
  end

  def get_details(establishment)
    @client = GooglePlaces::Client.new(ENV['GOOGLE_PLACES_API_KEY'])
    @client.spot(establishment.google_id)
  end

  # def no_votes?
  #   # Event.first.participations.first.place
  #   votes = []
  #   @event.participations.each do |participation|
  #     votes << participation unless participation.place.nil?
  #   end
  #   votes.empty?
  # end
end









