class LandingController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    render :layout => "empty"
  end

end
