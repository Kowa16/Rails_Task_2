class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  def index
    @rooms = Room.all.page(params[:page]).per(6)
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    @profile = Profile.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      redirect_to :rooms
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "ルームを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to :rooms
  end

  def search
    if params[:keyword].present?
      @rooms = Room.where(["address like? OR room_name like? OR introduction like?","%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    elsif params[:area].present?
      @rooms = Room.where(["address like?","%#{params[:area]}%"])
    end
    render "index"
  end

  private
  def room_params
    params.require(:room).permit(:room_name, :introduction, :price, :address, :user_id, :room_image)
  end

  def reservation_params
    params.require(:reservation).permit(:start_day, :end_day, :people, :user_id, :proom_id, :total_price)
  end

  def total_price(price,people)
    price*people
  end

end
