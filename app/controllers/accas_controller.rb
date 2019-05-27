class AccasController < ApplicationController
  include AccasHelper

  before_action :authenticate_user!

  def index
    @accas = current_user.accas
  end

  def new
    @acca = Acca.new
  end

  def create
    Acca.create!(date: params[:acca][:date], category: params[:acca][:category], bet_type: params[:acca][:bet_type], stake: params[:acca][:stake], return: params[:acca][:return], user_id: current_user.id)
    params[:acca][:legs_attributes].each do |k,leg|
      selection = get_selection leg[:selection]
      opponent = get_selection leg[:opponent]
      Leg.create!(acca_id: Acca.last.id, leg_type: leg[:leg_type], selection: selection, opponent: opponent, won: leg[:won], placed: leg[:placed], lost: leg[:lost], void: leg[:void])
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
    respond_to do |format|
      if @acca.update(acca_params)
        format.html { redirect_to @acca, notice: 'Acca was successfully updated.' }
        format.json { render :show, status: :ok, location: @acca }
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
    @acca.destroy
    respond_to do |format|
      format.html { redirect_to accas_path, notice: 'Acca was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def acca_params
    params.require(:acca).permit(:date, :category, :type, :stake, :return, legs_attributes: [:id, :type, :selection, :opponent, :won, :placed, :lost, :void, :_destroy])
  end
end