class EventsController < ApplicationController
  before_action only: %i[edit update destroy]
  before_action :authenticate_user!

  expose :events, -> { current_user.events.decorate }
  expose :event, decorate: ->(event){ EventDecorator.new(event) }

  def create
    event.user_id = current_user.id
    if event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def update
    if event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name_of_event, :date_event, :start_of_event, :end_of_event, :regularity)
  end
end
