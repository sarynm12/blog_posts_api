class Api::PingsController < ApplicationController

  def show
    render json: { success: true } 
  end
end