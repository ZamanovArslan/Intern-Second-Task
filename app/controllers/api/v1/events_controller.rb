module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!

      expose :events, -> { current_user.events }
      expose :event

      def index
        render json: current_user.decorate.events_by_params(params)
      end

      def create
        event.user_id = current_user.id
        if event.save
          render json: event
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end

      def destroy
        event.destroy
        render json: true
      end

      private

      def event_params
        params.require(:event).permit(:name_of_event, :date_event, :start_of_event, :end_of_event, :regularity)
      end
    end
  end
end
