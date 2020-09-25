module Api
  module V1
    class EventsController < ApplicationController

      def show
        event = Event.find(params[:id])
        if event
          render json: EventSerializer.new(event)
        else
          raise ActiveRecord::RecordNotFound
        end
      end

      def create
        event = Event.new(event_params)
        if event.save
          render json: EventSerializer.new(event), status: 201
        else
          json_response(event.errors.messages.to_json, status: 422)
        end
      end

      private

      def event_params
        params.require(:event).permit(:id, :name, :description, :date, :time)
      end
    end
  end
end
