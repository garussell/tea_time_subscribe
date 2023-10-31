class Api::V0::TeasController < ApplicationController
  def index
    teas = SpoonacularFacade.get_teas(params[:query])
    render json: SerializedResults.new(teas) 
  end
end