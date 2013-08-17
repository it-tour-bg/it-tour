class SpeakersController < ApplicationController
  def show
    @speaker = Speaker.find(params[:id])
  end
end
