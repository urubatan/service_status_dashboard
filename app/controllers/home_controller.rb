class HomeController < ApplicationController
  def index
    @services = Service.order('current_status asc').all
  end
end