class BeerweatherApi
  def self.places_in(city)
    city = city.downcase
    # Rails.cache.fetch(city, expires_in: 7.days) { get_weathers_in(city) }
    get_weathers_in(city)
  end

  def self.get_weathers_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    return nil if response["current"].nil?

    Weather.new(response["current"])
  end

  def self.key
    return nil if Rails.env.test?
    raise 'BEERWEATHER_APIKEY env variable not defined' if ENV['BEERWEATHER_APIKEY'].nil?

    ENV.fetch('BEERWEATHER_APIKEY')
  end
end
