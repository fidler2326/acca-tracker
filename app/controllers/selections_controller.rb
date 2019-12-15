class SelectionsController < ApplicationController
  include SelectionsHelper
  before_action :authenticate_user!

  def index
    @selections = Selection.all.order("name ASC")
  end

  def new
    @selection = Selection.new
  end

  def create

  end

  def edit
    @selection = Selection.find(params[:id])
    @selection_accas = Acca.includes(:legs).where("legs.selection = ?", @selection.id).references(:legs)
  end

  def update
    @selection = Selection.find(params[:id])
    respond_to do |format|
      if @selection.update(selection_params)
        format.html { redirect_to selections_path, notice: 'Selection was successfully updated.' }
        format.json { render :show, status: :ok, location: @selection }
      else
        flash.now[:alert] = @selection.errors.full_messages
        format.html { render :edit }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @selection = Selection.find(params[:id])
  end

  def destroy
    @selection = Selection.find(params[:id])
    @selection.destroy
    respond_to do |format|
      format.html { redirect_to selections_path, notice: 'Selection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def selection_params
    params.require(:selection).permit(:name, :category, :hidden)
  end
end