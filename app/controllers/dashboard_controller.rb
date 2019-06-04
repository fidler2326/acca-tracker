class DashboardController < ApplicationController
  include DashboardHelper

  before_action :authenticate_user!

  def index

  end
end