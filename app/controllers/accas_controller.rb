require 'nokogiri'

class AccasController < ApplicationController
  include AccasHelper
  before_action :authenticate_user!

  def index
    accas = current_user.accas.order("date DESC").group_by{|a| a.date}
    @accas = Kaminari.paginate_array(accas, total_count: accas.count).page(params[:page]).per(7)
  end

  def new
    @acca = Acca.new
  end

  def import

  end

  def import_acca
    html = Nokogiri::HTML(params[:acca_html])

    acca_date   = Date.parse(html.css('.bet-confirmation-header-datetime').text.downcase.strip)
    acca_type   = get_bet_type(html.css('.bet-confirmation-breakdown-link').text.downcase.gsub('bet type:', '').strip)
    acca_stake  = html.css('.bet-confirmation-info-table-value').first.text.downcase.gsub('£','').strip
    acca_return = html.css('.bet-confirmation-info-table-footer-value').text.downcase.gsub('to return £','').gsub('return £','').gsub('net return £','').strip

    Acca.create!(
      date: acca_date,
      category: Acca::Category::FOOTBALL,
      bet_type: acca_type,
      stake: acca_stake.to_f,
      return: acca_return.to_f,
      user_id: current_user.id
    )

    legs = html.css('.bet-confirmation-details-item')
    legs.each do |leg|
      selection  = get_selection(leg.css('.bet-confirmation-details-row-selectionname').text.gsub('Draw Or ','').gsub('Or Draw','').strip)
      odds       = leg.css('.bet-confirmation-details-row-odds').text.downcase.strip
      event      = leg.css('.bet-confirmation-details-row-eventname').text.gsub(/\d+/,'').gsub('/','').strip
      leg_type   = get_leg_type(leg.css('.bet-confirmation-details-row-plbtdescription').text.downcase.strip)
      leg_result = leg.css('.bet-confirmation-details-row-status').text.downcase.strip

      Leg.create!(
        acca_id:   Acca.last.id,
        leg_type:  leg_type,
        selection: selection,
        event:     event,
        won:       leg_result == 'won',
        placed:    nil,
        lost:      leg_result == 'lost',
        void:      leg_result == 'void',
        course:    nil,
        race_time: nil,
        odds: odds
      )
    end
    @acca = Acca.last
  end

  def create
    Acca.create!(date: params[:acca][:date], category: params[:acca][:category], bet_type: params[:acca][:bet_type], stake: params[:acca][:stake], return: params[:acca][:return], user_id: current_user.id)
    params[:acca][:legs_attributes].each do |k,leg|
      selection = get_selection leg[:selection]
      opponent = get_selection leg[:opponent]
      Leg.create!(
        acca_id:   Acca.last.id,
        leg_type:  leg[:leg_type],
        selection: selection,
        opponent:  opponent,
        won:       leg[:won],
        placed:    leg[:placed],
        lost:      leg[:lost],
        void:      leg[:void],
        course:    leg[:course],
        race_time: leg[:race_time]
      )
    end
    redirect_to accas_path
  end

  def get_selection selection_name
    selection = Selection.where(name: selection_name).first.id rescue nil
    unless selection.present? || selection_name.blank?
      Selection.create(name: selection_name)
      selection = Selection.last.id
    end
    return selection
  end

  def edit
    @acca = Acca.find(params[:id])
  end

  def update
    @acca = Acca.find(params[:id])
    respond_to do |format|
      if @acca.update(acca_params)
        format.html { redirect_to accas_path, notice: 'Acca was successfully updated.' }
        format.json { render :index, status: :ok, location: @acca }
      else
        flash.now[:alert] = @acca.errors.full_messages
        format.html { render :edit }
        format.json { render json: @acca.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @acca = Acca.find(params[:id])
  end

  def destroy
    @acca = Acca.find(params[:id])
    @acca.destroy
    respond_to do |format|
      format.html { redirect_to accas_path, notice: 'Acca was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_acca
    @acca = Acca.find(params[:id])
  end

  private
  def acca_params
    params.require(:acca).permit(:date, :category, :bet_type, :stake, :return, legs_attributes: [:id, :leg_type, :selection, :event, :won, :placed, :lost, :void, :odds, :_destroy])
  end
end