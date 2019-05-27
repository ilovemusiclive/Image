class ModellsController < ApplicationController

  before_action :find_modell,only:[:show, :edit, :update, :destroy]

  def index
    @modells = Modell.all.order("created_at DESC")
  end

  def new
    @modell = Modell.new
  end

  def create
    @modell = Modell.new(modell_params)
      if @modell.save
        redirect_to modells_path
      else
        render "new"
      end
  end

  def show

  end

  def edit

  end

  def update
    if @modell.update(modell_params)
      redirect_to modell_path(@modell)
    else
      render "edit"
    end
  end

  def destroy
    @modell.destroy
    redirect_to root_path
  end

  private

  def find_modell
    @modell = Modell.find(params[:id])
  end

  def modell_params
    params.require(:modell).permit(:name)
  end
end
