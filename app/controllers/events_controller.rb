class EventsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  expose :events, -> {Event.all}
  expose :event

  def index
    if params[:q]
      render json: Event.where('name_of_event LIKE ? AND user_id = ?', "%#{params[:q]}%", current_user.id)
    elsif params[:date_event]
      render json: Event.is_available(Date.parse(params[:date_event]), current_user.id)
    end
  end

  def create
    event.user_id = current_user.id
    if event.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if event.update(event_params)
      redirect_to event_path(event)
    else
      render :edit
    end
  end

  def destroy
    event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:name_of_event, :date_event, :start_of_event, :end_of_event, :regularity)
  end
end
