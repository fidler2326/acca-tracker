class DashboardController < ApplicationController
  include DashboardHelper

  before_action :authenticate_user!

  def index
    @accas = Acca.where(build_query)
  end

  private

  def build_query
    conditions = []
    values = []

    conditions << "date BETWEEN ? AND ?"

    unless params[:date_from].blank? && params[:date_to].blank?
      values << Time.zone.parse(params[:date_from]).utc.strftime('%Y-%m-%d') rescue params[:date_from]
      values << Time.zone.parse(params[:date_to]).utc.strftime('%Y-%m-%d') rescue params[:date_to]
    else
      values << "#{Date.current.year}-08-01"
      values << Date.today.strftime('%Y-%m-%d')
    end

    return [conditions.join(" and "), *values]
  end
end