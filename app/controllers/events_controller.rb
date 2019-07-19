class EventsController < ApplicationController
  before_action only: %i[show edit update destroy]
  before_action :authenticate_user!

  expose :events, -> { current_user.events }
  expose :event

  def create
    event.user_id = current_user.id
    if event.save
      redirect_to event
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
