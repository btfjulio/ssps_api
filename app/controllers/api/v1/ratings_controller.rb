
class Api::V1::RatingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create 
    ActiveRecord::Base.transaction do
    puts params

      create_store
      create_rating
      render json: @rating
    end
  end

  private

  def create_rating
    @rating = Rating.new(rating_params)
    @rating.store = @store
    @rating.save!
  end

  def create_store 
    puts "PARMS: #{rating_params}"
    @store = Store.find_or_create_by!(
      lonlat: "POINT(#{params[:store][:longitude].to_f} #{params[:store][:latitude].to_f})",
      name: params[:store][:name],
      address: params[:store][:address],
      google_place_id: params[:store][:google_place_id]
    )
  end

  def rating_params
    params.require(:rating).permit(:opinion, :value, :user_name)
  end
end