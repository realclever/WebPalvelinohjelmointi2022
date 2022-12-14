class PlacesController < ApplicationController
  def index
  end

  def show
    @place = BeermappingApi.places_in(session[:city]).find { |p| p.id == params[:id] }
    @weather = BeerweatherApi.places_in(session[:city]).find { |w| w.id == params[:id] }
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = BeerweatherApi.places_in(params[:city])
    session[:city] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end
end
