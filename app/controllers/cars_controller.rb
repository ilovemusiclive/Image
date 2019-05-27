class CarsController < ApplicationController

before_action :authenticate_user!, only: [:new, :edit]
before_action :find_car,only:[:show, :edit, :update, :destroy]



  def index
    if params[:manufacturer].blank? || [:modell].blank? || [:event].blank?
      @cars = Car.all.order("created_at DESC")
    else
      @manufacturer_id = Manufacturer.find_by(name: params[:manufacturer]).id
      @modell_id = Modell.find_by(name: params[:modell]).id
      @event_id = Event.find_by(name: params[:event]).id

      @cars = Car.where(:manufacturer_id => @manufacturer_id).order("created_at DESC")
      @cars = Car.where(:modell_id => @modell_id).order("created_at DESC")
      @cars = Car.where(:event_id => @event_id).order("created_at DESC")
    end
  end

  def new
    @car = current_user.cars.build
    @manufacturers = Manufacturer.all.map{ |c| [c.name, c.id]}
    @modells = Modell.all.map{ |b| [b.name, b.id]}
    @events = Event.all.map{ |e| [e.name, e.id]}
  end

  def create
    @car = current_user.cars.build(car_params)
    @car.manufacturer_id = params[:manufacturer_id]
    @car.modell_id = params[:modell_id]
    @car.event_id = params[:event_id]
      if @car.save
        redirect_to cars_path
      else
        render "new"
      end
  end

  def show

  end

  def edit
    @manufacturers = Manufacturer.all.map{ |c| [c.name, c.id]}
    @modells = Modell.all.map{ |b| [b.name, b.id]}
    @events = Event.all.map{ |e| [e.name, e.id]}
  end

  def update
    @car.manufacturer_id = params[:manufacturer_id]
    @car.modell_id = params[:modell_id]
    @car.event_id = params[:event_id]

    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render 'edit'
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_path
  end

private

def find_car
@car = Car.find(params[:id])
end

def car_params
params.require(:car).permit(:description, :manufacturer_id, :modell_id, :event_id, :user_id)
end

end
