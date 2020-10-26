# frozen_string_literal: true

class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: %i[show]

  def index
    return [] if no_latitudes?

    @stores = Store.within(params[:latitude].to_f, params[:longitude].to_f)
                   .sort_by(&:ratings_average)
                   .reverse
  end

  def show; end

  private

  def no_latitudes?
    params[:latitude].nil? || params[:longitude].nil?
  end

  def set_store
    @store = Store.find_by!(google_place_id: params[:id])
  end
end
