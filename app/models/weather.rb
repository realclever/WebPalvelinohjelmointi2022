class Weather < OpenStruct
  def self.rendered_fields
    [:temperature, :weather_icons, :weather_descriptions, :wind_speed, :wind_dir, :humidity, :feelslike, :uv_index]
  end
end
