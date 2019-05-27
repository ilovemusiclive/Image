class PostsController < ApplicationController

before_action :authenticate_user!, only: [:new, :edit]
before_action :find_post,only:[:show, :edit, :update, :destroy]



def index
    if params[:manufacturer].blank? || [:modell].blank? || [:event].blank?
      @posts = Post.all.order("created_at DESC")
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
    @post = current_user.posts.build
    @car = Car.new
    @manufacturers = Manufacturer.all.map{ |c| [c.name, c.id]}
    @modells = Modell.all.map{ |b| [b.name, b.id]}
    @events = Event.all.map{ |e| [e.name, e.id]}
  end

  def create
    @post = current_user.posts.build(post_params)
    @car.manufacturer_id = params[:manufacturer_id]
    @car.modell_id = params[:modell_id]
    @car.event_id = params[:event_id]
      if @post.save
        redirect_to posts_path
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
    @post.car_id = params[:car_id]
    @car.manufacturer_id = params[:manufacturer_id]
    @car.modell_id = params[:modell_id]
    @car.event_id = params[:event_id]

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :car_id, :manufacturer_id, :modell_id, :event_id)
  end
end
