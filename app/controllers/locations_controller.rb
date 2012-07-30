require 'oauth2'
require 'facebook_oauth'

class LocationsController < ApplicationController

  CALLBACK_URL    = 'http://localhost:3000/locations/new'
  CONSUMER_KEY    = '429436863773560'
  CONSUMER_SECRET = 'ccd5453a473496ebd7ea258fae4c0fdf'

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def index
    @query = params
    @locations = Location.any_of({ :user => /.*#{params[:q_uname]}.*/, :memo => /.*#{params[:q_memo]}.*/, :browser => /.*#{params[:q_uagent]}.*/ })

    respond_to do |format|
      format.html
      format.json { render :json => @locations}
    end
  end

  def new
    @client = FacebookOAuth::Client.new(
      :application_id     => CONSUMER_KEY,
      :application_secret => CONSUMER_SECRET,
      :callback           => CALLBACK_URL
    )
    @client.authorize(:code => params[:code])
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      redirect_to(@location, :notice => 'Successfully Checked In!!')
    else
      render :action => "new"
    end  
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def checkin
    client = FacebookOAuth::Client.new(
      :application_id     => CONSUMER_KEY,
      :application_secret => CONSUMER_SECRET,
      :callback           => CALLBACK_URL
    )
    redirect_to client.authorize_url
  end
end
